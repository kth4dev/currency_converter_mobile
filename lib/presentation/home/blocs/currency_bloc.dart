import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/core/utils/currency_utils.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetOfflineLatestRates getOfflineLatestRates;
  final GetLatestRates getLatestRates;
  final GetUpdatedDate getUpdatedDate;
  final GetSelectedFromCurrency getSelectedFromCurrency;
  final GetSelectedToCurrency getSelectedToCurrency;
  final SaveSelectedFromCurrency saveSelectedFromCurrency;
  final SaveSelectedToCurrency saveSelectedToCurrency;
  final GetFromAmount getFromAmount;
  final SaveFromAmount saveFromAmount;

  CurrencyBloc(
    this.getOfflineLatestRates,
    this.getLatestRates,
    this.getUpdatedDate,
    this.getSelectedFromCurrency,
    this.getSelectedToCurrency,
    this.saveSelectedFromCurrency,
    this.saveSelectedToCurrency,
    this.getFromAmount,
    this.saveFromAmount,
  ) : super(const CurrencyState()) {
    on<CurrencyConverterStarted>(_onStarted);
    on<CurrencyRatesRefreshed>(_onRatesRefreshed);
    on<FromCurrencySelected>(_onFromCurrencySelected);
    on<ToCurrencySelected>(_onToCurrencySelected);
    on<CurrenciesSwapped>(_onCurrenciesSwapped);
    on<FromAmountChanged>(_onFromAmountChanged);
    on<ToAmountChanged>(_onToAmountChanged);
  }

  Future<void> _onStarted(
    CurrencyConverterStarted event,
    Emitter<CurrencyState> emit,
  ) async {
    final offlineRates = await getOfflineLatestRates.call(const NoParams());

    if (offlineRates case Ok(value: final rates)) {
      emit(state.copyWith(rates: rates));
      await _loadSavedSelections(emit, rates);
      await _loadSavedAmount(emit);
      await _loadUpdatedDate(emit);
    }

    add(CurrencyRatesRefreshed());
  }

  Future<void> _onRatesRefreshed(
    CurrencyRatesRefreshed event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(state.copyWith(loadState: const Loading()));

    final result = await getLatestRates.call(const NoParams());

    switch (result) {
      case Ok(value: final rates):
        final from = _findCurrencyByCode(rates, state.fromCurrency?.code);
        final to = _findCurrencyByCode(rates, state.toCurrency?.code);

        await _loadUpdatedDate(emit);

        emit(
          state.copyWith(
            loadState: const Success(),
            rates: rates,
            fromCurrency: from ?? state.fromCurrency,
            toCurrency: to ?? state.toCurrency,
            toAmountText: _convertToAmount(state.fromAmountText, from, to),
          ),
        );

      case Fail(:final errorMessage, :final errorType):
        emit(
          state.copyWith(
            loadState: Failure(message: errorMessage, type: errorType),
          ),
        );
    }
  }

  Future<void> _onFromCurrencySelected(
    FromCurrencySelected event,
    Emitter<CurrencyState> emit,
  ) async {
    final toAmount = _convertToAmount(
      state.fromAmountText,
      event.currency,
      state.toCurrency,
    );

    emit(state.copyWith(fromCurrency: event.currency, toAmountText: toAmount));
    await saveSelectedFromCurrency.call(
      SaveCurrencyParams(event.currency.code),
    );
  }

  Future<void> _onToCurrencySelected(
    ToCurrencySelected event,
    Emitter<CurrencyState> emit,
  ) async {
    final toAmount = _convertToAmount(
      state.fromAmountText,
      state.fromCurrency,
      event.currency,
    );

    emit(state.copyWith(toCurrency: event.currency, toAmountText: toAmount));
    await saveSelectedToCurrency.call(SaveCurrencyParams(event.currency.code));
  }

  Future<void> _onCurrenciesSwapped(
    CurrenciesSwapped event,
    Emitter<CurrencyState> emit,
  ) async {
    final from = state.fromCurrency;
    final to = state.toCurrency;
    if (from == null || to == null) return;

    final newFromText = state.toAmountText;
    final newFromAmount = double.tryParse(newFromText) ?? 0;
    final newToText = _convertToAmount(newFromText, to, from);

    emit(
      state.copyWith(
        fromCurrency: to,
        toCurrency: from,
        fromAmount: newFromAmount,
        fromAmountText: newFromText,
        toAmountText: newToText,
      ),
    );

    await Future.wait([
      saveSelectedFromCurrency.call(SaveCurrencyParams(to.code)),
      saveSelectedToCurrency.call(SaveCurrencyParams(from.code)),
      saveFromAmount.call(SaveFromAmountParams(newFromAmount)),
    ]);
  }

  Future<void> _onFromAmountChanged(
    FromAmountChanged event,
    Emitter<CurrencyState> emit,
  ) async {
    final amount = double.tryParse(event.text) ?? 0;
    final toAmount = _convertToAmount(
      event.text,
      state.fromCurrency,
      state.toCurrency,
    );

    emit(
      state.copyWith(
        fromAmount: amount,
        fromAmountText: event.text,
        toAmountText: toAmount,
      ),
    );

    await saveFromAmount.call(SaveFromAmountParams(amount));
  }

  Future<void> _onToAmountChanged(
    ToAmountChanged event,
    Emitter<CurrencyState> emit,
  ) async {
    final fromText = _convertFromAmount(
      event.text,
      state.fromCurrency,
      state.toCurrency,
    );
    final fromAmount = double.tryParse(fromText) ?? 0;

    emit(
      state.copyWith(
        fromAmount: fromAmount,
        fromAmountText: fromText,
        toAmountText: event.text,
      ),
    );

    saveFromAmount.call(SaveFromAmountParams(fromAmount));
  }

  String _convertToAmount(
    String fromText,
    CurrencyRateEntity? from,
    CurrencyRateEntity? to,
  ) {
    if (from == null || to == null) return '';

    final amount = double.tryParse(fromText) ?? 0;
    if (amount == 0) return '';

    final converted = CurrencyUtils.convert(amount: amount, from: from, to: to);
    return CurrencyUtils.formatAmount(converted);
  }

  String _convertFromAmount(
    String toText,
    CurrencyRateEntity? from,
    CurrencyRateEntity? to,
  ) {
    if (from == null || to == null) return '';

    final amount = double.tryParse(toText) ?? 0;
    if (amount == 0) return '';

    final converted = CurrencyUtils.convert(amount: amount, from: to, to: from);
    return CurrencyUtils.formatAmount(converted);
  }

  Future<void> _loadSavedSelections(
    Emitter<CurrencyState> emit,
    List<CurrencyRateEntity> rates,
  ) async {
    final fromResult = await getSelectedFromCurrency.call(const NoParams());
    final toResult = await getSelectedToCurrency.call(const NoParams());

    final fromCode = fromResult is Ok<String> ? fromResult.value : null;
    final toCode = toResult is Ok<String> ? toResult.value : null;

    final from =
        _findCurrencyByCode(rates, fromCode) ??
        _findCurrencyByCode(rates, 'USD') ??
        rates.firstOrNull;

    final to =
        _findCurrencyByCode(rates, toCode) ??
        _findCurrencyByCode(rates, 'EUR') ??
        (rates.length > 1 ? rates[1] : rates.firstOrNull);

    emit(state.copyWith(fromCurrency: from, toCurrency: to));
  }

  Future<void> _loadSavedAmount(Emitter<CurrencyState> emit) async {
    final result = await getFromAmount.call(const NoParams());

    if (result case Ok(value: final amount)) {
      final fromText = CurrencyUtils.formatAmount(amount);
      final toText = _convertToAmount(
        fromText,
        state.fromCurrency,
        state.toCurrency,
      );

      emit(
        state.copyWith(
          fromAmount: amount,
          fromAmountText: fromText.isEmpty ? '1' : fromText,
          toAmountText: toText,
        ),
      );
    }
  }

  Future<void> _loadUpdatedDate(Emitter<CurrencyState> emit) async {
    final result = await getUpdatedDate.call(const NoParams());

    if (result case Ok(value: final date)) {
      emit(state.copyWith(updatedDate: date));
    }
  }

  CurrencyRateEntity? _findCurrencyByCode(
    List<CurrencyRateEntity> rates,
    String? code,
  ) {
    if (code == null) return null;
    return rates.where((r) => r.code == code).firstOrNull;
  }
}
