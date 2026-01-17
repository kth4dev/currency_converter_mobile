import 'dart:io';
import 'package:currency_converter/data/database/dao/currency_dao.dart';
import 'package:currency_converter/data/database/table/app_metadata_table.dart';
import 'package:currency_converter/data/database/table/currency_rates_table.dart';
import 'package:currency_converter/data/database/table/supported_currencies_table.dart';
import 'package:drift/native.dart';
import 'package:currency_converter/core/constants/db_constants.dart';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(
  tables: [CurrencyRatesTable, SupportedCurrenciesTable, AppMetadata],
  daos: [CurrencyDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => DbConstants.schemaVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {},
    );
  }
}

/// Open database connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, DbConstants.databaseName));
    return NativeDatabase(file);
  });
}
