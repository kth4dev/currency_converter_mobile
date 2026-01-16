import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class AppLogoAndName extends StatelessWidget {
  const AppLogoAndName({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Dimens.space8,
        children: [
          const AppIcon(),
          Text('Currency Converter', style: context.textStyles.titleLarge),
        ],
      ),
    );
  }
}
