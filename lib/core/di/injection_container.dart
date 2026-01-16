import 'package:currency_converter/core/network/dio_client.dart';
import 'package:currency_converter/data/database/app_database.dart';
import 'package:currency_converter/data/database/dao/currency_dao.dart';
import 'package:currency_converter/data/datasources/currency_local_datasource.dart';
import 'package:currency_converter/data/datasources/currency_remote_datasource.dart';
import 'package:currency_converter/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter/presentation/app/blocs/theme/theme_cubit.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:currency_converter/data/data.dart';
import 'package:currency_converter/domain/domain.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // DIO
  sl.registerSingleton<Dio>(DioClient.getInstance());

  // Database & DAOs
  sl.registerSingleton<AppDatabase>(AppDatabase());
  sl.registerSingleton<CurrencyDao>(CurrencyDao(sl()));

  // Local Storage
  final sharedPref = await SharedPreferences.getInstance();
  sl.registerSingleton<AppPreferences>(AppPreferences(pref: sharedPref));

  // Data sources
  sl.registerSingleton<CurrencyLocalDatasource>(CurrencyLocalDatasource(sl()));
  sl.registerSingleton<CurrencyRemoteDatasource>(
    CurrencyRemoteDatasource(sl()),
  );

  // Repositories
  sl.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(sl()));
  sl.registerSingleton<CurrencyRepository>(CurrencyRepositoryImpl(sl(), sl()));

  // Use Cases
  sl.registerSingleton<GetThemeMode>(GetThemeMode(sl()));
  sl.registerSingleton<SaveThemeMode>(SaveThemeMode(sl()));
  sl.registerSingleton<GetHasCachedData>(GetHasCachedData(sl()));
  sl.registerSingleton<GetLatestRates>(GetLatestRates(sl()));
  sl.registerSingleton<GetSupportedCurrencies>(GetSupportedCurrencies(sl()));

  // Blocs / Cubits
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl(), sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(sl(), sl(), sl()));
}
