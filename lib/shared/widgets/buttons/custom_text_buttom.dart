import 'package:flutter/material.dart';
import '/core/core.dart';

class CustomTextButtom extends StatelessWidget {
  const CustomTextButtom({super.key, required this.onPressed, this.text, this.textAlign, this.style});

  final Function() onPressed;
  final String? text;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: style ?? TextStyle(color: context.theme.colorScheme.onPrimary),
      ),
    );
  }
}
