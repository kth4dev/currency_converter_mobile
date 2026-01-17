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

  group('FromAmountChanged', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'updates fromAmount and calculates toAmount',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('100')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 100.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '100')
            .having((s) => s.toAmountText, 'toAmountText', '85'),
      ],
      verify: (_) {
        final captured = verify(
          () => setup.mockSaveFromAmount(captureAny()),
        ).captured;
        expect((captured.first as SaveFromAmountParams).amount, 100.0);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles empty text input',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
        toAmountText: '85',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '')
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles invalid text input gracefully',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('abc')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles decimal amounts correctly',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('100.50')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 100.50)
            .having((s) => s.fromAmountText, 'fromAmountText', '100.50'),
      ],
    );
  });

  group('FromAmountChanged edge cases', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'handles very large numbers without overflow',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('999999999')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 999999999.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '999999999'),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles leading zeros correctly',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('007')),
      expect: () => [
        isA<CurrencyState>().having((s) => s.fromAmount, 'fromAmount', 7.0),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles zero amount correctly',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
        toAmountText: '85',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('0')),
      expect: () => [
        // When amount is 0, toAmountText is cleared (empty string)
        // This is consistent with the empty input behavior
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '0')
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles whitespace input as invalid',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('   ')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles multiple decimal points as invalid',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('10.50.25')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles very small decimal amounts',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(FromAmountChanged('0.01')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.01)
            .having((s) => s.fromAmountText, 'fromAmountText', '0.01'),
      ],
    );
  });

  group('ToAmountChanged', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'calculates fromAmount from toAmount (reverse conversion)',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(ToAmountChanged('85')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.toAmountText, 'toAmountText', '85')
            .having((s) => s.fromAmountText, 'fromAmountText', '100'),
      ],
      verify: (_) {
        verify(() => setup.mockSaveFromAmount(any())).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'handles empty toAmount input',
      setUp: () => setup.setupSaveFromAmountSuccess(),
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
        toAmountText: '85',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(ToAmountChanged('')),
      expect: () => [
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 0.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '')
            .having((s) => s.toAmountText, 'toAmountText', ''),
      ],
    );
  });
}
