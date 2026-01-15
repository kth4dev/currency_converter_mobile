import 'dart:async';
import 'package:equatable/equatable.dart';

abstract class UseCase<T, P> {
  FutureOr<T> call(P params);
}

abstract class Params extends Equatable {
  const Params();
}

class NoParams extends Params {
  const NoParams();

  @override
  List<Object?> get props => [];
}
