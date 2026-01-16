import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get currencyFreaksApiKey => dotenv.env['API_KEY'] ?? '';

  static String get baseUrl => 'https://api.currencyfreaks.com/v2.0';
}
