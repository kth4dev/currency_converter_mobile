import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashState', () {
    test('copyWith creates new instance with updated values', () {
      const initial = SplashState();
      final updated = initial.copyWith(
        initState: const Loading(),
        initProcessMessage: 'Loading...',
      );

      expect(updated.initState, isA<Loading>());
      expect(updated.initProcessMessage, 'Loading...');
    });

    test('copyWith preserves original values when not specified', () {
      const initial = SplashState(
        initState: Loading(),
        initProcessMessage: 'Loading...',
      );

      final updated = initial.copyWith(initProcessMessage: 'Done!');

      expect(updated.initState, isA<Loading>());
      expect(updated.initProcessMessage, 'Done!');
    });

    test('default state values are correct', () {
      const state = SplashState();

      expect(state.initState, isA<Initial>());
      expect(state.initProcessMessage, '');
    });
  });
}
