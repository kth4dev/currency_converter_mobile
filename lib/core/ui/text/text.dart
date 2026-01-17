import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const AppText(
    this.label, {
    super.key,
    this.style,
    this.maxLines,
    this.textAlign,
    this.overflow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style?.copyWith(color: color),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
