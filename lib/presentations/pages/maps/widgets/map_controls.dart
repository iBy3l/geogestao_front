import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/zoom_controls.dart';

class MapControls extends StatelessWidget {
  final MapController controller;

  const MapControls({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ZoomControls(onZoomIn: controller.zoomIn, onZoomOut: controller.zoomOut, canZoomIn: controller.canZoomIn, canZoomOut: controller.canZoomOut),
        const SizedBox(height: 12),
        AnimatedMapButton(onTap: controller.fitSaoPaulo, icon: const Icon(Icons.map)),

        const SizedBox(height: 8),

        Material(
          elevation: 6,
          borderRadius: BorderRadius.circular(8),
          child: IconButton(tooltip: 'Voltar para São Paulo', icon: const Icon(Icons.my_location), onPressed: controller.goToSaoPaulo),
        ),
      ],
    );
  }
}
