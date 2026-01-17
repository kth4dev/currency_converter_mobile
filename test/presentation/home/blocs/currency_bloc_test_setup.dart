import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/test_helpers.dart';

class CurrencyBlocTestSetup {
  late CurrencyBloc currencyBloc;
  late MockGetOfflineLatestRates mockGetOfflineLatestRates;
  late MockGetLatestRates mockGetLatestRates;
  late MockGetUpdatedDate mockGetUpdatedDate;
  late MockGetSelectedFromCurrency mockGetSelectedFromCurrency;
  late MockGetSelectedToCurrency mockGetSelectedToCurrency;
  late MockSaveSelectedFromCurrency mockSaveSelectedFromCurrency;
  late MockSaveSelectedToCurrency mockSaveSelectedToCurrency;
  late MockGetFromAmount mockGetFromAmount;
  late MockSaveFromAmount mockSaveFromAmount;

  static void registerFallbacks() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeSaveCurrencyParams());
    registerFallbackValue(FakeSaveFromAmountParams());
  }

  void initMocks() {
    mockGetOfflineLatestRates = MockGetOfflineLatestRates();
    mockGetLatestRates = MockGetLatestRates();
    mockGetUpdatedDate = MockGetUpdatedDate();
    mockGetSelectedFromCurrency = MockGetSelectedFromCurrency();
    mockGetSelectedToCurrency = MockGetSelectedToCurrency();
    mockSaveSelectedFromCurrency = MockSaveSelectedFromCurrency();
    mockSaveSelectedToCurrency = MockSaveSelectedToCurrency();
    mockGetFromAmount = MockGetFromAmount();
    mockSaveFromAmount = MockSaveFromAmount();

    currencyBloc = CurrencyBloc(
      mockGetOfflineLatestRates,
      mockGetLatestRates,
      mockGetUpdatedDate,
      mockGetSelectedFromCurrency,
      mockGetSelectedToCurrency,
      mockSaveSelectedFromCurrency,
      mockSaveSelectedToCurrency,
      mockGetFromAmount,
      mockSaveFromAmount,
    );
  }

  void dispose() {
    currencyBloc.close();
  }

  void setupSuccessfulStarted() {
    when(
      () => mockGetOfflineLatestRates(any()),
    ).thenAnswer((_) async => TestData.mockRates.asOk);
    when(
      () => mockGetSelectedFromCurrency(any()),
    ).thenAnswer((_) async => 'USD'.asOk);
    when(
      () => mockGetSelectedToCurrency(any()),
    ).thenAnswer((_) async => 'EUR'.asOk);
    when(() => mockGetFromAmount(any())).thenAnswer((_) async => 1.0.asOk);
    when(
      () => mockGetUpdatedDate(any()),
    ).thenAnswer((_) async => TestData.updatedDate.asOk);
    when(
      () => mockGetLatestRates(any()),
    ).thenAnswer((_) async => TestData.mockRates.asOk);
    setupSaveFromCurrencySuccess();
    setupSaveToCurrencySuccess();
    setupSaveFromAmountSuccess();
  }


  void setupSaveFromAmountSuccess() {
    when(
      () => mockSaveFromAmount(any()),
    ).thenAnswer((_) async => const Result.ok(null));
  }

  void setupSaveFromCurrencySuccess() {
    when(
      () => mockSaveSelectedFromCurrency(any()),
    ).thenAnswer((_) async => const Result.ok(null));
  }

  void setupSaveToCurrencySuccess() {
    when(
      () => mockSaveSelectedToCurrency(any()),
    ).thenAnswer((_) async => const Result.ok(null));
  }

  void setupSwapSuccess() {
    setupSaveFromCurrencySuccess();
    setupSaveToCurrencySuccess();
    setupSaveFromAmountSuccess();
  }
}
