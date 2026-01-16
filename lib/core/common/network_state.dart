import 'package:currency_converter/core/common/error_type.dart';

sealed class NetworkResponse<T> {}

class NetworkSuccess<T> extends NetworkResponse<T> {
  final T data;

  NetworkSuccess({required this.data});
}

class NetworkFailure<T> extends NetworkResponse<T> {
  final String errorMessage;
  final ErrorType errorType;

  NetworkFailure({required this.errorMessage, required this.errorType});
}


