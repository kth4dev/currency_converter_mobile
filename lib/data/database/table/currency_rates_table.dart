import 'package:drift/drift.dart';

class CurrencyRatesTable extends Table {
  TextColumn get code => text()();

  TextColumn get rate => text()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {code};
}
