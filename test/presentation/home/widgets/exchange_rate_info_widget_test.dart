import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/exchange_rate_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  const usdCurrency = CurrencyRateEntity(
    code: 'USD',
    rate: 1.0,
    currencyName: 'US Dollar',
  );

  const eurCurrency = CurrencyRateEntity(
    code: 'EUR',
    rate: 0.85,
    currencyName: 'Euro',
  );

  group('ExchangeRateInfoWidget', () {
    testWidgets('renders nothing when from is null', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: null,
          to: eurCurrency,
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('Exchange Rate'), findsNothing);
    });

    testWidgets('renders nothing when to is null', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: null,
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('Exchange Rate'), findsNothing);
    });

    testWidgets('renders nothing when both are null', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: null,
          to: null,
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    testWidgets('renders exchange rate label when currencies are provided',
        (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: eurCurrency,
        ),
      );

      expect(find.text('Exchange Rate'), findsOneWidget);
    });

    testWidgets('renders currency exchange icon', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: eurCurrency,
        ),
      );

      expect(find.byIcon(Icons.currency_exchange), findsOneWidget);
    });

    testWidgets('renders forward exchange rate', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: eurCurrency,
        ),
      );

      expect(find.textContaining('1 USD'), findsOneWidget);
      expect(find.textContaining('EUR'), findsWidgets);
    });

    testWidgets('renders reverse exchange rate', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: eurCurrency,
        ),
      );

      expect(find.textContaining('1 EUR'), findsOneWidget);
    });

    testWidgets('has gradient background', (tester) async {
      await tester.pumpApp(
        const ExchangeRateInfoWidget(
          from: usdCurrency,
          to: eurCurrency,
        ),
      );

      final container = tester.widget<Container>(
        find.byType(Container).first,
      );

      expect(container.decoration, isA<BoxDecoration>());
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.gradient, isA<LinearGradient>());
    });
  });
}
