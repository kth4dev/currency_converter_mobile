import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/images/cache_network_image.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:flutter/material.dart';

class CurrencySelectorWidget extends StatelessWidget {
  final CurrencyRateEntity? currency;
  final VoidCallback onTap;

  const CurrencySelectorWidget({super.key, required this.currency, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      child: Row(
        children: [
          AppCacheNetworkImage(
            width: 40,
            height: 40,
            imageUrl: currency?.icon ?? '',
            borderRadius: BorderRadius.circular(Dimens.radiusSmall),
          ),
          const SizedBox(width: Dimens.space8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  currency?.code ?? 'Select',
                  style: context.textStyles.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (currency?.currencyName != null)
                  AppText(
                    currency!.currencyName!,
                    style: context.textStyles.labelSmall?.copyWith(
                      color: context.colors.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: context.colors.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}
