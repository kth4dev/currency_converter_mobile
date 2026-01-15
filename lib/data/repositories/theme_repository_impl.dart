import 'package:flutter/material.dart';
import 'package:currency_converter/data/preferences/app_preferences.dart';
import 'package:currency_converter/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final AppPreferences preferences;

  ThemeRepositoryImpl(this.preferences);

  @override
  Future<ThemeMode> getThemeMode() async {
    return preferences.getThemeMode();
  }

  @override
  Future<void> saveThemeMode(ThemeMode mode) async {
    await preferences.saveThemeMode(mode);
  }
}
