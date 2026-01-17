import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helpers.dart';
import 'currency_bloc_test_setup.dart';

void main() {
  late CurrencyBlocTestSetup setup;

  setUpAll(CurrencyBlocTestSetup.registerFallbacks);

  setUp(() {
    setup = CurrencyBlocTestSetup();
    setup.initMocks();
  });

  tearDown(() => setup.dispose());

  group('FromCurrencySelected', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'updates fromCurrency and recalculates toAmount',
      setUp: () => setup.setupSaveFromCurrencySuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromCurrencySelected(TestData.gbpCurrency)),
      expect: () => [
        isA<CurrencyState>()
            .having(
              (s) => s.fromCurrency,
              'fromCurrency',
              TestData.gbpCurrency,
            )
            .having((s) => s.toAmountText, 'toAmountText', isNotEmpty),
      ],
      verify: (_) {
        verify(
          () => setup.mockSaveSelectedFromCurrency(
            any(that: isA<SaveCurrencyParams>()),
          ),
        ).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'saves selected currency code to storage',
      setUp: () => setup.setupSaveFromCurrencySuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromCurrencySelected(TestData.jpyCurrency)),
      verify: (_) {
        final captured = verify(
          () => setup.mockSaveSelectedFromCurrency(captureAny()),
        ).captured;
        expect((captured.first as SaveCurrencyParams).currencyCode, 'JPY');
      },
    );
  });

  group('ToCurrencySelected', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'updates toCurrency and recalculates toAmount',
      setUp: () => setup.setupSaveToCurrencySuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(ToCurrencySelected(TestData.jpyCurrency)),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.toCurrency, 'toCurrency', TestData.jpyCurrency)
            .having((s) => s.toAmountText, 'toAmountText', isNotEmpty),
      ],
      verify: (_) {
        final captured = verify(
          () => setup.mockSaveSelectedToCurrency(captureAny()),
        ).captured;
        expect((captured.first as SaveCurrencyParams).currencyCode, 'JPY');
      },
    );
  });

  group('CurrenciesSwapped', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'swaps from and to currencies and amounts',
      setUp: () => setup.setupSwapSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
        toAmountText: '85',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrenciesSwapped()),
      expect: () => [
        isA<CurrencyState>()
            .having(
              (s) => s.fromCurrency,
              'fromCurrency',
              TestData.eurCurrency,
            )
            .having((s) => s.toCurrency, 'toCurrency', TestData.usdCurrency)
            .having((s) => s.fromAmountText, 'fromAmountText', '85'),
      ],
      verify: (_) {
        verify(() => setup.mockSaveSelectedFromCurrency(any())).called(1);
        verify(() => setup.mockSaveSelectedToCurrency(any())).called(1);
        verify(() => setup.mockSaveFromAmount(any())).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'does nothing when currencies are null',
      seed: () => const CurrencyState(
        rates: [],
        fromCurrency: null,
        toCurrency: null,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrenciesSwapped()),
      expect: () => [],
      verify: (_) {
        verifyNever(() => setup.mockSaveSelectedFromCurrency(any()));
        verifyNever(() => setup.mockSaveSelectedToCurrency(any()));
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'does nothing when only from currency is null',
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: null,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrenciesSwapped()),
      expect: () => [],
    );
  });
}
