import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/domain/entities/entities.dart';

abstract class CurrencyRepository {
  Future<Result<List<CurrencyRateEntity>>> getLatestRates();

  Future<Result<List<CurrencyRateEntity>>> getOfflineLatestRates();

  Future<Result<List<CurrencyInfoEntity>>> getSupportedCurrencyInfo();

  Future<bool> hasCachedData();

  Future<Result<String>> getUpdatedDate();

  Future<Result<String>> getSelectedToCurrency();

  Future<Result<String>> getSelectedFromCurrency();

  Future<Result<void>> saveSelectedFromCurrency(String code);

  Future<Result<void>> saveSelectedToCurrency(String code);

  Future<Result<double>> getFromAmount();

  Future<Result<void>> saveFromAmount(double amount);
}
