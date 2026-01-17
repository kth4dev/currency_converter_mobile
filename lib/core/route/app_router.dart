import 'package:currency_converter/core/di/injection_container.dart';
import 'package:currency_converter/core/route/app_routes.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/home_screen.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:currency_converter/presentation/splash/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, _) => BlocProvider(
          create: (context) => sl<SplashCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, _) => BlocProvider(
          create: (_) => sl<CurrencyBloc>()..add(CurrencyConverterStarted()),
          child: const HomeScreen(),
        ),
      ),
    ],
  );
}
