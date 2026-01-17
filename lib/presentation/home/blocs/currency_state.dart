part of 'currency_bloc.dart';

@immutable
class CurrencyState extends Equatable {
  final ViewState loadState;
  final CurrencyRateEntity? fromCurrency;
  final CurrencyRateEntity? toCurrency;
  final String? updatedDate;
  final List<CurrencyRateEntity> rates;
  final double fromAmount;
  final String fromAmountText;
  final String toAmountText;

  const CurrencyState({
    this.loadState = const Initial(),
    this.fromCurrency,
    this.toCurrency,
    this.updatedDate,
    this.rates = const [],
    this.fromAmount = 1.0,
    this.fromAmountText = '1',
    this.toAmountText = '',
  });

  CurrencyState copyWith({
    ViewState? loadState,
    CurrencyRateEntity? fromCurrency,
    CurrencyRateEntity? toCurrency,
    String? updatedDate,
    List<CurrencyRateEntity>? rates,
    double? fromAmount,
    String? fromAmountText,
    String? toAmountText,
  }) {
    return CurrencyState(
      loadState: loadState ?? this.loadState,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      updatedDate: updatedDate ?? this.updatedDate,
      rates: rates ?? this.rates,
      fromAmount: fromAmount ?? this.fromAmount,
      fromAmountText: fromAmountText ?? this.fromAmountText,
      toAmountText: toAmountText ?? this.toAmountText,
    );
  }

  @override
  List<Object?> get props => [
        loadState,
        fromCurrency,
        toCurrency,
        updatedDate,
        rates,
        fromAmount,
        fromAmountText,
        toAmountText,
      ];
}
