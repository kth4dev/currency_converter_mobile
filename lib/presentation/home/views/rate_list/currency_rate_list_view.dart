import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/views/rate_list/currency_rate_empty_widget.dart';
import 'package:currency_converter/presentation/home/views/rate_list/currency_rate_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyRateListView extends StatelessWidget {
  const CurrencyRateListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      CurrencyBloc,
      CurrencyState,
      (List<CurrencyRateEntity>, CurrencyRateEntity?)
    >(
      selector: (state) => (state.rates, state.fromCurrency),
      builder: (context, data) {
        final (rates, baseCurrency) = data;

        return (rates.isEmpty)
            ? const CurrencyRateEmptyWidget()
            : SliverList.builder(
                itemCount: rates.length,
                itemBuilder: (context, index) {
                  final rate = rates[index];
                  return CurrencyRateListItemWidget(
                    currency: rate,
                    baseCurrency: baseCurrency,
                  );
                },
              );
      },
    );
  }
}
