import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/core/ui/widgets/theme_toggle.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:currency_converter/presentation/home/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const AppText('Currency Converter'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: const [ThemeToggleButton()],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<CurrencyBloc>().add(CurrencyRatesRefreshed());
          // Wait a bit for the refresh to complete
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: const CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            // Status Header
            SliverToBoxAdapter(child: StatusHeaderView()),

            // Currency Converter Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
                child: CurrencyConverterView(),
              ),
            ),

            // Section Title
            SliverToBoxAdapter(child: CurrencyRateListHeaderView()),

            // Currency Rates List
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
              sliver: CurrencyRateListView(),
            ),

            // Bottom padding
            SliverToBoxAdapter(child: SizedBox(height: Dimens.space32)),
          ],
        ),
      ),
    );
  }
}
