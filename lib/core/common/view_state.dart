import 'package:currency_converter/core/common/error_type.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class ViewState<T> {
  const ViewState();
}

final class Initial<T> extends ViewState<T> {
  const Initial();
}

final class Loading<T> extends ViewState<T> {
  const Loading();
}

final class Success<T> extends ViewState<T> {
  final T? data;

  const Success({this.data});
}

final class Failure<T> extends ViewState<T> {
  final String message;
  final ErrorType type;

  const Failure({required this.message, this.type = ErrorType.unknown});
}
