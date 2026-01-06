import 'dart:math';

import 'package:flutter/material.dart';

class MapMarkerWidget extends StatelessWidget {
  final Point<double> position;
  final Color color;
  final String markerId;

  const MapMarkerWidget({
    super.key,
    required this.position,
    required this.color,
    required this.markerId,
  });

  @override
  Widget build(BuildContext context) {
    const size = 20.0;

    return Positioned(
      left: position.x - size / 2,
      top: position.y - size,
      child: Icon(
        markerId == 'search' ? Icons.place : Icons.location_on,
        color: markerId == 'search' ? Colors.blue : Colors.red,
      ),
    );
  }
}
