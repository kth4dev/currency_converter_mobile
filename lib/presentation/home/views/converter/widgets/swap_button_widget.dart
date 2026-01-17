import 'package:currency_converter/core/theme/dimens.dart';
import 'package:flutter/material.dart';

class SwapButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const SwapButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.paddingBase,
        vertical: Dimens.paddingSmall,
      ),
      child: Row(
        spacing: Dimens.space8,
        children: [
          _divider,
          IconButton.filled(
            onPressed: onPressed,
            icon: const Icon(Icons.swap_vert),
          ),
          _divider,
        ],
      ),
    );
  }

  Widget get _divider => const Expanded(child: Divider());
}
