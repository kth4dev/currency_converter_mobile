import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/images/cache_network_image.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/core/utils/currency_utils.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:flutter/material.dart';

class CurrencyRateListItemWidget extends StatelessWidget {
  final CurrencyRateEntity currency;
  final CurrencyRateEntity? baseCurrency;

  const CurrencyRateListItemWidget({
    super.key,
    required this.currency,
    this.baseCurrency,
  });

  @override
  Widget build(BuildContext context) {
    final relativeRate = _calculateRelativeRate();
    final formattedRate = CurrencyUtils.formatRate(relativeRate);

    return Container(
      margin: const EdgeInsets.only(bottom: Dimens.paddingBase),
      padding: const EdgeInsets.all(Dimens.paddingDefault),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Dimens.radiusLarge),
      ),
      child: Row(
        children: [
          // Flag/Icon
          AppCacheNetworkImage(
            width: 48,
            height: 48,
            imageUrl: currency.icon ?? '',
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
          ),
          const SizedBox(width: Dimens.space12),

          // Currency Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      currency.code,
                      style: context.textStyles.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (currency.countryCode != null) ...[
                      const SizedBox(width: Dimens.space4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.space4,
                          vertical: Dimens.space1,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.outlineVariant.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(Dimens.radiusXS),
                        ),
                        child: AppText(
                          currency.countryCode!,
                          style: context.textStyles.labelSmall?.copyWith(
                            color: context.colors.onSurfaceVariant,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (currency.currencyName != null)
                  AppText(
                    currency.currencyName!,
                    style: context.textStyles.bodySmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          // Rate
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                formattedRate,
                style: context.textStyles.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.colors.primary,
                ),
              ),
              if (baseCurrency != null)
                AppText(
                  '1 ${baseCurrency!.code}',
                  style: context.textStyles.labelSmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  double _calculateRelativeRate() {
    if (baseCurrency == null) return currency.rate;
    return CurrencyUtils.exchangeRate(from: baseCurrency!, to: currency);
  }
}
