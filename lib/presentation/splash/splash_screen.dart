import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/route/app_routes.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
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
    return BlocListener<SplashCubit, SplashState>(
      listener: _listenInitializationState,
      child: const Scaffold(body: Center(child: Text('Currency Converter'))),
    );
  }

  void _listenInitializationState(BuildContext context, SplashState state) {
    final initState = state.initState;
    if (initState is Success) {
      context.pushReplacement(AppRoutes.home);
    }
  }
}
