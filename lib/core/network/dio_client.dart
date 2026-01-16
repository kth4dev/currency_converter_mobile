import 'package:currency_converter/core/config/app_config.dart';
import 'package:currency_converter/core/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static DioClient? _instance;
  late Dio _dio;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: ApiConstants.defaultHeaders,
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(requestHeader: true, requestBody: true),
    );
  }

  factory DioClient() {
    _instance ??= DioClient._internal();
    return _instance!;
  }

  Dio get dio => _dio;

  static Dio getInstance() {
    return DioClient().dio;
  }
}
