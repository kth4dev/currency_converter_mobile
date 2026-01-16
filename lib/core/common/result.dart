import 'package:currency_converter/core/common/error_type.dart';

sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok._;

  const factory Result.fail({
    required String errorMessage,
    required ErrorType errorType,
  }) = Fail._;
}

final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  final T value;
}

final class Fail<T> extends Result<T> {
  const Fail._({required this.errorMessage, required this.errorType});

  final String errorMessage;
  final ErrorType errorType;
}
