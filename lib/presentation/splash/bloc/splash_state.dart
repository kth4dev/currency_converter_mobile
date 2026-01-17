part of 'splash_cubit.dart';

@immutable
class SplashState {
  final ViewState initState;
  final String initProcessMessage;

  const SplashState({
    this.initState = const Initial(),
    this.initProcessMessage = '',
  });

  SplashState copyWith({ViewState? initState, String? initProcessMessage}) {
    return SplashState(
      initState: initState ?? this.initState,
      initProcessMessage: initProcessMessage ?? this.initProcessMessage,
    );
  }
}
