import 'dart:io';
import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/result.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Future<Result<T>> executeApiRequest<T>({
  required Future<Response<T>> Function() apiCall,
  required String defaultErrorMessage,
}) async {
  try {
    final Response<T> response = await apiCall();
    return _handleResponse(response, defaultErrorMessage);
  } on DioException catch (e) {
    debugPrint('Execute API Exception : DioException');
    return _handleDioException(e, defaultErrorMessage);
  } on SocketException {
    debugPrint('Execute API Exception : SocketException');
    return Result.fail(
      errorMessage:
          'No internet connection',
      errorType: ErrorType.network,
    );
  } catch (e) {
    debugPrint('Execute API Exception : ${e.toString()}');
    return Result.fail(
      errorMessage: defaultErrorMessage,
      errorType: ErrorType.unexpected,
    );
  }
}

/// Handles API responses by checking status codes
Result<T> _handleResponse<T>(Response<T> response, String defaultErrorMessage) {
  final int? statusCode = response.statusCode;
  final T? data = response.data;

  if (statusCode == null || data == null) {
    return Result.fail(
      errorMessage: defaultErrorMessage,
      errorType: ErrorType.unexpected,
    );
  }

  if (statusCode >= 200 && statusCode < 300) {
    return Result.ok(data);
  }

  if (statusCode >= 500) {
    debugPrint('Execute API Exception : Server Error');

    return Result.fail(
      errorMessage: 'Server is under maintenance. Please try again later.',
      errorType: ErrorType.server,
    );
  }

  debugPrint('Execute API Exception : Unexpected Error');
  return Result.fail(
    errorMessage: defaultErrorMessage,
    errorType: ErrorType.unexpected,
  );
}

/// Handles DioException errors by extracting error messages
Result<T> _handleDioException<T>(DioException e, String defaultErrorMessage) {
  if (e.type == DioExceptionType.connectionError) {
    return Result.fail(
      errorMessage:
          'No internet connection',
      errorType: ErrorType.network,
    );
  } else if (e.response != null) {
    final dynamic responseData = e.response?.data;
    String errorMessage =
        _extractErrorMessage(responseData) ?? defaultErrorMessage;

    return Result.fail(
      errorMessage: errorMessage,
      errorType: ErrorType.clientError,
    );
  } else {
    return Result.fail(
      errorMessage: defaultErrorMessage,
      errorType: ErrorType.unexpected,
    );
  }
}

/// Extracts error message from Dio currency_rate data
String? _extractErrorMessage(dynamic responseData) {
  if (responseData is Map<String, dynamic>) {
    try {
      return responseData['message'] ?? 'Unknown error occurred';
    } catch (e) {
      return 'Unknown error occurred';
    }
  }
  return null;
}
