import 'package:currency_converter/core/di/injection_container.dart';
import 'package:currency_converter/presentation/app/currency_converter_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const CurrencyConverterApp());
}
