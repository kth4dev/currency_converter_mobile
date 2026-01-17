import 'package:currency_converter/core/theme/dimens.dart';
import 'package:currency_converter/core/ui/text/text.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width, height;
  final Color? backgroundColor, color;
  final Widget? prefixIcon;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.color,
    this.width,
    this.height,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? Dimens.buttonHeight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
          ),
        ),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
          spacing: Dimens.space8,
          children: [?prefixIcon, AppText(text)],
        ),
      ),
    );
  }
}
