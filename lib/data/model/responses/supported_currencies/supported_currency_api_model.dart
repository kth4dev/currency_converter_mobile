class SupportedCurrencyModel {
  final String? currencyCode;
  final String? currencyName;
  final String? countryCode;
  final String? countryName;
  final String? status;
  final String? availableFrom;
  final String? availableUntil;
  final String? icon;

  const SupportedCurrencyModel({
    this.currencyCode,
    this.currencyName,
    this.countryCode,
    this.countryName,
    this.status,
    this.availableFrom,
    this.availableUntil,
    this.icon,
  });

  factory SupportedCurrencyModel.fromJson(Map<String, dynamic> json) {
    return SupportedCurrencyModel(
      currencyCode: json['currencyCode'] as String?,
      currencyName: json['currencyName'] as String?,
      countryCode: json['countryCode'] as String?,
      countryName: json['countryName'] as String?,
      status: json['status'] as String?,
      availableFrom: json['availableFrom'] as String?,
      availableUntil: json['availableUntil'] as String?,
      icon: json['icon'] as String?,
    );
  }
}
