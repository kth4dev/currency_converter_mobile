import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:flutter/material.dart';

class AppFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width, height;
  final Color? backgroundColor, color;

  const AppFilledButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? Dimens.buttonHeight,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
          ),
        ),
        child: AppText(text),
      ),
    );
  }
}
