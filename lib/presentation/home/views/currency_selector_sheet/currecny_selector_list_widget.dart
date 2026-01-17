import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/domain/domain.dart';
import 'package:currency_converter/presentation/home/views/currency_selector_sheet/currency_selector_list_item_widget.dart';
import 'package:flutter/cupertino.dart';

class CurrencySelectorListWidget extends StatelessWidget {
  final List<CurrencyRateEntity> rates;
  final ScrollController controller;
  final ValueChanged<CurrencyRateEntity> onSelect;

  const CurrencySelectorListWidget({
    super.key,
    required this.rates,
    required this.controller,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: rates.length,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingBase),
      itemBuilder: (context, index) {
        final currency = rates[index];
        return CurrencySelectorListItemWidget(
          currency: currency,
          onTap: () => onSelect(currency),
        );
      },
    );
  }
}
