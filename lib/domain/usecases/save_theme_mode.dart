import 'package:currency_converter/core/usecase/usecase.dart';
import 'package:currency_converter/domain/params/save_theme_mode_params.dart';
import 'package:currency_converter/domain/repositories/theme_repository.dart';

class SaveThemeMode extends UseCase<void, SaveThemeModeParams> {
  final ThemeRepository repository;

  SaveThemeMode(this.repository);

  @override
  Future<void> call(SaveThemeModeParams params) async {
    return await repository.saveThemeMode(params.themeMode);
  }
}
