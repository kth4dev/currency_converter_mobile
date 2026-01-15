import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:flutter/material.dart';

class SaveThemeModeParams extends Params {
  final ThemeMode themeMode;

  const SaveThemeModeParams(this.themeMode);

  @override
  List<Object> get props => [themeMode];
}
