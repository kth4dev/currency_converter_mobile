import 'package:drift/drift.dart';

class SupportedCurrenciesTable extends Table {
  TextColumn get currencyCode => text().withLength(min: 1, max: 20)();

  TextColumn get currencyName => text().nullable()();

  TextColumn get icon => text().nullable()();

  TextColumn get countryCode => text().nullable()();

  TextColumn get countryName => text().nullable()();

  TextColumn get status => text().withDefault(const Constant('AVAILABLE'))();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {currencyCode};
}
