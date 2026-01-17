import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/splash/bloc/splash_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'splash_cubit_test_setup.dart';

void main() {
  late SplashCubitTestSetup setup;

  setUpAll(SplashCubitTestSetup.registerFallbacks);

  setUp(() {
    setup = SplashCubitTestSetup();
    setup.initMocks();
  });

  tearDown(() => setup.dispose());

  group('SplashCubit Initial State', () {
    test('initial state is correct', () {
      expect(setup.splashCubit.state, const SplashState());
      expect(setup.splashCubit.state.initState, isA<Initial>());
      expect(setup.splashCubit.state.initProcessMessage, '');
    });
  });
}
