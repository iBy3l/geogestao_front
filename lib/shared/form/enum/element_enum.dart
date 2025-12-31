// form_core.dart

// =============== MODOS ===============
import 'package:flutter/material.dart';

enum EditableTextMode { create, view, answer }

// =============== TIPOS ===============
enum ElementType { text, dropdown, select, checkbox, welcome, end }

// lib/shared/form/enum/element_enum.dart

enum TextSize { small, medium, large }

extension TextSizeX on TextSize {
  static TextSize fromString(String? value) {
    switch (value) {
      case 'small':
        return TextSize.small;
      case 'large':
        return TextSize.large;
      default:
        return TextSize.medium;
    }
  }
}

extension TextAlignX on TextAlign {
  static TextAlign fromString(String? value) {
    switch (value) {
      case 'center':
        return TextAlign.center;
      case 'right':
        return TextAlign.right;
      default:
        return TextAlign.left;
    }
  }
}

extension ElementTypeX on ElementType {
  String get asString => switch (this) {
        ElementType.text => 'text',
        ElementType.dropdown => 'dropdown',
        ElementType.select => 'select',
        ElementType.checkbox => 'checkbox',
        ElementType.welcome => 'welcome',
        ElementType.end => 'end',
      };

  static ElementType from(String? type) {
    switch (type) {
      case 'welcome':
        return ElementType.welcome;
      case 'text':
        return ElementType.text;
      case 'dropdown':
        return ElementType.dropdown;
      case 'select':
        return ElementType.select;
      case 'checkbox':
        return ElementType.checkbox;
      case 'end':
        return ElementType.end;
      default:
        return ElementType.text;
    }
  }
}
