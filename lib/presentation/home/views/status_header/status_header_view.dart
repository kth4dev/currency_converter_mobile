import 'package:currency_converter/core/common/view_state.dart';
import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:currency_converter/core/utils/date_utils.dart';
import 'package:currency_converter/presentation/home/blocs/currency_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusHeaderView extends StatelessWidget {
  const StatusHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CurrencyBloc, CurrencyState, (ViewState, String?)>(
      selector: (state) => (state.loadState, state.updatedDate),
      builder: (context, data) {
        final (loadState, updatedDate) = data;

        return Container(
          padding: const EdgeInsets.all(Dimens.paddingMedium),
          child: Row(
            children: [
              _buildStatusIndicator(context, loadState),
              const SizedBox(width: Dimens.space8),
              Expanded(
                child: _buildStatusText(context, loadState, updatedDate),
              ),
              if (loadState is Loading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusIndicator(BuildContext context, ViewState loadState) {
    final (color, icon) = switch (loadState) {
      Loading() => (context.colors.primary, Icons.sync),
      Success() => (Colors.green, Icons.check_circle),
      Failure() => (context.colors.error, Icons.error),
      Initial() => (context.colors.outline, Icons.hourglass_empty),
    };

    return Icon(icon, color: color, size: 18);
  }

  Widget _buildStatusText(
    BuildContext context,
    ViewState loadState,
    String? updatedDate,
  ) {
    final statusText = switch (loadState) {
      Loading() => 'Updating rates...',
      Failure(:final message) => message,
      _ => AppDateUtils.formatUpdatedDate(updatedDate),
    };

    return AppText(
      statusText,
      style: context.textStyles.bodySmall?.copyWith(
        color: loadState is Failure
            ? context.colors.error
            : context.colors.onSurfaceVariant,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
