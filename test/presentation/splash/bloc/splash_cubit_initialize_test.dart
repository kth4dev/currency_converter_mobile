import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter/core/common/view_state.dart';
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

  group('SplashCubit initialize', () {
    blocTest<SplashCubit, SplashState>(
      'emits Success immediately when cached data exists',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => true);
      },
      build: () => setup.splashCubit,
      act: (cubit) => cubit.initialize(),
      wait: const Duration(seconds: 3),
      expect: () => [
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Initial>(),
        ),
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Success>(),
        ),
      ],
      verify: (_) {
        verify(() => setup.mockGetHasCachedData(any())).called(1);
        verifyNever(() => setup.mockGetSupportedCurrencies(any()));
        verifyNever(() => setup.mockGetLatestRates(any()));
      },
    );

    blocTest<SplashCubit, SplashState>(
      'fetches currencies and rates when no cached data exists',
      setUp: () {
        when(
          () => setup.mockGetHasCachedData(any()),
        ).thenAnswer((_) async => false);
        when(
          () => setup.mockGetSupportedCurrencies(any()),
        ).thenAnswer((_) async => TestData.mockCurrencyInfoList.asOk);
        when(
          () => setup.mockGetLatestRates(any()),
        ).thenAnswer((_) async => TestData.mockRates.asOk);
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
          (s) => s.initProcessMessage,
          'message',
          'Setup complete!',
        ),
        isA<SplashState>().having(
          (s) => s.initState,
          'initState',
          isA<Success>(),
        ),
      ],
      verify: (_) {
        verify(() => setup.mockGetHasCachedData(any())).called(1);
        verify(() => setup.mockGetSupportedCurrencies(any())).called(1);
        verify(() => setup.mockGetLatestRates(any())).called(1);
      },
    );
  });
}
