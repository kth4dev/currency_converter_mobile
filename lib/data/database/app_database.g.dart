// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CurrencyRatesTableTable extends CurrencyRatesTable
    with TableInfo<$CurrencyRatesTableTable, CurrencyRatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CurrencyRatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<String> rate = GeneratedColumn<String>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [code, rate, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'currency_rates_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CurrencyRatesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('rate')) {
      context.handle(
        _rateMeta,
        rate.isAcceptableOrUnknown(data['rate']!, _rateMeta),
      );
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  CurrencyRatesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CurrencyRatesTableData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      rate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rate'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CurrencyRatesTableTable createAlias(String alias) {
    return $CurrencyRatesTableTable(attachedDatabase, alias);
  }
}

class CurrencyRatesTableData extends DataClass
    implements Insertable<CurrencyRatesTableData> {
  final String code;
  final String rate;
  final DateTime updatedAt;
  const CurrencyRatesTableData({
    required this.code,
    required this.rate,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['rate'] = Variable<String>(rate);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CurrencyRatesTableCompanion toCompanion(bool nullToAbsent) {
    return CurrencyRatesTableCompanion(
      code: Value(code),
      rate: Value(rate),
      updatedAt: Value(updatedAt),
    );
  }

  factory CurrencyRatesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CurrencyRatesTableData(
      code: serializer.fromJson<String>(json['code']),
      rate: serializer.fromJson<String>(json['rate']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'rate': serializer.toJson<String>(rate),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CurrencyRatesTableData copyWith({
    String? code,
    String? rate,
    DateTime? updatedAt,
  }) => CurrencyRatesTableData(
    code: code ?? this.code,
    rate: rate ?? this.rate,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CurrencyRatesTableData copyWithCompanion(CurrencyRatesTableCompanion data) {
    return CurrencyRatesTableData(
      code: data.code.present ? data.code.value : this.code,
      rate: data.rate.present ? data.rate.value : this.rate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyRatesTableData(')
          ..write('code: $code, ')
          ..write('rate: $rate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, rate, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CurrencyRatesTableData &&
          other.code == this.code &&
          other.rate == this.rate &&
          other.updatedAt == this.updatedAt);
}

class CurrencyRatesTableCompanion
    extends UpdateCompanion<CurrencyRatesTableData> {
  final Value<String> code;
  final Value<String> rate;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CurrencyRatesTableCompanion({
    this.code = const Value.absent(),
    this.rate = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CurrencyRatesTableCompanion.insert({
    required String code,
    required String rate,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       rate = Value(rate);
  static Insertable<CurrencyRatesTableData> custom({
    Expression<String>? code,
    Expression<String>? rate,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (rate != null) 'rate': rate,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CurrencyRatesTableCompanion copyWith({
    Value<String>? code,
    Value<String>? rate,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CurrencyRatesTableCompanion(
      code: code ?? this.code,
      rate: rate ?? this.rate,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (rate.present) {
      map['rate'] = Variable<String>(rate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CurrencyRatesTableCompanion(')
          ..write('code: $code, ')
          ..write('rate: $rate, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SupportedCurrenciesTableTable extends SupportedCurrenciesTable
    with
        TableInfo<
          $SupportedCurrenciesTableTable,
          SupportedCurrenciesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupportedCurrenciesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyNameMeta = const VerificationMeta(
    'currencyName',
  );
  @override
  late final GeneratedColumn<String> currencyName = GeneratedColumn<String>(
    'currency_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryNameMeta = const VerificationMeta(
    'countryName',
  );
  @override
  late final GeneratedColumn<String> countryName = GeneratedColumn<String>(
    'country_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AVAILABLE'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    currencyCode,
    currencyName,
    icon,
    countryCode,
    countryName,
    status,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supported_currencies_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SupportedCurrenciesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('currency_name')) {
      context.handle(
        _currencyNameMeta,
        currencyName.isAcceptableOrUnknown(
          data['currency_name']!,
          _currencyNameMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('country_name')) {
      context.handle(
        _countryNameMeta,
        countryName.isAcceptableOrUnknown(
          data['country_name']!,
          _countryNameMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {currencyCode};
  @override
  SupportedCurrenciesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupportedCurrenciesTableData(
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      currencyName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_name'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      ),
      countryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_name'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SupportedCurrenciesTableTable createAlias(String alias) {
    return $SupportedCurrenciesTableTable(attachedDatabase, alias);
  }
}

class SupportedCurrenciesTableData extends DataClass
    implements Insertable<SupportedCurrenciesTableData> {
  final String currencyCode;
  final String? currencyName;
  final String? icon;
  final String? countryCode;
  final String? countryName;
  final String status;
  final DateTime updatedAt;
  const SupportedCurrenciesTableData({
    required this.currencyCode,
    this.currencyName,
    this.icon,
    this.countryCode,
    this.countryName,
    required this.status,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['currency_code'] = Variable<String>(currencyCode);
    if (!nullToAbsent || currencyName != null) {
      map['currency_name'] = Variable<String>(currencyName);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || countryCode != null) {
      map['country_code'] = Variable<String>(countryCode);
    }
    if (!nullToAbsent || countryName != null) {
      map['country_name'] = Variable<String>(countryName);
    }
    map['status'] = Variable<String>(status);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SupportedCurrenciesTableCompanion toCompanion(bool nullToAbsent) {
    return SupportedCurrenciesTableCompanion(
      currencyCode: Value(currencyCode),
      currencyName: currencyName == null && nullToAbsent
          ? const Value.absent()
          : Value(currencyName),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      countryCode: countryCode == null && nullToAbsent
          ? const Value.absent()
          : Value(countryCode),
      countryName: countryName == null && nullToAbsent
          ? const Value.absent()
          : Value(countryName),
      status: Value(status),
      updatedAt: Value(updatedAt),
    );
  }

  factory SupportedCurrenciesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupportedCurrenciesTableData(
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      currencyName: serializer.fromJson<String?>(json['currencyName']),
      icon: serializer.fromJson<String?>(json['icon']),
      countryCode: serializer.fromJson<String?>(json['countryCode']),
      countryName: serializer.fromJson<String?>(json['countryName']),
      status: serializer.fromJson<String>(json['status']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'currencyCode': serializer.toJson<String>(currencyCode),
      'currencyName': serializer.toJson<String?>(currencyName),
      'icon': serializer.toJson<String?>(icon),
      'countryCode': serializer.toJson<String?>(countryCode),
      'countryName': serializer.toJson<String?>(countryName),
      'status': serializer.toJson<String>(status),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SupportedCurrenciesTableData copyWith({
    String? currencyCode,
    Value<String?> currencyName = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    Value<String?> countryCode = const Value.absent(),
    Value<String?> countryName = const Value.absent(),
    String? status,
    DateTime? updatedAt,
  }) => SupportedCurrenciesTableData(
    currencyCode: currencyCode ?? this.currencyCode,
    currencyName: currencyName.present ? currencyName.value : this.currencyName,
    icon: icon.present ? icon.value : this.icon,
    countryCode: countryCode.present ? countryCode.value : this.countryCode,
    countryName: countryName.present ? countryName.value : this.countryName,
    status: status ?? this.status,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SupportedCurrenciesTableData copyWithCompanion(
    SupportedCurrenciesTableCompanion data,
  ) {
    return SupportedCurrenciesTableData(
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      currencyName: data.currencyName.present
          ? data.currencyName.value
          : this.currencyName,
      icon: data.icon.present ? data.icon.value : this.icon,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      countryName: data.countryName.present
          ? data.countryName.value
          : this.countryName,
      status: data.status.present ? data.status.value : this.status,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupportedCurrenciesTableData(')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyName: $currencyName, ')
          ..write('icon: $icon, ')
          ..write('countryCode: $countryCode, ')
          ..write('countryName: $countryName, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    currencyCode,
    currencyName,
    icon,
    countryCode,
    countryName,
    status,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupportedCurrenciesTableData &&
          other.currencyCode == this.currencyCode &&
          other.currencyName == this.currencyName &&
          other.icon == this.icon &&
          other.countryCode == this.countryCode &&
          other.countryName == this.countryName &&
          other.status == this.status &&
          other.updatedAt == this.updatedAt);
}

class SupportedCurrenciesTableCompanion
    extends UpdateCompanion<SupportedCurrenciesTableData> {
  final Value<String> currencyCode;
  final Value<String?> currencyName;
  final Value<String?> icon;
  final Value<String?> countryCode;
  final Value<String?> countryName;
  final Value<String> status;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SupportedCurrenciesTableCompanion({
    this.currencyCode = const Value.absent(),
    this.currencyName = const Value.absent(),
    this.icon = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.countryName = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SupportedCurrenciesTableCompanion.insert({
    required String currencyCode,
    this.currencyName = const Value.absent(),
    this.icon = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.countryName = const Value.absent(),
    this.status = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : currencyCode = Value(currencyCode);
  static Insertable<SupportedCurrenciesTableData> custom({
    Expression<String>? currencyCode,
    Expression<String>? currencyName,
    Expression<String>? icon,
    Expression<String>? countryCode,
    Expression<String>? countryName,
    Expression<String>? status,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (currencyCode != null) 'currency_code': currencyCode,
      if (currencyName != null) 'currency_name': currencyName,
      if (icon != null) 'icon': icon,
      if (countryCode != null) 'country_code': countryCode,
      if (countryName != null) 'country_name': countryName,
      if (status != null) 'status': status,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SupportedCurrenciesTableCompanion copyWith({
    Value<String>? currencyCode,
    Value<String?>? currencyName,
    Value<String?>? icon,
    Value<String?>? countryCode,
    Value<String?>? countryName,
    Value<String>? status,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SupportedCurrenciesTableCompanion(
      currencyCode: currencyCode ?? this.currencyCode,
      currencyName: currencyName ?? this.currencyName,
      icon: icon ?? this.icon,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (currencyName.present) {
      map['currency_name'] = Variable<String>(currencyName.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (countryName.present) {
      map['country_name'] = Variable<String>(countryName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupportedCurrenciesTableCompanion(')
          ..write('currencyCode: $currencyCode, ')
          ..write('currencyName: $currencyName, ')
          ..write('icon: $icon, ')
          ..write('countryCode: $countryCode, ')
          ..write('countryName: $countryName, ')
          ..write('status: $status, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetadataTable extends AppMetadata
    with TableInfo<$AppMetadataTable, AppMetadataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetadataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppMetadataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetadataData(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AppMetadataTable createAlias(String alias) {
    return $AppMetadataTable(attachedDatabase, alias);
  }
}

class AppMetadataData extends DataClass implements Insertable<AppMetadataData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppMetadataData({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppMetadataCompanion toCompanion(bool nullToAbsent) {
    return AppMetadataCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppMetadataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetadataData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppMetadataData copyWith({String? key, String? value, DateTime? updatedAt}) =>
      AppMetadataData(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppMetadataData copyWithCompanion(AppMetadataCompanion data) {
    return AppMetadataData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetadataData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppMetadataCompanion extends UpdateCompanion<AppMetadataData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppMetadataCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetadataCompanion.insert({
    required String key,
    required String value,
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppMetadataData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetadataCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AppMetadataCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetadataCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CurrencyRatesTableTable currencyRatesTable =
      $CurrencyRatesTableTable(this);
  late final $SupportedCurrenciesTableTable supportedCurrenciesTable =
      $SupportedCurrenciesTableTable(this);
  late final $AppMetadataTable appMetadata = $AppMetadataTable(this);
  late final CurrencyDao currencyDao = CurrencyDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    currencyRatesTable,
    supportedCurrenciesTable,
    appMetadata,
  ];
}

typedef $$CurrencyRatesTableTableCreateCompanionBuilder =
    CurrencyRatesTableCompanion Function({
      required String code,
      required String rate,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CurrencyRatesTableTableUpdateCompanionBuilder =
    CurrencyRatesTableCompanion Function({
      Value<String> code,
      Value<String> rate,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CurrencyRatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTableTable> {
  $$CurrencyRatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CurrencyRatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTableTable> {
  $$CurrencyRatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rate => $composableBuilder(
    column: $table.rate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CurrencyRatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CurrencyRatesTableTable> {
  $$CurrencyRatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CurrencyRatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CurrencyRatesTableTable,
          CurrencyRatesTableData,
          $$CurrencyRatesTableTableFilterComposer,
          $$CurrencyRatesTableTableOrderingComposer,
          $$CurrencyRatesTableTableAnnotationComposer,
          $$CurrencyRatesTableTableCreateCompanionBuilder,
          $$CurrencyRatesTableTableUpdateCompanionBuilder,
          (
            CurrencyRatesTableData,
            BaseReferences<
              _$AppDatabase,
              $CurrencyRatesTableTable,
              CurrencyRatesTableData
            >,
          ),
          CurrencyRatesTableData,
          PrefetchHooks Function()
        > {
  $$CurrencyRatesTableTableTableManager(
    _$AppDatabase db,
    $CurrencyRatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CurrencyRatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CurrencyRatesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CurrencyRatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> rate = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyRatesTableCompanion(
                code: code,
                rate: rate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String rate,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CurrencyRatesTableCompanion.insert(
                code: code,
                rate: rate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CurrencyRatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CurrencyRatesTableTable,
      CurrencyRatesTableData,
      $$CurrencyRatesTableTableFilterComposer,
      $$CurrencyRatesTableTableOrderingComposer,
      $$CurrencyRatesTableTableAnnotationComposer,
      $$CurrencyRatesTableTableCreateCompanionBuilder,
      $$CurrencyRatesTableTableUpdateCompanionBuilder,
      (
        CurrencyRatesTableData,
        BaseReferences<
          _$AppDatabase,
          $CurrencyRatesTableTable,
          CurrencyRatesTableData
        >,
      ),
      CurrencyRatesTableData,
      PrefetchHooks Function()
    >;
typedef $$SupportedCurrenciesTableTableCreateCompanionBuilder =
    SupportedCurrenciesTableCompanion Function({
      required String currencyCode,
      Value<String?> currencyName,
      Value<String?> icon,
      Value<String?> countryCode,
      Value<String?> countryName,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$SupportedCurrenciesTableTableUpdateCompanionBuilder =
    SupportedCurrenciesTableCompanion Function({
      Value<String> currencyCode,
      Value<String?> currencyName,
      Value<String?> icon,
      Value<String?> countryCode,
      Value<String?> countryName,
      Value<String> status,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SupportedCurrenciesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SupportedCurrenciesTableTable> {
  $$SupportedCurrenciesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SupportedCurrenciesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SupportedCurrenciesTableTable> {
  $$SupportedCurrenciesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SupportedCurrenciesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SupportedCurrenciesTableTable> {
  $$SupportedCurrenciesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyName => $composableBuilder(
    column: $table.currencyName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get countryName => $composableBuilder(
    column: $table.countryName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SupportedCurrenciesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupportedCurrenciesTableTable,
          SupportedCurrenciesTableData,
          $$SupportedCurrenciesTableTableFilterComposer,
          $$SupportedCurrenciesTableTableOrderingComposer,
          $$SupportedCurrenciesTableTableAnnotationComposer,
          $$SupportedCurrenciesTableTableCreateCompanionBuilder,
          $$SupportedCurrenciesTableTableUpdateCompanionBuilder,
          (
            SupportedCurrenciesTableData,
            BaseReferences<
              _$AppDatabase,
              $SupportedCurrenciesTableTable,
              SupportedCurrenciesTableData
            >,
          ),
          SupportedCurrenciesTableData,
          PrefetchHooks Function()
        > {
  $$SupportedCurrenciesTableTableTableManager(
    _$AppDatabase db,
    $SupportedCurrenciesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SupportedCurrenciesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SupportedCurrenciesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SupportedCurrenciesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> currencyCode = const Value.absent(),
                Value<String?> currencyName = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> countryCode = const Value.absent(),
                Value<String?> countryName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupportedCurrenciesTableCompanion(
                currencyCode: currencyCode,
                currencyName: currencyName,
                icon: icon,
                countryCode: countryCode,
                countryName: countryName,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String currencyCode,
                Value<String?> currencyName = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> countryCode = const Value.absent(),
                Value<String?> countryName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SupportedCurrenciesTableCompanion.insert(
                currencyCode: currencyCode,
                currencyName: currencyName,
                icon: icon,
                countryCode: countryCode,
                countryName: countryName,
                status: status,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SupportedCurrenciesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupportedCurrenciesTableTable,
      SupportedCurrenciesTableData,
      $$SupportedCurrenciesTableTableFilterComposer,
      $$SupportedCurrenciesTableTableOrderingComposer,
      $$SupportedCurrenciesTableTableAnnotationComposer,
      $$SupportedCurrenciesTableTableCreateCompanionBuilder,
      $$SupportedCurrenciesTableTableUpdateCompanionBuilder,
      (
        SupportedCurrenciesTableData,
        BaseReferences<
          _$AppDatabase,
          $SupportedCurrenciesTableTable,
          SupportedCurrenciesTableData
        >,
      ),
      SupportedCurrenciesTableData,
      PrefetchHooks Function()
    >;
typedef $$AppMetadataTableCreateCompanionBuilder =
    AppMetadataCompanion Function({
      required String key,
      required String value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$AppMetadataTableUpdateCompanionBuilder =
    AppMetadataCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AppMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetadataTable> {
  $$AppMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetadataTable,
          AppMetadataData,
          $$AppMetadataTableFilterComposer,
          $$AppMetadataTableOrderingComposer,
          $$AppMetadataTableAnnotationComposer,
          $$AppMetadataTableCreateCompanionBuilder,
          $$AppMetadataTableUpdateCompanionBuilder,
          (
            AppMetadataData,
            BaseReferences<_$AppDatabase, $AppMetadataTable, AppMetadataData>,
          ),
          AppMetadataData,
          PrefetchHooks Function()
        > {
  $$AppMetadataTableTableManager(_$AppDatabase db, $AppMetadataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetadataCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetadataTable,
      AppMetadataData,
      $$AppMetadataTableFilterComposer,
      $$AppMetadataTableOrderingComposer,
      $$AppMetadataTableAnnotationComposer,
      $$AppMetadataTableCreateCompanionBuilder,
      $$AppMetadataTableUpdateCompanionBuilder,
      (
        AppMetadataData,
        BaseReferences<_$AppDatabase, $AppMetadataTable, AppMetadataData>,
      ),
      AppMetadataData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CurrencyRatesTableTableTableManager get currencyRatesTable =>
      $$CurrencyRatesTableTableTableManager(_db, _db.currencyRatesTable);
  $$SupportedCurrenciesTableTableTableManager get supportedCurrenciesTable =>
      $$SupportedCurrenciesTableTableTableManager(
        _db,
        _db.supportedCurrenciesTable,
      );
  $$AppMetadataTableTableManager get appMetadata =>
      $$AppMetadataTableTableManager(_db, _db.appMetadata);
}
