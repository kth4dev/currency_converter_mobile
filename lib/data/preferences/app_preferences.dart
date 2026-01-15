import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences pref;

  const AppPreferences({required this.pref});

  Future<void> saveThemeMode(ThemeMode mode) async {
    await pref.setString(_themeKey, mode.name);
  }

  ThemeMode getThemeMode() {
    final themeName = pref.getString(_themeKey);
    if (themeName == null) return ThemeMode.system;

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  /// Pref-Key
  static const String _themeKey = 'app.theme';
}
