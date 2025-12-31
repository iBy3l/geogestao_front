// lib/shared/form/entities/global_form_theme.dart
import 'package:flutter/material.dart';

import '../enum/element_enum.dart';

class GlobalFormTheme {
  final String? fontFamily;
  final TextSize sizeTitle;
  final TextSize sizeDescription;
  final TextSize sizeAnswer;
  final Color colorTitle;
  final Color colorDescription;
  final Color colorAnswer;
  final TextAlign alignTitle;
  final TextAlign alignDescription;
  final TextAlign alignAnswer;

  const GlobalFormTheme({
    this.fontFamily,
    this.sizeTitle = TextSize.large,
    this.sizeDescription = TextSize.medium,
    this.sizeAnswer = TextSize.medium,
    this.colorTitle = const Color(0xFF111111),
    this.colorDescription = const Color(0xFF666666),
    this.colorAnswer = const Color(0xFF111111),
    this.alignTitle = TextAlign.left,
    this.alignDescription = TextAlign.left,
    this.alignAnswer = TextAlign.left,
  });

  // ===============================
  // ✅ Serialização compatível com Supabase
  // ===============================

  factory GlobalFormTheme.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const GlobalFormTheme();

    return GlobalFormTheme(
      fontFamily: json['font_family'],
      sizeTitle: TextSizeX.fromString(json['size_title']),
      sizeDescription: TextSizeX.fromString(json['size_description']),
      sizeAnswer: TextSizeX.fromString(json['size_answer']),
      colorTitle: Color(json['color_title'] ?? 0xFF111111),
      colorDescription: Color(json['color_description'] ?? 0xFF666666),
      colorAnswer: Color(json['color_answer'] ?? 0xFF111111),
      alignTitle: TextAlignX.fromString(json['align_title']),
      alignDescription: TextAlignX.fromString(json['align_description']),
      alignAnswer: TextAlignX.fromString(json['align_answer']),
    );
  }

  Map<String, dynamic> toJson() => {
        'font_family': fontFamily,
        'size_title': sizeTitle.name,
        'size_description': sizeDescription.name,
        'size_answer': sizeAnswer.name,
        'color_title': colorTitle.value,
        'color_description': colorDescription.value,
        'color_answer': colorAnswer.value,
        'align_title': alignTitle.name,
        'align_description': alignDescription.name,
        'align_answer': alignAnswer.name,
      };

  // ===============================
  // ✅ Utilitários de estilo (UI)
  // ===============================

  TextStyle titleStyle(BuildContext c) => _styleFrom(c, sizeTitle, colorTitle, fontFamily);
  TextStyle descriptionStyle(BuildContext c) => _styleFrom(c, sizeDescription, colorDescription, fontFamily, italic: true);
  TextStyle answerStyle(BuildContext c) => _styleFrom(c, sizeAnswer, colorAnswer, fontFamily);

  TextStyle _styleFrom(BuildContext c, TextSize s, Color color, String? font, {bool italic = false}) {
    final base = Theme.of(c).textTheme;
    TextStyle ref = switch (s) {
      TextSize.small => base.bodySmall ?? const TextStyle(fontSize: 12),
      TextSize.medium => base.bodyMedium ?? const TextStyle(fontSize: 14),
      TextSize.large => base.titleMedium ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    };
    return ref.copyWith(
      color: color,
      fontFamily: font,
      fontStyle: italic ? FontStyle.italic : null,
    );
  }

  GlobalFormTheme copyWith({
    String? fontFamily,
    TextSize? sizeTitle,
    TextSize? sizeDescription,
    TextSize? sizeAnswer,
    Color? colorTitle,
    Color? colorDescription,
    Color? colorAnswer,
    TextAlign? alignTitle,
    TextAlign? alignDescription,
    TextAlign? alignAnswer,
  }) {
    return GlobalFormTheme(
      fontFamily: fontFamily ?? this.fontFamily,
      sizeTitle: sizeTitle ?? this.sizeTitle,
      sizeDescription: sizeDescription ?? this.sizeDescription,
      sizeAnswer: sizeAnswer ?? this.sizeAnswer,
      colorTitle: colorTitle ?? this.colorTitle,
      colorDescription: colorDescription ?? this.colorDescription,
      colorAnswer: colorAnswer ?? this.colorAnswer,
      alignTitle: alignTitle ?? this.alignTitle,
      alignDescription: alignDescription ?? this.alignDescription,
      alignAnswer: alignAnswer ?? this.alignAnswer,
    );
  }
}
