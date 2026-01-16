import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/domain/entities/entities.dart';

abstract class CurrencyRepository {
  Future<Result<List<CurrencyRateEntity>>> getLatestRates();

  Future<Result<List<CurrencyInfoEntity>>> getSupportedCurrencyInfo();

  Future<bool> hasCachedData();

  Future<Result<String>> getUpdatedRateDate();

  Future<Result<String>> getSelectedToCurrency();

  Future<Result<String>> getSelectedFromCurrency();

  Future<Result<void>> saveSelectedFromCurrency(String code);

  Future<Result<void>> saveSelectedToCurrency(String code);
}
