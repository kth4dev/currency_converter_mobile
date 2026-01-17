part of 'currency_bloc.dart';

@immutable
sealed class CurrencyEvent {}

/// Triggered when the currency converter screen is first opened
class CurrencyConverterStarted extends CurrencyEvent {}

/// Triggered to refresh exchange rates from API
class CurrencyRatesRefreshed extends CurrencyEvent {}

/// Triggered when user selects a "from" currency
class FromCurrencySelected extends CurrencyEvent {
  final CurrencyRateEntity currency;

  FromCurrencySelected(this.currency);
}

/// Triggered when user selects a "to" currency
class ToCurrencySelected extends CurrencyEvent {
  final CurrencyRateEntity currency;

  ToCurrencySelected(this.currency);
}

/// Triggered to swap from and to currencies
class CurrenciesSwapped extends CurrencyEvent {}

/// Triggered when user changes the from amount text
class FromAmountChanged extends CurrencyEvent {
  final String text;

  FromAmountChanged(this.text);
}

/// Triggered when user changes the to amount text (reverse conversion)
class ToAmountChanged extends CurrencyEvent {
  final String text;

  ToAmountChanged(this.text);
}
