import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:flutter/material.dart';

class CurrencyRateEmptyWidget extends StatelessWidget {
  const CurrencyRateEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(Dimens.paddingLarge),
          child: AppText('No rates available'),
        ),
      ),
    );
  }
}
