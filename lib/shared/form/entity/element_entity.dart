import 'package:flutter/material.dart';
import '/shared/form/enum/element_enum.dart';

import '../rules/rules.dart';
import 'entity.dart';

class ElementEntity {
  final String id;
  final ElementType type;
  final String label;
  final int position;
  final List<ContentItem> options; // usado por dropdown/select/checkbox (listas)
  final Map<String, dynamic> properties; // aqui guardamos regras por tipo
  final IconData icon;
  final Color? color;

  // Configs de texto (campos exibidos ao usuário final, mas editados pelos criadores)
  final String? title; // texto do título
  final String? description; // texto da descrição (opcional)

  ElementEntity({
    required this.id,
    required this.type,
    required this.label,
    this.position = 0,
    this.options = const [],
    this.properties = const {},
    this.icon = Icons.tune,
    this.color,
    this.title,
    this.description,
  });

  ElementEntity copyWith({
    String? id,
    ElementType? type,
    String? label,
    int? position,
    List<ContentItem>? options,
    Map<String, dynamic>? properties,
    IconData? icon,
    Color? color,
    String? title,
    String? description,
  }) {
    return ElementEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      position: position ?? this.position,
      options: options ?? this.options,
      properties: properties ?? this.properties,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  // ---- Helpers para ler regras fortemente tipadas ----
  TextFieldRules get textRules => TextFieldRules.fromJson(properties['text_rules']);
  DropdownRules get dropdownRules => DropdownRules.fromJson(properties['dropdown_rules']);
  SelectRules get selectRules => SelectRules.fromJson(properties['select_rules']);
  CheckboxRules get checkboxRules => CheckboxRules.fromJson(properties['checkbox_rules']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.asString,
    'label': label,
    'position': position,
    'icon': icon.codePoint,
    'color': color?.value,
    'title': title,
    'description': description,
    'options': options.map((o) => o.toJson()).toList(),
    'properties': properties,
  };

  factory ElementEntity.fromJson(Map<String, dynamic> j) => ElementEntity(
    id: j['id'],
    type: ElementTypeX.from(j['type']),
    label: j['label'] ?? '',
    position: j['position'] ?? 0,
    icon: IconData(j['icon'] ?? Icons.tune.codePoint, fontFamily: 'MaterialIcons'),
    color: j['color'] != null ? Color(j['color']) : null,
    title: j['title'],
    description: j['description'],
    options: (j['options'] as List? ?? []).map((e) => ContentItem.fromJson(e)).toList(),
    properties: Map<String, dynamic>.from(j['properties'] ?? {}),
  );
}
