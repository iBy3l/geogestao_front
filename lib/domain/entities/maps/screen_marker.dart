import 'dart:math';

import 'package:flutter/material.dart';

class ScreenMarker {
  final String id;
  final Point<double> screenPosition;
  final Color color;

  ScreenMarker({required this.id, required this.screenPosition, required this.color});
}
