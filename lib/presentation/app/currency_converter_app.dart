import 'package:currency_converter/core/di/injection_container.dart';
import 'package:currency_converter/core/route/app_router.dart';
import 'package:currency_converter/core/theme/theme.dart';
import 'package:currency_converter/presentation/app/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Currency Converter',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
