import 'package:currency_converter/presentation/app/blocs/theme/theme_cubit.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_converter/data/data.dart';
import 'package:currency_converter/domain/domain.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //local storage
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<AppPreferences>(AppPreferences(pref: sharedPref));

  //repositories
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(sl()));

  //use cases
  sl.registerSingleton<GetThemeMode>(GetThemeMode(sl()));
  sl.registerSingleton<SaveThemeMode>(SaveThemeMode(sl()));

  //blocs
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl(), sl()));
  sl.registerFactory<SplashCubit>(SplashCubit.new);
}
