import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/core/utils/currency_utils.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:flutter/material.dart';

class ExchangeRateInfoWidget extends StatelessWidget {
  final CurrencyRateEntity? from;
  final CurrencyRateEntity? to;

  const ExchangeRateInfoWidget({
    super.key,
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    if (from == null || to == null) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(Dimens.paddingDefault),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            context.colors.primary,
            context.colors.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(Dimens.radiusLarge),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.currency_exchange,
                color: context.colors.onPrimary.withValues(alpha: 0.8),
                size: 16,
              ),
              const SizedBox(width: Dimens.space4),
              AppText(
                'Exchange Rate',
                style: context.textStyles.labelSmall?.copyWith(
                  color: context.colors.onPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimens.space8),
          AppText(
            CurrencyUtils.formatExchangeRateString(from: from!, to: to!),
            style: context.textStyles.titleMedium?.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: Dimens.space4),
          AppText(
            CurrencyUtils.formatExchangeRateString(from: to!, to: from!),
            style: context.textStyles.bodySmall?.copyWith(
              color: context.colors.onPrimary.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
