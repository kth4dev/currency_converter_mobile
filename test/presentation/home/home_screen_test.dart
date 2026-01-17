import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_helpers.dart';
import '../../helpers/widget_test_helpers.dart';

void main() {
  late MockCurrencyBloc mockBloc;

  setUpAll(EventFallbacks.registerCurrencyEvents);

  setUp(() {
    mockBloc = MockCurrencyBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  group('CurrencyConverterView', () {
    testWidgets('shows status header with success icon', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          updatedDate: '2026-01-17T10:30:00',
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows loading indicator when loading', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(loadState: Loading()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Updating rates...'), findsOneWidget);
    });

    testWidgets('shows currency converter section', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: TestData.mockRates,
          fromCurrency: TestData.usdCurrency,
          toCurrency: TestData.eurCurrency,
          fromAmountText: '100',
          toAmountText: '85',
        ),
      );

      expect(find.text('From'), findsOneWidget);
      expect(find.text('To'), findsOneWidget);
    });

    testWidgets('shows swap button', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: TestData.mockRates,
          fromCurrency: TestData.usdCurrency,
          toCurrency: TestData.eurCurrency,
        ),
      );

      expect(find.byIcon(Icons.swap_vert), findsOneWidget);
    });

    testWidgets('shows currency codes when currencies are selected', (
      tester,
    ) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: TestData.mockRates,
          fromCurrency: TestData.usdCurrency,
          toCurrency: TestData.eurCurrency,
        ),
      );

      expect(find.text('USD'), findsOneWidget);
      expect(find.text('EUR'), findsOneWidget);
    });

    testWidgets('shows "Select" when no currencies selected', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: [],
          fromCurrency: null,
          toCurrency: null,
        ),
      );

      expect(find.text('Select'), findsNWidgets(2));
    });

    testWidgets('shows exchange rate info when currencies are selected', (
      tester,
    ) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: TestData.mockRates,
          fromCurrency: TestData.usdCurrency,
          toCurrency: TestData.eurCurrency,
        ),
      );

      expect(find.text('Exchange Rate'), findsOneWidget);
      expect(find.byIcon(Icons.currency_exchange), findsOneWidget);
    });

    testWidgets('tapping swap button triggers event', (tester) async {
      await tester.pumpConverterView(
        mockBloc,
        const CurrencyState(
          loadState: Success(),
          rates: TestData.mockRates,
          fromCurrency: TestData.usdCurrency,
          toCurrency: TestData.eurCurrency,
        ),
      );

      await tester.tap(find.byIcon(Icons.swap_vert));
      await tester.pump();

      verify(() => mockBloc.add(any(that: isA<CurrenciesSwapped>()))).called(1);
    });
  });
}
