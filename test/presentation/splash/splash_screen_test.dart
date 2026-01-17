import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:currency_converter/presentation/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/widget_test_helpers.dart';

void main() {
  late MockSplashCubit mockCubit;

  setUp(() {
    mockCubit = MockSplashCubit();
    when(() => mockCubit.initialize()).thenAnswer((_) async {});
  });

  tearDown(() {
    mockCubit.close();
  });

  Future<void> pumpSplashScreen(
    WidgetTester tester,
    SplashState state,
  ) async {
    mockCubit.state = state;

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SplashCubit>.value(
          value: mockCubit,
          child: const SplashScreen(),
        ),
      ),
    );
  }

  group('SplashScreen', () {
    testWidgets('calls initialize on init', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(),
      );

      verify(() => mockCubit.initialize()).called(1);
    });

    testWidgets('renders Scaffold', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders Stack for layered content', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(),
      );

      // There may be multiple Stacks in the widget tree
      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('shows process message when loading', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(
          initState: Initial(),
          initProcessMessage: 'Getting available currencies...',
        ),
      );

      expect(find.text('Getting available currencies...'), findsOneWidget);
    });

    testWidgets('shows updating rates message', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(
          initState: Initial(),
          initProcessMessage: 'Updating exchange rates...',
        ),
      );

      expect(find.text('Updating exchange rates...'), findsOneWidget);
    });

    testWidgets('shows error message on failure', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(
          initState: Failure(
            message: 'Network error',
            type: ErrorType.network,
          ),
        ),
      );

      expect(find.textContaining('Network error'), findsOneWidget);
    });

    testWidgets('shows setup complete message', (tester) async {
      await pumpSplashScreen(
        tester,
        const SplashState(
          initState: Initial(),
          initProcessMessage: 'Setup complete!',
        ),
      );

      expect(find.text('Setup complete!'), findsOneWidget);
    });
  });
}
