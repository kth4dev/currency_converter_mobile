/// API configuration constants
class ApiConstants {
  ApiConstants._();

  /// EndPoints
  static const String latestRatesEndpoint = '/rates/latest';
  static const String supportedCurrenciesEndpoint = '/supported-currencies';

  /// Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  /// Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
}