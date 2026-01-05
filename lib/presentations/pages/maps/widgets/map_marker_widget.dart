import 'dart:math';

import 'package:flutter/material.dart';

class MapMarkerWidget extends StatelessWidget {
  final Point<double> position;
  final Color color;

  const MapMarkerWidget({super.key, required this.position, required this.color});

  @override
  Widget build(BuildContext context) {
    const size = 20.0;

    return Positioned(
      left: position.x - size / 2,
      top: position.y - size,
      child: Icon(Icons.location_on, size: size, color: color),
    );
  }
}
