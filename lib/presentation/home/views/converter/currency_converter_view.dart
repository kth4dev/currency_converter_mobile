import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/currency_inputs_card/currency_input_card_widget.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/exchange_rate_info_widget.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/swap_button_widget.dart';
import 'package:currency_converter/presentation/home/views/currency_selector_sheet/currency_selector_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterView extends StatelessWidget {
  const CurrencyConverterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CurrencyBloc,
      CurrencyState,
      (
        CurrencyRateEntity?,
        CurrencyRateEntity?,
        List<CurrencyRateEntity>,
        String,
        String,
      )
    >(
      selector: (state) => (
        state.fromCurrency,
        state.toCurrency,
        state.rates,
        state.fromAmountText,
        state.toAmountText,
      ),
      builder: (context, data) {
        final (fromCurrency, toCurrency, rates, fromAmountText, toAmountText) =
            data;

        return Container(
          padding: const EdgeInsets.all(Dimens.paddingDefault),
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
            border: Border.all(color: context.colors.outlineVariant, width: 1),
          ),
          child: Column(
            children: [
              // From Currency Input
              CurrencyInputCardWidget(
                label: 'From',
                currency: fromCurrency,
                amountText: fromAmountText,
                onAmountChanged: (value) {
                  context.read<CurrencyBloc>().add(FromAmountChanged(value));
                },
                onCurrencyTap: () {
                  CurrencySelectorSheet.show(context, rates, (currency) {
                    context.read<CurrencyBloc>().add(
                      FromCurrencySelected(currency),
                    );
                  });
                },
              ),

              // Swap Button
              SwapButtonWidget(
                onPressed: () {
                  context.read<CurrencyBloc>().add(CurrenciesSwapped());
                },
              ),

              // To Currency Input
              CurrencyInputCardWidget(
                label: 'To',
                currency: toCurrency,
                amountText: toAmountText,
                onAmountChanged: (value) {
                  context.read<CurrencyBloc>().add(ToAmountChanged(value));
                },
                onCurrencyTap: () {
                  CurrencySelectorSheet.show(context, rates, (currency) {
                    context.read<CurrencyBloc>().add(
                      ToCurrencySelected(currency),
                    );
                  });
                },
              ),

              // spacing
              const SizedBox(height: Dimens.space16),

              // Exchange Rate Info
              ExchangeRateInfoWidget(from: fromCurrency, to: toCurrency),
            ],
          ),
        );
      },
    );
  }
}
