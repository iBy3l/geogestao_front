import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_marker_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../controller/map_controller.dart';

class MapView extends StatefulWidget {
  final MapController controller;

  const MapView({super.key, required this.controller});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, __) {
        return Stack(
          children: [
            MapboxMap(
              trackCameraPosition: true,

              accessToken: widget.controller.mapboxToken,
              styleString: MapboxStyles.MAPBOX_STREETS,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-23.5505, -46.6333),
                zoom: 11,
              ),
              onMapCreated: widget.controller.onMapCreated,
              onCameraIdle: widget.controller.onCameraIdle,
            ),

            /// MARKERS
            IgnorePointer(
              ignoring: true,
              child: Stack(
                children: widget.controller.screenMarkers
                    .map(
                      (m) => MapMarkerWidget(
                        position: m.screenPosition,
                        color: m.color,
                        markerId: m.id,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
