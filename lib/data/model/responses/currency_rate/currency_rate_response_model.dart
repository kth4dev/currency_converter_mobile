import 'package:currency_converter/data/model/responses/currency_rate/currency_rate_api_model.dart';

class CurrencyRateResponseModel {
  final String? date;
  final String? base;
  final List<CurrencyRateAPIModel>? rates;

  const CurrencyRateResponseModel({this.date, this.base, this.rates});

  factory CurrencyRateResponseModel.fromJson(Map<String, dynamic> json) {
    final ratesMap = json['rates'] as Map<String, dynamic>?;

    return CurrencyRateResponseModel(
      date: json['date'] as String?,
      base: json['base'] as String?,
      rates: ratesMap?.entries
          .map(
            (e) => CurrencyRateAPIModel(
              code: e.key,
              rate: double.tryParse(e.value.toString()) ?? 0,
            ),
          )
          .toList(),
    );
  }
}
