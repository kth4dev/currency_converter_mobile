import 'package:currency_converter/domain/entities/currency_rate_entity.dart';

abstract final class CurrencyUtils {
  static double convert({
    required double amount,
    required CurrencyRateEntity from,
    required CurrencyRateEntity to,
  }) {
    if (from.rate == 0) return 0;
    return (amount / from.rate) * to.rate;
  }

  static double exchangeRate({
    required CurrencyRateEntity from,
    required CurrencyRateEntity to,
  }) {
    if (from.rate == 0) return 0;
    return to.rate / from.rate;
  }

  static String formatAmount(double value) {
    if (value == 0) return '';
    if (value == value.truncateToDouble()) {
      return value.toStringAsFixed(0);
    }
    final formatted = value.toStringAsFixed(6);
    return formatted
        .replaceAll(RegExp(r'0+$'), '')
        .replaceAll(RegExp(r'\.$'), '');
  }

  static String formatRate(double rate) {
    if (rate >= 1000) {
      return rate.toStringAsFixed(2);
    } else if (rate >= 1) {
      return rate.toStringAsFixed(4);
    } else {
      return rate.toStringAsFixed(6);
    }
  }

  static String formatExchangeRateString({
    required CurrencyRateEntity from,
    required CurrencyRateEntity to,
  }) {
    final rate = exchangeRate(from: from, to: to);
    return '1 ${from.code} = ${formatRate(rate)} ${to.code}';
  }
}
