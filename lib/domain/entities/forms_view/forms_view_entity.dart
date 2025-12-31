import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class FormsViewEntity {
  final String id;
  final String name;
  final String slug;
  final GlobalFormTheme? theme;
  final FormConfigEntity config;
  final String status;
  final String accessMode;
  final bool isPublished;
  final bool showBranding;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FormsViewEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.config,
    this.theme,
    required this.status,
    required this.accessMode,
    required this.isPublished,
    required this.showBranding,
    required this.createdAt,
    required this.updatedAt,
  });
  factory FormsViewEntity.fromJson(Map<String, dynamic> json) {
    final form = json['form'] ?? {};

    return FormsViewEntity(
      id: form['id'] ?? '',
      name: form['name'] ?? '',
      slug: form['slug'] ?? '',
      theme: form['theme'] != null ? GlobalFormTheme.fromJson(form['theme']) : const GlobalFormTheme(),
      config: FormConfigEntity.fromJson(form['config'] ?? {}),
      status: form['status'] ?? 'draft',
      accessMode: form['access_mode'] ?? 'public',
      isPublished: (form['is_published'] == true || form['is_published'] == 't' || form['is_published'] == 'true'),
      showBranding: form['show_branding'] == true || form['show_branding'] == 't',
      createdAt: DateTime.tryParse(form['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(form['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'theme': theme?.toJson(),
        'config': config.toJson(),
        'status': status,
        'access_mode': accessMode,
        'is_published': isPublished,
        'show_branding': showBranding,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  // copyWith para facilitar atualizações
  FormsViewEntity copyWith({
    String? id,
    String? name,
    String? slug,
    GlobalFormTheme? theme,
    FormConfigEntity? config,
    String? status,
    String? accessMode,
    bool? isPublished,
    bool? showBranding,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FormsViewEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      theme: theme ?? this.theme,
      config: config ?? this.config,
      status: status ?? this.status,
      accessMode: accessMode ?? this.accessMode,
      isPublished: isPublished ?? this.isPublished,
      showBranding: showBranding ?? this.showBranding,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class FormConfigEntity {
  final List<ElementEntity> questions;

  const FormConfigEntity({this.questions = const []});

  factory FormConfigEntity.fromJson(Map<String, dynamic> json) {
    // ✅ Lê os passos dentro de config.form.steps
    final steps = (json['form']?['steps'] as List?) ?? [];

    return FormConfigEntity(
      questions: steps.map((q) {
        return ElementEntity.fromJson(q);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'questions': questions.map((e) => e.toJson()).toList(),
      };

  // copyWith para facilitar atualizações
  FormConfigEntity copyWith({List<ElementEntity>? questions}) {
    return FormConfigEntity(
      questions: questions ?? this.questions,
    );
  }
}

/// 🎨 Representa o tema visual do formulário (cores, tipografia etc.)
class FormThemeEntity {
  final Color primaryColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final String fontFamily;

  const FormThemeEntity({
    required this.primaryColor,
    required this.backgroundColor,
    required this.textColor,
    required this.borderRadius,
    required this.fontFamily,
  });

  factory FormThemeEntity.fromJson(Map<String, dynamic> json) {
    return FormThemeEntity(
      primaryColor: Color(json['primaryColor'] ?? 0xFF0066FF),
      backgroundColor: Color(json['backgroundColor'] ?? 0xFFFFFFFF),
      textColor: Color(json['textColor'] ?? 0xFF000000),
      borderRadius: (json['borderRadius'] ?? 8).toDouble(),
      fontFamily: json['fontFamily'] ?? 'Inter',
    );
  }

  Map<String, dynamic> toJson() => {
        'primaryColor': primaryColor.value,
        'backgroundColor': backgroundColor.value,
        'textColor': textColor.value,
        'borderRadius': borderRadius,
        'fontFamily': fontFamily,
      };
}
