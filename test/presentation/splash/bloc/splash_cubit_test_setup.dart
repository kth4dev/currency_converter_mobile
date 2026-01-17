import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helpers.dart';

class SplashCubitTestSetup {
  late SplashCubit splashCubit;
  late MockGetHasCachedData mockGetHasCachedData;
  late MockGetLatestRates mockGetLatestRates;
  late MockGetSupportedCurrencies mockGetSupportedCurrencies;

  static void registerFallbacks() {
    registerFallbackValue(FakeNoParams());
  }

  void initMocks() {
    mockGetHasCachedData = MockGetHasCachedData();
    mockGetLatestRates = MockGetLatestRates();
    mockGetSupportedCurrencies = MockGetSupportedCurrencies();

    splashCubit = SplashCubit(
      mockGetHasCachedData,
      mockGetLatestRates,
      mockGetSupportedCurrencies,
    );
  }

  void dispose() {
    splashCubit.close();
  }
}
