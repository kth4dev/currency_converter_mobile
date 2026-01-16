import 'package:currency_converter/core/common/error_type.dart';
import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/button/filled_button.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:flutter/material.dart';

class AppErrorPage extends StatelessWidget {
  final String message;
  final ErrorType errorType;
  final VoidCallback? onRetry;
  final bool isSliverWidget;
  final bool isFillRemaining;

  const AppErrorPage({
    super.key,
    required this.message,
    required this.errorType,
    this.onRetry,
    this.isSliverWidget = false,
    this.isFillRemaining = true,
  });

  @override
  Widget build(BuildContext context) {
    final child = Center(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingXLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: Dimens.space24,
          children: [
            Icon(Icons.error_outline, size: Dimens.appIconSize, color: context.colors.error),
            AppText(
              message,
              style: context.textStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null)
              AppFilledButton(
                onPressed: onRetry,
                text: 'Try Again',
                backgroundColor: context.colors.error,
                color: context.colors.onError,
                width: Dimens.retryButtonWidth,
              ),
          ],
        ),
      ),
    );

    if (isSliverWidget) {
      return isFillRemaining
          ? SliverFillRemaining(child: child)
          : SliverToBoxAdapter(child: child);
    }

    return child;
  }
}
