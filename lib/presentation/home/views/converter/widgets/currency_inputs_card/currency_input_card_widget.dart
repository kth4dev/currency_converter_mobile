import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/currency_inputs_card/currency_amount_input_widget.dart';
import 'package:currency_converter/presentation/home/views/converter/widgets/currency_inputs_card/currency_selector_widget.dart';
import 'package:flutter/material.dart';

class CurrencyInputCardWidget extends StatelessWidget {
  final String label;
  final String amountText;
  final CurrencyRateEntity? currency;
  final ValueChanged<String> onAmountChanged;
  final VoidCallback onCurrencyTap;

  const CurrencyInputCardWidget({
    super.key,
    required this.label,
    required this.currency,
    required this.amountText,
    required this.onAmountChanged,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.paddingDefault),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Dimens.space8,
        children: [
          AppText(
            label,
            style: context.textStyles.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: CurrencySelectorWidget(
                  currency: currency,
                  onTap: onCurrencyTap,
                ),
              ),
              const SizedBox(width: Dimens.space12),
              Expanded(
                flex: 2,
                child: CurrencyAmountTextFieldWidget(
                  amountText: amountText,
                  onChanged: onAmountChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
