import 'package:flutter/material.dart';
import '/core/core.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key, required this.text, this.color, this.backgroundColor});

  final String text;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? context.theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(45),
        border: Border.all(color: color ?? context.theme.primaryColor),
      ),
      child: Text(text, style: context.textTheme.titleMedium?.copyWith(color: color ?? context.theme.colorScheme.primary)),
    );
  }
}
