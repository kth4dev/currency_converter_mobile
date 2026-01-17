class CurrencyRateDetailsModel {
  final String? code;
  final double? rate;
  final String? currencyName;
  final String? icon;
  final String? countryCode;
  final String? countryName;
  final DateTime? updatedAt;

  const CurrencyRateDetailsModel({
    required this.code,
    required this.rate,
    this.currencyName,
    this.icon,
    this.countryCode,
    this.countryName,
    this.updatedAt,
  });
}
