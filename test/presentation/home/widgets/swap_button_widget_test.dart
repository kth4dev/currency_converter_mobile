import 'package:currency_converter/presentation/home/views/converter/widgets/swap_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('SwapButtonWidget', () {
    testWidgets('renders swap icon button', (tester) async {
      await tester.pumpApp(
        SwapButtonWidget(onPressed: () {}),
      );

      expect(find.byIcon(Icons.swap_vert), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
    });

    testWidgets('renders dividers on both sides', (tester) async {
      await tester.pumpApp(
        SwapButtonWidget(onPressed: () {}),
      );

      expect(find.byType(Divider), findsNWidgets(2));
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var pressed = false;

      await tester.pumpApp(
        SwapButtonWidget(onPressed: () => pressed = true),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('button is centered between dividers', (tester) async {
      await tester.pumpApp(
        SwapButtonWidget(onPressed: () {}),
      );

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.children.length, 3);
    });
  });
}
