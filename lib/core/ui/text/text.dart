import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final TextStyle? style;
  final Color? color;
  final int? maxLine;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const AppText(
    this.label, {
    super.key,
    this.style,
    this.maxLine,
    this.textAlign,
    this.overflow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: style?.copyWith(color: color),
      maxLines: maxLine,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
