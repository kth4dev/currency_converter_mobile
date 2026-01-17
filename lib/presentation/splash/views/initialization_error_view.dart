import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/ui/widgets/page_error.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializationErrorView extends StatelessWidget {
  const InitializationErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SplashCubit, SplashState, ViewState>(
      selector: (state) => state.initState,
      builder: (context, initState) {
        if (initState is Failure) {
          return Scaffold(
            body: AppErrorPage(
              message: initState.message,
              errorType: initState.type,
              onRetry: () => context.read<SplashCubit>().initialize(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
