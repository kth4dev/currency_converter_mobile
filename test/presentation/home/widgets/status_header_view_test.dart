import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/views/status_header/status_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  late MockCurrencyBloc mockBloc;

  setUp(() {
    mockBloc = MockCurrencyBloc();
  });

  tearDown(() {
    mockBloc.close();
  });

  Future<void> pumpStatusHeader(WidgetTester tester, CurrencyState state) async {
    mockBloc.state = state;

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CurrencyBloc>.value(
          value: mockBloc,
          child: const Scaffold(body: StatusHeaderView()),
        ),
      ),
    );
  }

  group('StatusHeaderView', () {
    testWidgets('shows loading indicator when state is Loading',
        (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(loadState: Loading()),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Updating rates...'), findsOneWidget);
      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('shows success icon when state is Success', (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(
          loadState: Success(),
          updatedDate: '2026-01-17T10:30:00',
        ),
      );

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('shows error message when state is Failure', (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(
          loadState: Failure(
            message: 'Network error',
            type: ErrorType.network,
          ),
        ),
      );

      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('Network error'), findsOneWidget);
    });

    testWidgets('shows initial icon when state is Initial', (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(loadState: Initial()),
      );

      expect(find.byIcon(Icons.hourglass_empty), findsOneWidget);
    });

    testWidgets('shows "No data available" when updatedDate is null',
        (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(
          loadState: Success(),
          updatedDate: null,
        ),
      );

      expect(find.text('No data available'), findsOneWidget);
    });

    testWidgets('formats date correctly when updatedDate is provided',
        (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(
          loadState: Success(),
          updatedDate: '2026-01-17T10:30:00',
        ),
      );

      // Check that "Updated:" prefix is shown
      expect(find.textContaining('Updated:'), findsOneWidget);
    });

    testWidgets('no loading indicator when state is not Loading',
        (tester) async {
      await pumpStatusHeader(
        tester,
        const CurrencyState(loadState: Success()),
      );

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });
  });
}
