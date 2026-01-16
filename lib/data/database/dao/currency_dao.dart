import 'package:currency_converter/data/database/app_database.dart';
import 'package:currency_converter/data/database/table/tables.dart';
import 'package:drift/drift.dart';

part 'currency_dao.g.dart';

@DriftAccessor(
  tables: [CurrencyRatesTable, SupportedCurrenciesTable, AppMetadata],
)
class CurrencyDao extends DatabaseAccessor<AppDatabase>
    with _$CurrencyDaoMixin {
  CurrencyDao(super.db);

  // check has cached data
  Future<bool> hasCachedRates() async {
    final count = await currencyRatesTable.count().getSingle();
    return count > 0;
  }

  // currency rates & currency info
  Future<List<TypedResult>> getRatesWithCurrencyInfo() async {
    final query = select(currencyRatesTable).join([
      leftOuterJoin(
        supportedCurrenciesTable,
        supportedCurrenciesTable.currencyCode.equalsExp(currencyRatesTable.code),
      ),
    ]);
    return query.get();
  }


  Future<void> insertRates(List<CurrencyRatesTableCompanion> rates) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(currencyRatesTable, rates);
    });
  }

  Future<void> insertCurrencyInfo(
    List<SupportedCurrenciesTableCompanion> currencies,
  ) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(supportedCurrenciesTable, currencies);
    });
  }

  //App Metadata (Key-Value Store)
  Future<String?> getMetadata(String key) async {
    final result = await (select(appMetadata)
          ..where((t) => t.key.equals(key)))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setMetadata(String key, String value) async {
    await into(appMetadata).insertOnConflictUpdate(
      AppMetadataCompanion.insert(key: key, value: value),
    );
  }
}

/// Keys for AppMetadata table
abstract final class MetadataKeys {
  static const fromCurrency = 'from_currency';
  static const toCurrency = 'to_currency';
  static const updatedRateDate = 'updated_rate_date';
}
