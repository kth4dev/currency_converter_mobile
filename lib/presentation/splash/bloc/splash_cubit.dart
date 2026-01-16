import 'package:bloc/bloc.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  Future<void> initialize() async {
    emit(state.copyWith(initState: const Loading()));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(initState: const Success()));
  }
}
