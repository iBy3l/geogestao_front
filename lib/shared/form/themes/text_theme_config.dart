import 'package:flutter/material.dart';

import '../enum/element_enum.dart';

/// 🔹 Tamanho de texto do tema global

/// 🔹 Tema global do texto (vindo do formulário)
class TextThemeConfig {
  final Color color;
  final TextAlign alignment;
  final TextSize size;

  const TextThemeConfig({
    this.color = Colors.black,
    this.alignment = TextAlign.left,
    this.size = TextSize.medium,
  });

  TextStyle toTextStyle(BuildContext context, {bool isFocused = false}) {
    final theme = Theme.of(context);
    final scale = switch (size) {
      TextSize.small => 1.0,
      TextSize.medium => 1.3,
      TextSize.large => 1.6,
    };

    return theme.textTheme.bodyMedium!.copyWith(
      fontSize: theme.textTheme.bodyMedium!.fontSize! * scale,
      color: isFocused ? color.withOpacity(0.85) : color,
    );
  }
}
