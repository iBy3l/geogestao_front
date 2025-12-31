import 'package:flutter/material.dart';

import '../../../shared/form/forms.dart';

class FormParser {
  static List<ElementEntity> fromApi(Map<String, dynamic> json) {
    final questions = json['form']?['config']?['questions'] as List? ?? [];

    return questions.map((q) {
      final fields = (q['fields'] as List?)?.map((f) {
        return ContentItem(
          id: f['id'],
          label: f['label'] ?? '',
        );
      }).toList();

      return ElementEntity(
        id: q['id'],
        type: q['type'],
        icon: Icons.text_fields, // pode mudar dinamicamente depois
        label: q['label'] ?? '',
        color: Color(q['color'] ?? 0xFF2196F3),
        position: q['position'] ?? 0,
        description: q['description'] ?? '',
        options: fields ?? [],
        title: q['title'] ?? '',
        properties: Map<String, dynamic>.from(q['properties'] ?? {}),
      );
    }).toList();
  }
}
