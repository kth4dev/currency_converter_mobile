import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'currency_bloc_test_setup.dart';

void main() {
  late CurrencyBlocTestSetup setup;

  setUpAll(CurrencyBlocTestSetup.registerFallbacks);

  setUp(() {
    setup = CurrencyBlocTestSetup();
    setup.initMocks();
  });

  tearDown(() => setup.dispose());

  group('CurrencyBloc Initial State', () {
    test('initial state is correct', () {
      expect(setup.currencyBloc.state, const CurrencyState());
      expect(setup.currencyBloc.state.loadState, isA<Initial>());
      expect(setup.currencyBloc.state.rates, isEmpty);
      expect(setup.currencyBloc.state.fromCurrency, isNull);
      expect(setup.currencyBloc.state.toCurrency, isNull);
      expect(setup.currencyBloc.state.fromAmount, 1.0);
      expect(setup.currencyBloc.state.fromAmountText, '1');
      expect(setup.currencyBloc.state.toAmountText, '');
    });
  });
}
