import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/common/view_state.dart';
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

  group('CurrencyRatesRefreshed', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'emits Loading then Success with updated rates when refresh succeeds',
      setUp: () {
        when(
          () => setup.mockGetLatestRates(any()),
        ).thenAnswer((_) async => TestData.updatedMockRates.asOk);
        when(
          () => setup.mockGetUpdatedDate(any()),
        ).thenAnswer((_) async => TestData.updatedDate.asOk);
      },
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyRatesRefreshed()),
      expect: () => [
        isA<CurrencyState>().having(
          (s) => s.loadState,
          'loadState',
          isA<Loading>(),
        ),
        isA<CurrencyState>().having(
          (s) => s.updatedDate,
          'updatedDate',
          TestData.updatedDate,
        ),
        isA<CurrencyState>()
            .having((s) => s.loadState, 'loadState', isA<Success>())
            .having((s) => s.rates, 'rates', TestData.updatedMockRates),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'emits Loading then Failure when refresh fails',
      setUp: () {
        when(() => setup.mockGetLatestRates(any())).thenAnswer(
          (_) async => const Result.fail(
            errorMessage: 'Network error',
            errorType: ErrorType.network,
          ),
        );
      },
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyRatesRefreshed()),
      expect: () => [
        isA<CurrencyState>().having(
          (s) => s.loadState,
          'loadState',
          isA<Loading>(),
        ),
        isA<CurrencyState>().having(
          (s) => s.loadState,
          'loadState',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Network error')
              .having((f) => f.type, 'type', ErrorType.network),
        ),
      ],
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'preserves selected currencies with updated rates after refresh',
      setUp: () {
        when(
          () => setup.mockGetLatestRates(any()),
        ).thenAnswer((_) async => TestData.updatedMockRates.asOk);
        when(
          () => setup.mockGetUpdatedDate(any()),
        ).thenAnswer((_) async => TestData.updatedDate.asOk);
      },
      seed: () => const CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmountText: '100',
      ),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyRatesRefreshed()),
      verify: (_) {
        expect(setup.currencyBloc.state.fromCurrency?.code, 'USD');
        expect(setup.currencyBloc.state.toCurrency?.code, 'EUR');
        expect(setup.currencyBloc.state.fromCurrency?.rate, 1.0);
        expect(setup.currencyBloc.state.toCurrency?.rate, 0.90);
      },
    );
  });
}
