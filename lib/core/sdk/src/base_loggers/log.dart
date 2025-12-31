import 'package:flutter/material.dart';

enum AppLevel { debug, error, info, fatal, verbose, warning }

class Log {
  final String message;
  final DateTime? time;
  final IconData icon;
  final Color color;
  final String title;
  final AppLevel level;

  Log({
    required this.message,
    required this.level,
    DateTime? time,
  })  : time = DateTime.now(),
        icon = _getIconForLevel(level),
        color = _getColorForLevel(level),
        title = _getTitleForLevel(level);

  static IconData _getIconForLevel(AppLevel level) {
    switch (level) {
      case AppLevel.debug:
        return Icons.code;
      case AppLevel.error:
        return Icons.block;
      case AppLevel.info:
        return Icons.info;
      case AppLevel.fatal:
        return Icons.warning;
      case AppLevel.verbose:
        return Icons.chat;
      case AppLevel.warning:
        return Icons.warning;
    }
  }

  static Color _getColorForLevel(AppLevel level) {
    switch (level) {
      case AppLevel.debug:
        return Colors.blue;
      case AppLevel.error:
        return Colors.red;
      case AppLevel.info:
        return Colors.green;
      case AppLevel.fatal:
        return Colors.redAccent;
      case AppLevel.verbose:
        return Colors.purple;
      case AppLevel.warning:
        return Colors.yellow;
    }
  }

  static String _getTitleForLevel(AppLevel level) {
    switch (level) {
      case AppLevel.debug:
        return "Debug";
      case AppLevel.error:
        return "Error";
      case AppLevel.info:
        return "Info";
      case AppLevel.fatal:
        return "Fatal Error";
      case AppLevel.verbose:
        return "Verbose";
      case AppLevel.warning:
        return "Warning";
    }
  }
}
