import 'package:currency_converter/core/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CurrencyAmountTextFieldWidget extends StatefulWidget {
  final String amountText;
  final ValueChanged<String> onChanged;

  const CurrencyAmountTextFieldWidget({
    super.key,
    required this.amountText,
    required this.onChanged,
  });

  @override
  State<CurrencyAmountTextFieldWidget> createState() =>
      _CurrencyAmountTextFieldWidgetState();
}

class _CurrencyAmountTextFieldWidgetState
    extends State<CurrencyAmountTextFieldWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.amountText);
  }

  @override
  void didUpdateWidget(covariant CurrencyAmountTextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amountText != _controller.text) {
      _controller.text = widget.amountText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textAlign: TextAlign.end,
      style: context.textStyles.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      decoration: InputDecoration(
        hintText: '0.00',
        hintStyle: context.textStyles.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: context.colors.onSurfaceVariant.withValues(alpha: 0.5),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
        isDense: true,
      ),
      onChanged: widget.onChanged,
    );
  }
}
