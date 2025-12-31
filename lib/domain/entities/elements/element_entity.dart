// import 'package:flutter/material.dart';
// import '/shared/shared.dart';

// /// Representa um elemento (campo) dentro do formulário.
// ///
// class PropertyEntity {
//   final bool required;
//   final String? description;
//   final String? title;
//   final bool randomizeOrder;
//   final bool alphabeticalOrder;

//   PropertyEntity({
//     this.required = false,
//     this.description,
//     this.title,
//     this.randomizeOrder = false,
//     this.alphabeticalOrder = false,
//   });

//   factory PropertyEntity.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return PropertyEntity();

//     return PropertyEntity(
//       required: json['required'] ?? false,
//       description: json['description'],
//       title: json['title'],
//       randomizeOrder: json['randomize_order'] ?? false,
//       alphabeticalOrder: json['alphabetical_order'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'required': required,
//       'description': description,
//       'title': title,
//       'randomize_order': randomizeOrder,
//       'alphabetical_order': alphabeticalOrder,
//     };
//   }

//   PropertyEntity copyWith({
//     bool? required,
//     String? description,
//     String? title,
//     bool? randomizeOrder,
//     bool? alphabeticalOrder,
//   }) {
//     return PropertyEntity(
//       required: required ?? this.required,
//       description: description ?? this.description,
//       title: title ?? this.title,
//       randomizeOrder: randomizeOrder ?? this.randomizeOrder,
//       alphabeticalOrder: alphabeticalOrder ?? this.alphabeticalOrder,
//     );
//   }
// }

// class ElementEntity {
//   final String id;
//   final String type; // ex: "text", "email", "choice", "rating"
//   final IconData icon;
//   final String label;
//   final Color? color;
//   int position;
//   final ContentEntity? contents;
//   final Map<String, dynamic>? properties;
//   final TextFieldConfig? textFieldConfig;
//   final TextFieldConfig? titleFieldConfig;
//   final TextFieldConfig? descriptionFieldConfig;

//   ElementEntity({
//     required this.id,
//     required this.type,
//     required this.icon,
//     required this.label,
//     this.color,
//     this.position = 0,
//     this.contents,
//     this.properties,
//     this.textFieldConfig,
//     this.titleFieldConfig,
//     this.descriptionFieldConfig,
//   });

//   factory ElementEntity.fromJson(Map<String, dynamic>? json) {
//     if (json == null) return ElementEntity.empty();

//     // converte 'fields' da API para lista de ContentItem
//     final fields = (json['fields'] as List?)?.map((f) => ContentItem.fromJson(f)).toList() ?? (json['contents']?['items'] as List?)?.map((f) => ContentItem.fromJson(f)).toList() ?? [];

//     return ElementEntity(
//       id: json['id'] ?? UniqueKey().toString(),
//       type: json['type'] ?? '',
//       icon: IconData(json['icon'] ?? 0xe14d, fontFamily: 'MaterialIcons'),
//       label: json['label'] ?? '',
//       color: json['color'] != null ? Color(int.parse(json['color'].toString())) : null,
//       position: json['position'] ?? 0,
//       contents: ContentEntity(
//         index: 0,
//         label: json['label'] ?? '',
//         items: fields,
//       ),
//       properties: json['properties'] != null ? Map<String, dynamic>.from(json['properties']) : {},
//       textFieldConfig: json['text_field_config'] != null ? TextFieldConfig.fromJson(json['text_field_config']) : null,
//       titleFieldConfig: json['title_field_config'] != null ? TextFieldConfig.fromJson(json['title_field_config']) : null,
//       descriptionFieldConfig: json['description_field_config'] != null ? TextFieldConfig.fromJson(json['description_field_config']) : null,
//     );
//   }

//   // 🔹 Conversão Objeto → JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type,
//       'icon': icon.codePoint,
//       'label': label,
//       'color': color?.value,
//       'position': position,
//       'contents': contents?.toJson(),
//       'properties': properties,
//       'text_field_config': textFieldConfig?.toJson(),
//     };
//   }

//   // 🔹 Cria uma cópia editável
//   ElementEntity copyWith({
//     String? id,
//     String? type,
//     IconData? icon,
//     String? label,
//     Color? color,
//     int? position,
//     ContentEntity? contents,
//     Map<String, dynamic>? properties,
//     TextFieldConfig? textFieldConfig,
//   }) {
//     return ElementEntity(
//       id: id ?? this.id,
//       type: type ?? this.type,
//       icon: icon ?? this.icon,
//       label: label ?? this.label,
//       color: color ?? this.color,
//       position: position ?? this.position,
//       contents: contents ?? this.contents,
//       properties: properties ?? this.properties,
//       textFieldConfig: textFieldConfig ?? this.textFieldConfig,
//     );
//   }

//   // 🔹 Fábrica auxiliar
//   factory ElementEntity.empty() => ElementEntity(
//         id: UniqueKey().toString(),
//         type: 'text',
//         icon: Icons.text_fields,
//         label: 'Novo campo',
//       );
// }

// /// Grupo de conteúdos internos (ex: opções de um campo de múltipla escolha)
// class ContentEntity {
//   final int index;
//   final String label;
//   final List<ContentItem> items;

//   ContentEntity({
//     required this.index,
//     required this.label,
//     this.items = const [],
//   });

//   factory ContentEntity.fromJson(Map<String, dynamic>? json) {
//     return ContentEntity(
//       index: json?['index'] ?? 0,
//       label: json?['label'] ?? '',
//       items: (json?['items'] as List?)?.map((e) => ContentItem.fromJson(e)).toList() ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'index': index,
//       'label': label,
//       'items': items.map((e) => e.toJson()).toList(),
//     };
//   }

//   ContentEntity copyWith({
//     int? index,
//     String? label,
//     List<ContentItem>? items,
//   }) {
//     return ContentEntity(
//       index: index ?? this.index,
//       label: label ?? this.label,
//       items: items ?? this.items,
//     );
//   }
// }

// /// Item individual dentro de um conteúdo (ex: uma opção)
// class ContentItem {
//   final String id;
//   final String type;
//   final String label;

//   ContentItem({
//     required this.id,
//     required this.type,
//     required this.label,
//   });

//   factory ContentItem.fromJson(Map<String, dynamic>? json) {
//     return ContentItem(
//       id: json?['id'] ?? UniqueKey().toString(),
//       type: json?['type'] ?? 'option',
//       label: json?['label'] ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type,
//       'label': label,
//     };
//   }

//   ContentItem copyWith({
//     String? id,
//     String? type,
//     String? label,
//   }) {
//     return ContentItem(
//       id: id ?? this.id,
//       type: type ?? this.type,
//       label: label ?? this.label,
//     );
//   }
// }
