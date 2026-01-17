import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyRateListHeaderView extends StatelessWidget {
  const CurrencyRateListHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.paddingMedium,
        Dimens.paddingLarge,
        Dimens.paddingMedium,
        Dimens.paddingDefault,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            'Exchange Rates',
            style: context.textStyles.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          BlocSelector<CurrencyBloc, CurrencyState, int>(
            selector: (state) => state.rates.length,
            builder: (context, count) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.paddingBase,
                  vertical: Dimens.space4,
                ),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(Dimens.radiusLarge),
                ),
                child: AppText(
                  '$count currencies',
                  style: context.textStyles.labelSmall?.copyWith(
                    color: context.colors.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
