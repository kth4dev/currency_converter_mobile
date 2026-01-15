import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

class GetThemeMode extends UseCase<ThemeMode, NoParams> {
  final ThemeRepository repository;

  GetThemeMode(this.repository);

  @override
  Future<ThemeMode> call(NoParams params) async {
    return await repository.getThemeMode();
  }
}
