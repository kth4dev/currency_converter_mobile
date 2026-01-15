import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:currency_converter/domain/params/save_theme_mode_params.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SaveThemeMode _saveThemeMode;
  final GetThemeMode _getThemeMode;

  ThemeCubit(this._saveThemeMode, this._getThemeMode)
    : super(const ThemeState()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final themeMode = await _getThemeMode(const NoParams());
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    emit(state.copyWith(themeMode: themeMode));
    await _saveThemeMode(SaveThemeModeParams(themeMode));
  }
}
