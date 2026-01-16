import 'package:drift/drift.dart';

class AppMetadata extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {key};
}

class MetadataKeys {
  MetadataKeys._();

  static const String ratesLastUpdated = 'rates_last_updated';
  static const String selectedFromCurrency = 'selected_from_currency';
  static const String selectedToCurrency = 'selected_to_currency';
}
