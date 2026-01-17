import 'package:currency_converter/presentation/app/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ThemeCubit>();
    final brightness = MediaQuery.platformBrightnessOf(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final (icon, nextTheme) = _getThemeData(state.themeMode, brightness);
        return IconButton(
          onPressed: () {
            bloc.setTheme(nextTheme);
          },
          icon: Icon(icon),
          tooltip: 'Change theme',
        );
      },
    );
  }

  (IconData, ThemeMode) _getThemeData(
    ThemeMode current,
    Brightness platformBrightness,
  ) {
    return switch (current) {
      ThemeMode.system =>
        platformBrightness == Brightness.dark
            ? (Icons.dark_mode_outlined, ThemeMode.light)
            : (Icons.light_mode_outlined, ThemeMode.dark),
      ThemeMode.light => (Icons.light_mode_outlined, ThemeMode.dark),
      ThemeMode.dark => (Icons.dark_mode_outlined, ThemeMode.light),
    };
  }
}
