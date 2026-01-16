import 'package:currency_converter/data/model/responses/supported_currencies/supported_currency_api_model.dart';

class SupportedCurrenciesResponseModel {
  final List<SupportedCurrencyModel>? data;

  const SupportedCurrenciesResponseModel({
    this.data,
  });

  factory SupportedCurrenciesResponseModel.fromJson(Map<String, dynamic> json) {
    final map = json['supportedCurrenciesMap'] as Map<String, dynamic>?;

    return SupportedCurrenciesResponseModel(
      data: map?.values
          .map(
            (value) => SupportedCurrencyModel.fromJson(
          value as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }
}
