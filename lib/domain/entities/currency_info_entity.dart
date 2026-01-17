import 'package:equatable/equatable.dart';

class CurrencyInfoEntity extends Equatable {
  final String currencyCode;
  final String? currencyName;
  final String? countryCode;
  final String? countryName;
  final String? icon;
  final String status;

  const CurrencyInfoEntity({
    required this.currencyCode,
    this.currencyName,
    this.countryCode,
    this.countryName,
    this.icon,
    this.status = 'AVAILABLE',
  });

  @override
  List<Object?> get props => [
        currencyCode,
        currencyName,
        countryCode,
        countryName,
        icon,
        status,
      ];
}
