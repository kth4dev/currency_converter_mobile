import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/domain/entities/currency_rate_entity.dart';
import 'package:currency_converter/presentation/home/views/currency_selector_sheet/currecny_selector_list_widget.dart';
import 'package:flutter/material.dart';

class CurrencySelectorSheet extends StatefulWidget {
  final List<CurrencyRateEntity> rates;
  final ValueChanged<CurrencyRateEntity> onSelect;

  const CurrencySelectorSheet({
    super.key,
    required this.rates,
    required this.onSelect,
  });

  static void show(
    BuildContext context,
    List<CurrencyRateEntity> rates,
    ValueChanged<CurrencyRateEntity> onSelect,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CurrencySelectorSheet(
        rates: rates,
        onSelect: (currency) {
          onSelect(currency);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  State<CurrencySelectorSheet> createState() => _CurrencySelectorSheetState();
}

class _CurrencySelectorSheetState extends State<CurrencySelectorSheet> {
  final _searchController = TextEditingController();
  List<CurrencyRateEntity> _filteredRates = [];

  @override
  void initState() {
    super.initState();
    _filteredRates = widget.rates;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRates(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRates = widget.rates;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredRates = widget.rates.where((rate) {
          return rate.code.toLowerCase().contains(lowerQuery) ||
              (rate.currencyName?.toLowerCase().contains(lowerQuery) ??
                  false) ||
              (rate.countryName?.toLowerCase().contains(lowerQuery) ?? false);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(Dimens.radiusXXLarge),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: Dimens.paddingDefault),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.colors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.all(Dimens.paddingMedium),
                child: AppText(
                  'Select Currency',
                  style: context.textStyles.titleLarge,
                ),
              ),

              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.paddingMedium,
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: _filterRates,
                  decoration: InputDecoration(
                    hintText: 'Search currency...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: context.colors.surfaceContainerHighest,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimens.radiusLarge),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: Dimens.paddingMedium,
                      vertical: Dimens.paddingDefault,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: Dimens.space8),

              // Currency list
              Expanded(
                child: CurrencySelectorListWidget(
                  rates: _filteredRates,
                  controller: scrollController,
                  onSelect: widget.onSelect,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
