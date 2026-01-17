import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:mocktail/mocktail.dart';

// Use Case Mocks
class MockGetOfflineLatestRates extends Mock implements GetOfflineLatestRates {}

class MockGetLatestRates extends Mock implements GetLatestRates {}

class MockGetUpdatedDate extends Mock implements GetUpdatedDate {}

class MockGetSelectedFromCurrency extends Mock
    implements GetSelectedFromCurrency {}

class MockGetSelectedToCurrency extends Mock implements GetSelectedToCurrency {}

class MockSaveSelectedFromCurrency extends Mock
    implements SaveSelectedFromCurrency {}

class MockSaveSelectedToCurrency extends Mock
    implements SaveSelectedToCurrency {}

class MockGetFromAmount extends Mock implements GetFromAmount {}

class MockSaveFromAmount extends Mock implements SaveFromAmount {}

class MockGetHasCachedData extends Mock implements GetHasCachedData {}

class MockGetSupportedCurrencies extends Mock
    implements GetSupportedCurrencies {}

// Fake Classes
class FakeNoParams extends Fake implements NoParams {}

class FakeSaveCurrencyParams extends Fake implements SaveCurrencyParams {}

class FakeSaveFromAmountParams extends Fake implements SaveFromAmountParams {}

// Test Data
class TestData {
  static const usdCurrency = CurrencyRateEntity(
    code: 'USD',
    rate: 1.0,
    currencyName: 'US Dollar',
    countryCode: 'US',
    countryName: 'United States',
  );

  static const eurCurrency = CurrencyRateEntity(
    code: 'EUR',
    rate: 0.85,
    currencyName: 'Euro',
    countryCode: 'EU',
    countryName: 'European Union',
  );

  static const gbpCurrency = CurrencyRateEntity(
    code: 'GBP',
    rate: 0.73,
    currencyName: 'British Pound',
    countryCode: 'GB',
    countryName: 'United Kingdom',
  );

  static const jpyCurrency = CurrencyRateEntity(
    code: 'JPY',
    rate: 110.0,
    currencyName: 'Japanese Yen',
    countryCode: 'JP',
    countryName: 'Japan',
  );

  static const mockRates = [usdCurrency, eurCurrency, gbpCurrency, jpyCurrency];

  static const updatedMockRates = [
    CurrencyRateEntity(code: 'USD', rate: 1.0),
    CurrencyRateEntity(code: 'EUR', rate: 0.90), // Updated rate
    CurrencyRateEntity(code: 'GBP', rate: 0.75), // Updated rate
    CurrencyRateEntity(code: 'JPY', rate: 115.0), // Updated rate
  ];

  static const updatedDate = '2026-01-17 10:30:00';

  static const mockCurrencyInfoList = [
    CurrencyInfoEntity(
      currencyCode: 'USD',
      currencyName: 'US Dollar',
      countryCode: 'US',
      countryName: 'United States',
      status: 'AVAILABLE',
    ),
    CurrencyInfoEntity(
      currencyCode: 'EUR',
      currencyName: 'Euro',
      countryCode: 'EU',
      countryName: 'European Union',
      status: 'AVAILABLE',
    ),
  ];
}

extension ResultExtensions<T> on T {
  Result<T> get asOk => Result.ok(this);
}

class EventFallbacks {
  static void registerCurrencyEvents() {
    registerFallbackValue(CurrencyConverterStarted());
    registerFallbackValue(CurrencyRatesRefreshed());
    registerFallbackValue(CurrenciesSwapped());
    registerFallbackValue(FromAmountChanged(''));
    registerFallbackValue(ToAmountChanged(''));
    registerFallbackValue(FromCurrencySelected(TestData.usdCurrency));
    registerFallbackValue(ToCurrencySelected(TestData.eurCurrency));
  }
}
