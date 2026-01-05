import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';

class ZoomControls extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final bool canZoomIn;
  final bool canZoomOut;

  const ZoomControls({super.key, required this.onZoomIn, required this.onZoomOut, required this.canZoomIn, required this.canZoomOut});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedMapButton(enabled: canZoomIn, onTap: onZoomIn, icon: const Icon(Icons.add)),
        const SizedBox(height: 8),
        AnimatedMapButton(enabled: canZoomOut, onTap: onZoomOut, icon: const Icon(Icons.remove)),
      ],
    );
  }
}

class ZoomLevelIndicator extends StatelessWidget {
  final double zoom;

  const ZoomLevelIndicator({super.key, required this.zoom});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text('Zoom: ${zoom.toStringAsFixed(1)}', style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}
