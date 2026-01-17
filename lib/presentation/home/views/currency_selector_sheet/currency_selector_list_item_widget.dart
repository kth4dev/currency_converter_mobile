import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/images/cache_network_image.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/core/utils/currency_utils.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:flutter/material.dart';

class CurrencySelectorListItemWidget extends StatelessWidget {
  final CurrencyRateEntity currency;
  final VoidCallback onTap;

  const CurrencySelectorListItemWidget({
    super.key,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: AppCacheNetworkImage(
        width: 48,
        height: 48,
        imageUrl: currency.icon ?? '',
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
      title: AppText(
        currency.code,
        style: context.textStyles.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: currency.currencyName != null
          ? AppText(
              currency.currencyName!,
              style: context.textStyles.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      trailing: AppText(
        CurrencyUtils.formatRate(currency.rate),
        style: context.textStyles.bodyMedium?.copyWith(
          color: context.colors.onSurfaceVariant,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Dimens.paddingBase,
        vertical: Dimens.space2,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimens.radiusMedium),
      ),
    );
  }
}
