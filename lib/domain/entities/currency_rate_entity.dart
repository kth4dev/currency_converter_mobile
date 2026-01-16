import 'package:equatable/equatable.dart';

class CurrencyRateEntity extends Equatable {
  final String code;
  final double rate;
  final String? currencyName;
  final String? icon;
  final String? countryCode;
  final String? countryName;
  final DateTime? updatedAt;

  const CurrencyRateEntity({
    required this.code,
    required this.rate,
    this.currencyName,
    this.icon,
    this.countryCode,
    this.countryName,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        code,
        rate,
        currencyName,
        icon,
        countryCode,
        countryName,
        updatedAt,
      ];
}
