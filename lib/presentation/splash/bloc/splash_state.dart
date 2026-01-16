part of 'splash_cubit.dart';

@immutable
class SplashState {
  final ViewState initState;

  const SplashState({this.initState = const Initial()});

  SplashState copyWith({ViewState? initState}) {
    return SplashState(initState: initState ?? this.initState);
  }
}
