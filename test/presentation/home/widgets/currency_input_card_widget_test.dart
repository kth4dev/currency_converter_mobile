import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/currency_inputs_card/currency_input_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  const testCurrency = CurrencyRateEntity(
    code: 'USD',
    rate: 1.0,
    currencyName: 'US Dollar',
    countryCode: 'US',
    countryName: 'United States',
    icon: 'https://example.com/usd.png',
  );

  group('CurrencyInputCardWidget', () {
    testWidgets('renders label correctly', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '100',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('From'), findsOneWidget);
    });

    testWidgets('renders currency code', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '100',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('USD'), findsOneWidget);
    });

    testWidgets('renders currency name', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'To',
          currency: testCurrency,
          amountText: '85',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('US Dollar'), findsOneWidget);
    });

    testWidgets('renders "Select" when currency is null', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: null,
          amountText: '',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('Select'), findsOneWidget);
    });

    testWidgets('renders amount in text field', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '123.45',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('123.45'), findsOneWidget);
    });

    testWidgets('calls onAmountChanged when text is entered', (tester) async {
      String? changedValue;

      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '',
          onAmountChanged: (value) => changedValue = value,
          onCurrencyTap: () {},
        ),
      );

      await tester.enterText(find.byType(TextField), '50');
      await tester.pump();

      expect(changedValue, '50');
    });

    testWidgets('calls onCurrencyTap when currency selector is tapped',
        (tester) async {
      var tapped = false;

      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '100',
          onAmountChanged: (_) {},
          onCurrencyTap: () => tapped = true,
        ),
      );

      await tester.tap(find.text('USD'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders dropdown arrow icon', (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '100',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });


    testWidgets('updates text field when amountText prop changes',
        (tester) async {
      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '100',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('100'), findsOneWidget);

      await tester.pumpApp(
        CurrencyInputCardWidget(
          label: 'From',
          currency: testCurrency,
          amountText: '200',
          onAmountChanged: (_) {},
          onCurrencyTap: () {},
        ),
      );

      expect(find.text('200'), findsOneWidget);
    });
  });
}
