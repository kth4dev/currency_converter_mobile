import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/data/datasources/currency_local_datasource.dart';
import 'package:currency_converter/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/data/model/responses/currency_rate/currency_rate_response_model.dart';
import 'package:currency_converter/data/model/responses/supported_currencies/supported_currency_response_model.dart';
import 'package:currency_converter/domain/entities/entities.dart';
import 'package:currency_converter/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl extends CurrencyRepository {
  final CurrencyRemoteDatasource _remoteDatasource;
  final CurrencyLocalDatasource _localDatasource;

  CurrencyRepositoryImpl(this._remoteDatasource, this._localDatasource);

  @override
  Future<Result<List<CurrencyRateEntity>>> getLatestRates() async {
    final remoteResult = await _remoteDatasource.getLatestRates();

    switch (remoteResult) {
      case Ok<CurrencyRateResponseModel>():
        final rates = remoteResult.value.rates ?? [];
        await _localDatasource.saveCurrencyRates(rates);
        final mergedData = await _localDatasource.getCurrencyRateWithInfo();

        final entities = mergedData
            .where((m) => m.code != null && m.rate != null)
            .map(
              (m) => CurrencyRateEntity(
                code: m.code!,
                rate: m.rate!,
                currencyName: m.currencyName,
                icon: m.icon,
                countryCode: m.countryCode,
                countryName: m.countryName,
                updatedAt: m.updatedAt,
              ),
            )
            .toList();

        return Result.ok(entities);

      case Fail<CurrencyRateResponseModel>():
        return Result.fail(
          errorMessage: remoteResult.errorMessage,
          errorType: remoteResult.errorType,
        );
    }
  }

  @override
  Future<Result<List<CurrencyInfoEntity>>> getSupportedCurrencyInfo() async {
    final remoteResult = await _remoteDatasource.getSupportedCurrencies();

    switch (remoteResult) {
      case Ok<SupportedCurrenciesResponseModel>():
        final currencyInfoList = remoteResult.value.data ?? [];
        await _localDatasource.saveCurrencyInfo(currencyInfoList);

        final entities = currencyInfoList
            .where((m) => m.currencyCode != null)
            .map(
              (m) => CurrencyInfoEntity(
                currencyCode: m.currencyCode!,
                currencyName: m.currencyName,
                countryCode: m.countryCode,
                countryName: m.countryName,
                icon: m.icon,
                status: m.status ?? 'AVAILABLE',
              ),
            )
            .toList();

        return Result.ok(entities);

      case Fail<SupportedCurrenciesResponseModel>():
        return Result.fail(
          errorMessage: remoteResult.errorMessage,
          errorType: remoteResult.errorType,
        );
    }
  }

  @override
  Future<bool> hasCachedData() async {
    return _localDatasource.hasCachedCurrencyRate();
  }

  @override
  Future<Result<String>> getSelectedFromCurrency() async {
    final currency = await _localDatasource.getFromCurrency();
    if (currency == null) {
      return const Result.fail(
        errorMessage: 'No from currency selected',
        errorType: ErrorType.unknown,
      );
    }
    return Result.ok(currency);
  }

  @override
  Future<Result<String>> getSelectedToCurrency() async {
    final currency = await _localDatasource.getToCurrency();
    if (currency == null) {
      return const Result.fail(
        errorMessage: 'No to currency selected',
        errorType: ErrorType.unknown,
      );
    }
    return Result.ok(currency);
  }

  @override
  Future<Result<String>> getUpdatedRateDate() async {
    final date = await _localDatasource.getUpdatedDate();
    if (date == null) {
      return const Result.fail(
        errorMessage: 'No rate update date found',
        errorType: ErrorType.unknown,
      );
    }
    return Result.ok(date.toIso8601String());
  }

  @override
  Future<Result<void>> saveSelectedFromCurrency(String code) async {
    await _localDatasource.saveFromCurrency(code);
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> saveSelectedToCurrency(String code) async {
    await _localDatasource.saveToCurrency(code);
    return const Result.ok(null);
  }
}
