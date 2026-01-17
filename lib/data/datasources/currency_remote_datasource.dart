import 'package:currency_converter/core/common/result.dart';
import 'package:currency_converter/core/config/app_config.dart';
import 'package:currency_converter/core/constants/api_constants.dart';
import 'package:currency_converter/core/network/execute_api.dart';
import 'package:currency_converter/data/model/responses/currency_rate/currency_rate_response_model.dart';
import 'package:currency_converter/data/model/responses/supported_currencies/supported_currency_response_model.dart';
import 'package:dio/dio.dart';

class CurrencyRemoteDatasource {
  final Dio dio;

  CurrencyRemoteDatasource(this.dio);

  Future<Result<CurrencyRateResponseModel>> getLatestRates() async {
    final response = await executeApiRequest<Map<String, dynamic>>(
      apiCall: () => dio.get(
        ApiConstants.latestRatesEndpoint,
        queryParameters: {'apikey': AppConfig.currencyFreaksApiKey},
      ),
      defaultErrorMessage: 'Failed to get latest rates',
    );

    switch (response) {
      case Ok<Map<String, dynamic>>():
        return Result.ok(
          CurrencyRateResponseModel.fromJson(response.value),
        );
      case Fail<Map<String, dynamic>>():
        return Result.fail(
          errorMessage: response.errorMessage,
          errorType: response.errorType,
        );
    }
  }

  Future<Result<SupportedCurrenciesResponseModel>> getSupportedCurrencies() async {
    final response = await executeApiRequest<Map<String, dynamic>>(
      apiCall: () => dio.get(ApiConstants.supportedCurrenciesEndpoint),
      defaultErrorMessage: 'Failed to get supported currencies',
    );

    switch (response) {
      case Ok<Map<String, dynamic>>():
        return Result.ok(
          SupportedCurrenciesResponseModel.fromJson(response.value),
        );
      case Fail<Map<String, dynamic>>():
        return Result.fail(
          errorMessage: response.errorMessage,
          errorType: response.errorType,
        );
    }
  }
}
