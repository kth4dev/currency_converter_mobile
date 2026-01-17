import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helpers.dart';
import 'splash_cubit_test_setup.dart';

void main() {
  late SplashCubitTestSetup setup;

  setUpAll(SplashCubitTestSetup.registerFallbacks);

  setUp(() {
    setup = SplashCubitTestSetup();
    setup.initMocks();
  });

  tearDown(() => setup.dispose());

  group('SplashCubit Error Scenarios', () {
    blocTest<SplashCubit, SplashState>(
      'emits Failure when getSupportedCurrencies fails',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(() => setup.mockGetSupportedCurrencies(any())).thenAnswer(
          (_) async => const Result<List<CurrencyInfoEntity>>.fail(
            errorMessage: 'Failed to fetch currencies',
            errorType: ErrorType.network,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Initial>(),
        ),
        isA<SplashState>().having(
          (s) => s.initProcessMessage,
          'message',
          'Getting available currencies...',
        ),
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Failed to fetch currencies')
              .having((f) => f.type, 'type', ErrorType.network),
        ),
      ],
      verify: (_) {
        verify(() => setup.mockGetHasCachedData(any())).called(1);
        verify(() => setup.mockGetSupportedCurrencies(any())).called(1);
        verifyNever(() => setup.mockGetLatestRates(any()));
      },
    );

    blocTest<SplashCubit, SplashState>(
      'emits Failure when getLatestRates fails after currencies succeed',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(
          () => setup.mockGetSupportedCurrencies(any()),
        ).thenAnswer((_) async => TestData.mockCurrencyInfoList.asOk);
        when(() => setup.mockGetLatestRates(any())).thenAnswer(
          (_) async => const Result<List<CurrencyRateEntity>>.fail(
            errorMessage: 'Failed to fetch rates',
            errorType: ErrorType.server,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Initial>(),
        ),
        isA<SplashState>().having(
          (s) => s.initProcessMessage,
          'message',
          'Getting available currencies...',
        ),
        isA<SplashState>().having(
          (s) => s.initProcessMessage,
          'message',
          'Updating exchange rates...',
        ),
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Failure>()
              .having((f) => f.message, 'message', 'Failed to fetch rates')
              .having((f) => f.type, 'type', ErrorType.server),
        ),
      ],
      verify: (_) {
        verify(() => setup.mockGetHasCachedData(any())).called(1);
        verify(() => setup.mockGetSupportedCurrencies(any())).called(1);
        verify(() => setup.mockGetLatestRates(any())).called(1);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'handles server error type correctly',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(() => setup.mockGetSupportedCurrencies(any())).thenAnswer(
          (_) async => const Result<List<CurrencyInfoEntity>>.fail(
            errorMessage: 'Server error',
            errorType: ErrorType.server,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        expect(setup.splashCubit.state.initState, isA<Failure>());
        final failure = setup.splashCubit.state.initState as Failure;
        expect(failure.message, 'Server error');
        expect(failure.type, ErrorType.server);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'handles client error type',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(() => setup.mockGetSupportedCurrencies(any())).thenAnswer(
          (_) async => const Result<List<CurrencyInfoEntity>>.fail(
            errorMessage: 'Client error',
            errorType: ErrorType.clientError,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        expect(setup.splashCubit.state.initState, isA<Failure>());
        final failure = setup.splashCubit.state.initState as Failure;
        expect(failure.type, ErrorType.clientError);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'handles unexpected error type',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(() => setup.mockGetSupportedCurrencies(any())).thenAnswer(
          (_) async => const Result<List<CurrencyInfoEntity>>.fail(
            errorMessage: 'Unexpected error',
            errorType: ErrorType.unexpected,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        final failure = setup.splashCubit.state.initState as Failure;
        expect(failure.type, ErrorType.unexpected);
      },
    );

    blocTest<SplashCubit, SplashState>(
      'handles database error type',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(
          () => setup.mockGetSupportedCurrencies(any()),
        ).thenAnswer((_) async => TestData.mockCurrencyInfoList.asOk);
        when(() => setup.mockGetLatestRates(any())).thenAnswer(
          (_) async => const Result<List<CurrencyRateEntity>>.fail(
            errorMessage: 'Database error',
            errorType: ErrorType.database,
          ),
        );
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      verify: (_) {
        final failure = setup.splashCubit.state.initState as Failure;
        expect(failure.type, ErrorType.database);
        expect(failure.message, 'Database error');
      },
    );
  });
}
