import 'package:flutter/material.dart';

class TextContentThemeToken {
  final Color titleColor;
  final Color descriptionColor;
  final Color answerColor;

  final String? fontFamily;
  final double smallSize;
  final double mediumSize;
  final double largeSize;

  const TextContentThemeToken({
    required this.titleColor,
    required this.descriptionColor,
    required this.answerColor,
    this.fontFamily,
    this.smallSize = 12,
    this.mediumSize = 14,
    this.largeSize = 18,
  });

  factory TextContentThemeToken.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const TextContentThemeToken(
        titleColor: Colors.black,
        descriptionColor: Colors.grey,
        answerColor: Colors.blueAccent,
      );
    }

    return TextContentThemeToken(
      titleColor: Color(int.parse(json['titleColor'] ?? '0xff000000')),
      descriptionColor: Color(int.parse(json['descriptionColor'] ?? '0xff666666')),
      answerColor: Color(int.parse(json['answerColor'] ?? '0xff1E88E5')),
      fontFamily: json['fontFamily'],
      smallSize: (json['smallSize'] ?? 12).toDouble(),
      mediumSize: (json['mediumSize'] ?? 14).toDouble(),
      largeSize: (json['largeSize'] ?? 18).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'titleColor': titleColor.value.toRadixString(16),
        'descriptionColor': descriptionColor.value.toRadixString(16),
        'answerColor': answerColor.value.toRadixString(16),
        'fontFamily': fontFamily,
        'smallSize': smallSize,
        'mediumSize': mediumSize,
        'largeSize': largeSize,
      };
}
