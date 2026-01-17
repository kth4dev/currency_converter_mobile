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

  group('CurrencyConverterStarted', () {
    blocTest<CurrencyBloc, CurrencyState>(
      'emits states with rates, selected currencies, and updated date '
      'when started successfully',
      setUp: () => setup.setupSuccessfulStarted(),
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyConverterStarted()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        // First: offline rates loaded
        isA<CurrencyState>().having(
          (s) => s.rates,
          'rates',
          TestData.mockRates,
        ),
        // Selected currencies loaded
        isA<CurrencyState>()
            .having((s) => s.fromCurrency?.code, 'fromCurrency', 'USD')
            .having((s) => s.toCurrency?.code, 'toCurrency', 'EUR'),
        // Amount loaded with toAmountText calculated
        isA<CurrencyState>()
            .having((s) => s.fromAmount, 'fromAmount', 1.0)
            .having((s) => s.fromAmountText, 'fromAmountText', '1')
            .having((s) => s.toAmountText, 'toAmountText', isNotEmpty),
        // Updated date loaded
        isA<CurrencyState>().having(
          (s) => s.updatedDate,
          'updatedDate',
          TestData.updatedDate,
        ),
        // Loading state when refreshing
        isA<CurrencyState>().having(
          (s) => s.loadState,
          'loadState',
          isA<Loading>(),
        ),
        // Success after refresh
        isA<CurrencyState>().having(
          (s) => s.loadState,
          'loadState',
          isA<Success>(),
        ),
      ],
      verify: (_) {
        verify(() => setup.mockGetOfflineLatestRates(any())).called(1);
        verify(() => setup.mockGetSelectedFromCurrency(any())).called(1);
        verify(() => setup.mockGetSelectedToCurrency(any())).called(1);
        verify(() => setup.mockGetFromAmount(any())).called(1);
        verify(() => setup.mockGetUpdatedDate(any())).called(2);
        verify(() => setup.mockGetLatestRates(any())).called(1);
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'defaults to USD and EUR when no saved selection exists',
      setUp: () {
        when(
          () => setup.mockGetOfflineLatestRates(any()),
        ).thenAnswer((_) async => TestData.mockRates.asOk);
        when(() => setup.mockGetSelectedFromCurrency(any())).thenAnswer(
          (_) async => const Result.fail(
            errorMessage: 'Not found',
            errorType: ErrorType.notFound,
          ),
        );
        when(() => setup.mockGetSelectedToCurrency(any())).thenAnswer(
          (_) async => const Result.fail(
            errorMessage: 'Not found',
            errorType: ErrorType.notFound,
          ),
        );
        when(() => setup.mockGetFromAmount(any())).thenAnswer(
          (_) async => const Result.fail(
            errorMessage: 'Not found',
            errorType: ErrorType.notFound,
          ),
        );
        when(
          () => setup.mockGetUpdatedDate(any()),
        ).thenAnswer((_) async => TestData.updatedDate.asOk);
        when(
          () => setup.mockGetLatestRates(any()),
        ).thenAnswer((_) async => TestData.mockRates.asOk);
      },
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyConverterStarted()),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        expect(setup.currencyBloc.state.fromCurrency?.code, 'USD');
        expect(setup.currencyBloc.state.toCurrency?.code, 'EUR');
      },
    );

    blocTest<CurrencyBloc, CurrencyState>(
      'still triggers refresh even when offline rates fail',
      setUp: () {
        when(() => setup.mockGetOfflineLatestRates(any())).thenAnswer(
          (_) async => const Result.fail(
            errorMessage: 'No cached data',
            errorType: ErrorType.notFound,
          ),
        );
        when(
          () => setup.mockGetLatestRates(any()),
        ).thenAnswer((_) async => TestData.mockRates.asOk);
        when(
          () => setup.mockGetUpdatedDate(any()),
        ).thenAnswer((_) async => TestData.updatedDate.asOk);
      },
      build: () => setup.currencyBloc,
      act: (bloc) => bloc.add(CurrencyConverterStarted()),
      wait: const Duration(milliseconds: 100),
      verify: (_) {
        verify(() => setup.mockGetLatestRates(any())).called(1);
      },
    );
  });
}
