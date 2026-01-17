import 'package:currency_converter/core/di/injection_container.dart';
import 'package:currency_converter/presentation/app/currency_converter_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await initDependencies();
  runApp(const CurrencyConverterApp());
}

Future<void> loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint(e.toString());
  }
}
