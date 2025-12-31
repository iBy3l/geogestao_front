import 'package:flutter/material.dart';

class BaseFormTheme {
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final double maxWidth;
  final EdgeInsets padding;
  final Alignment alignment;
  final Color shadowColor;
  final double shadowBlur;

  const BaseFormTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.borderWidth,
    required this.maxWidth,
    required this.padding,
    required this.alignment,
    required this.shadowColor,
    required this.shadowBlur,
  });

  factory BaseFormTheme.defaultTheme(BuildContext context) {
    final theme = Theme.of(context);
    return BaseFormTheme(
      backgroundColor: theme.colorScheme.surface,
      borderColor: theme.colorScheme.outline.withOpacity(0.2),
      borderRadius: 12,
      borderWidth: 1.5,
      maxWidth: 800,
      padding: const EdgeInsets.all(24),
      alignment: Alignment.center,
      shadowColor: theme.shadowColor.withOpacity(0.1),
      shadowBlur: 10,
    );
  }

  factory BaseFormTheme.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return BaseFormTheme.defaultTheme(
        WidgetsBinding.instance.platformDispatcher.views.first.platformDispatcher.defaultRouteName == '/'
            ? WidgetsBinding.instance.platformDispatcher.views.first.platformDispatcher.defaultRouteName as BuildContext
            : WidgetsBinding.instance.rootElement!.renderObject!.owner as BuildContext,
      );
    }

    return BaseFormTheme(
      backgroundColor: Color(int.parse(json['backgroundColor'] ?? '0xffffffff')),
      borderColor: Color(int.parse(json['borderColor'] ?? '0xffE0E0E0')),
      borderRadius: (json['borderRadius'] ?? 12).toDouble(),
      borderWidth: (json['borderWidth'] ?? 1.5).toDouble(),
      maxWidth: (json['maxWidth'] ?? 800).toDouble(),
      padding: _parseEdgeInsets(json['padding']),
      alignment: _parseAlignment(json['alignment']),
      shadowColor: Color(int.parse(json['shadowColor'] ?? '0x1A000000')),
      shadowBlur: (json['shadowBlur'] ?? 10).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'backgroundColor': backgroundColor.value.toRadixString(16),
        'borderColor': borderColor.value.toRadixString(16),
        'borderRadius': borderRadius,
        'borderWidth': borderWidth,
        'maxWidth': maxWidth,
        'padding': {
          'top': padding.top,
          'bottom': padding.bottom,
          'left': padding.left,
          'right': padding.right,
        },
        'alignment': alignment.toString(),
        'shadowColor': shadowColor.value.toRadixString(16),
        'shadowBlur': shadowBlur,
      };

  static EdgeInsets _parseEdgeInsets(Map<String, dynamic>? json) {
    if (json == null) return const EdgeInsets.all(24);
    return EdgeInsets.only(
      top: (json['top'] ?? 24).toDouble(),
      bottom: (json['bottom'] ?? 24).toDouble(),
      left: (json['left'] ?? 24).toDouble(),
      right: (json['right'] ?? 24).toDouble(),
    );
  }

  static Alignment _parseAlignment(dynamic value) {
    switch (value) {
      case 'topCenter':
        return Alignment.topCenter;
      case 'bottomCenter':
        return Alignment.bottomCenter;
      case 'centerLeft':
        return Alignment.centerLeft;
      default:
        return Alignment.center;
    }
  }
}
