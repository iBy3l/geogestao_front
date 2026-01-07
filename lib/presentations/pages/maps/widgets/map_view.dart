import 'dart:math';

import 'package:flutter/gestures.dart';
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
            Listener(
              onPointerDown: (event) async {
                if (event.kind == PointerDeviceKind.mouse &&
                    event.buttons == kSecondaryMouseButton) {
                  if (widget.controller.mapbox == null) return;
                  final latLng = await widget.controller.mapbox!.toLatLng(
                    Point(event.localPosition.dx, event.localPosition.dy),
                  );
                  widget.controller.openContextMenu(
                    position: event.localPosition,
                    latLng: latLng,
                  );
                }
              },
              child: MapboxMap(
                accessToken: widget.controller.mapboxToken,
                onMapCreated: widget.controller.onMapCreated,
                onCameraIdle: widget.controller.onCameraIdle,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-23.5505, -46.6333),
                  zoom: 11,
                ),
              ),
            ),

            /// MARKERS
            IgnorePointer(
              ignoring: false,
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
