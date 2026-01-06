import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_controls.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_view.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/search_box.dart';

class MapPage extends StatelessWidget {
  final MapController controller;

  const MapPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: controller.isFullscreen
              ? EdgeInsets.zero
              : const EdgeInsets.all(16),
          child: Stack(
            children: [
              MapView(controller: controller),

              if (!controller.isFullscreen)
                Positioned(
                  top: 16,
                  left: 16,

                  child: SearchBox(
                    onSubmit: controller.search,
                    onChanged: controller.autocomplete,
                  ),
                ),

              Positioned(
                right: 16,
                bottom: 100,
                child: MapControls(controller: controller),
              ),

              Positioned(
                top: 16,
                right: 16,
                child: AnimatedMapButton(
                  onTap: controller.toggleFullscreen,
                  icon: const Icon(Icons.fullscreen),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
