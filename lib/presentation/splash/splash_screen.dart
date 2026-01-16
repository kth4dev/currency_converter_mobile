import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/route/app_routes.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:currency_converter/presentation/splash/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listenWhen: _shouldListen,
        listener: _listenInitializationState,
        child: const Padding(
          padding: EdgeInsets.all(Dimens.space24),
          child: Stack(
            children: [
              AppLogoAndName(),
              InitializationStatusMessageView(),
              InitializationErrorView(),
            ],
          ),
        ),
      ),
    );
  }

  bool _shouldListen(SplashState previous, SplashState current) {
    return previous.initState != current.initState;
  }

  void _listenInitializationState(BuildContext context, SplashState state) {
    final initState = state.initState;
    if (initState is Success) {
      context.pushReplacement(AppRoutes.home);
    }
  }
}
