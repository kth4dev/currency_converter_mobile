import 'package:currency_converter/data/database/app_database.dart';
import 'package:currency_converter/data/database/dao/currency_dao.dart';
import 'package:currency_converter/data/model/currency_rate_details_model.dart';
import 'package:currency_converter/data/model/responses/currency_rate/currency_rate_api_model.dart';
import 'package:currency_converter/data/model/responses/supported_currencies/supported_currency_api_model.dart';
import 'package:drift/drift.dart';

class CurrencyLocalDatasource {
  final CurrencyDao _dao;

  CurrencyLocalDatasource(this._dao);

  // Get Currency Rates with Info
  Future<List<CurrencyRateDetailsModel>> getCurrencyRateWithInfo() async {
    final results = await _dao.getRatesWithCurrencyInfo();

    return results.map((row) {
      final rate = row.readTable(_dao.currencyRatesTable);
      final currency = row.readTableOrNull(_dao.supportedCurrenciesTable);

      return CurrencyRateDetailsModel(
        code: rate.code,
        rate: double.tryParse(rate.rate),
        currencyName: currency?.currencyName,
        icon: currency?.icon,
        countryCode: currency?.countryCode,
        countryName: currency?.countryName,
        updatedAt: rate.updatedAt,
      );
    }).toList();
  }


  // Saved Currency Rate & Info
  Future<void> saveCurrencyRates(List<CurrencyRateAPIModel> rateList) async {
    final companions = rateList
        .where((rate) => rate.code != null)
        .map(
          (rate) => CurrencyRatesTableCompanion.insert(
            code: rate.code!,
            rate: rate.rate?.toString() ?? '0',
          ),
        )
        .toList();

    await _dao.insertRates(companions);
  }

  Future<void> saveCurrencyInfo(List<SupportedCurrencyModel> infoList) async {
    final companions = infoList
        .where((info) => info.currencyCode != null)
        .map(
          (info) => SupportedCurrenciesTableCompanion.insert(
            currencyCode: info.currencyCode!,
            currencyName: Value(info.currencyName),
            icon: Value(info.icon),
            countryCode: Value(info.countryCode),
            countryName: Value(info.countryName),
            status: Value(info.status ?? 'AVAILABLE'),
          ),
        )
        .toList();

    await _dao.insertCurrencyInfo(companions);
  }


  // Check has cached currency rate
  Future<bool> hasCachedCurrencyRate() async {
    return _dao.hasCachedRates();
  }


  // App Metadata
  // updated date, selected currencies
  Future<DateTime?> getUpdatedDate() async {
    final value = await _dao.getMetadata(MetadataKeys.updatedRateDate);
    if (value == null) return null;
    return DateTime.tryParse(value);
  }

  Future<void> saveUpdatedDate(DateTime date) async {
    await _dao.setMetadata(
      MetadataKeys.updatedRateDate,
      date.toIso8601String(),
    );
  }

  Future<String?> getFromCurrency() async {
    return _dao.getMetadata(MetadataKeys.fromCurrency);
  }

  Future<String?> getToCurrency() async {
    return _dao.getMetadata(MetadataKeys.toCurrency);
  }

  Future<void> saveFromCurrency(String code) async {
    await _dao.setMetadata(MetadataKeys.fromCurrency, code);
  }

  Future<void> saveToCurrency(String code) async {
    await _dao.setMetadata(MetadataKeys.toCurrency, code);
  }

  Future<double?> getFromAmount() async {
    final value = await _dao.getMetadata(MetadataKeys.fromAmount);
    if (value == null) return null;
    return double.tryParse(value);
  }

  Future<void> saveFromAmount(double amount) async {
    await _dao.setMetadata(MetadataKeys.fromAmount, amount.toString());
  }
}
