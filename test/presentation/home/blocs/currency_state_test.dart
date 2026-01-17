import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_helpers.dart';

void main() {
  group('CurrencyState', () {
    test('copyWith creates new instance with updated values', () {
      const initial = CurrencyState();
      final updated = initial.copyWith(
        loadState: const Loading(),
        fromAmount: 50.0,
        fromAmountText: '50',
      );

      expect(updated.loadState, isA<Loading>());
      expect(updated.fromAmount, 50.0);
      expect(updated.fromAmountText, '50');
      // Original values should be preserved
      expect(updated.rates, initial.rates);
      expect(updated.fromCurrency, initial.fromCurrency);
    });

    test('copyWith preserves original values when not specified', () {
      const initial = CurrencyState(
        loadState: Success(),
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
        toCurrency: TestData.eurCurrency,
        fromAmount: 100.0,
        fromAmountText: '100',
        toAmountText: '85',
        updatedDate: TestData.updatedDate,
      );

      final updated = initial.copyWith(fromAmount: 200.0);

      expect(updated.loadState, isA<Success>());
      expect(updated.rates, TestData.mockRates);
      expect(updated.fromCurrency, TestData.usdCurrency);
      expect(updated.toCurrency, TestData.eurCurrency);
      expect(updated.fromAmount, 200.0);
      expect(updated.fromAmountText, '100');
      expect(updated.toAmountText, '85');
      expect(updated.updatedDate, TestData.updatedDate);
    });

    test('props are correct for equality comparison', () {
      const state1 = CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
      );
      const state2 = CurrencyState(
        rates: TestData.mockRates,
        fromCurrency: TestData.usdCurrency,
      );

      expect(state1, equals(state2));
      expect(state1.props, equals(state2.props));
    });

    test('default state values are correct', () {
      const state = CurrencyState();

      expect(state.loadState, isA<Initial>());
      expect(state.fromCurrency, isNull);
      expect(state.toCurrency, isNull);
      expect(state.updatedDate, isNull);
      expect(state.rates, isEmpty);
      expect(state.fromAmount, 1.0);
      expect(state.fromAmountText, '1');
      expect(state.toAmountText, '');
    });
  });
}
