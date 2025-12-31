import 'package:flutter/material.dart';

enum AccessMode {
  public,
  private,
  restricted;

  String get label {
    switch (this) {
      case AccessMode.public:
        return 'Público';
      case AccessMode.private:
        return 'Privado';
      case AccessMode.restricted:
        return 'Restrito';
    }
  }

  IconData get icon {
    switch (this) {
      case AccessMode.public:
        return Icons.public;
      case AccessMode.private:
        return Icons.lock;
      case AccessMode.restricted:
        return Icons.group;
    }
  }

  Color get color {
    switch (this) {
      case AccessMode.public:
        return Colors.green;
      case AccessMode.private:
        return Colors.orange;
      case AccessMode.restricted:
        return Colors.blue;
    }
  }

  static AccessMode fromString(String? value) {
    switch (value) {
      case 'public':
        return AccessMode.public;
      case 'private':
        return AccessMode.private;
      case 'restricted':
        return AccessMode.restricted;
      default:
        return AccessMode.public; // fallback seguro
    }
  }
}
