import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimens.paddingIconStandard),
      decoration: BoxDecoration(
        color: context.colors.primaryContainer,
        borderRadius: BorderRadius.circular(Dimens.radiusXLarge),
      ),
      child: Icon(
        Icons.currency_exchange,
        size: Dimens.appIconSize,
        color:  context.colors.onPrimaryContainer,
      ),
    );
  }
}
