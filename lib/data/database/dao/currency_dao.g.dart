// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_dao.dart';

// ignore_for_file: type=lint
mixin _$CurrencyDaoMixin on DatabaseAccessor<AppDatabase> {
  $CurrencyRatesTableTable get currencyRatesTable =>
      attachedDatabase.currencyRatesTable;
  $SupportedCurrenciesTableTable get supportedCurrenciesTable =>
      attachedDatabase.supportedCurrenciesTable;
  $AppMetadataTable get appMetadata => attachedDatabase.appMetadata;
  CurrencyDaoManager get managers => CurrencyDaoManager(this);
}

class CurrencyDaoManager {
  final _$CurrencyDaoMixin _db;
  CurrencyDaoManager(this._db);
  $$CurrencyRatesTableTableTableManager get currencyRatesTable =>
      $$CurrencyRatesTableTableTableManager(
        _db.attachedDatabase,
        _db.currencyRatesTable,
      );
  $$SupportedCurrenciesTableTableTableManager get supportedCurrenciesTable =>
      $$SupportedCurrenciesTableTableTableManager(
        _db.attachedDatabase,
        _db.supportedCurrenciesTable,
      );
  $$AppMetadataTableTableManager get appMetadata =>
      $$AppMetadataTableTableManager(_db.attachedDatabase, _db.appMetadata);
}
