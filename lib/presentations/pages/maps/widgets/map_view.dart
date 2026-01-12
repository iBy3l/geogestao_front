import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/presentations/pages/client/controllers/client_controller.dart';
import 'package:geogestao_front/presentations/pages/client/states/client_state.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_marker_widget.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../controller/map_controller.dart';

class MapView extends StatelessWidget {
  final MapController controller;
  final ClientController clientController;

  const MapView({
    super.key,
    required this.controller,
    required this.clientController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Stack(
          children: [
            Listener(
              onPointerDown: (event) async {
                if (event.kind == PointerDeviceKind.mouse &&
                    event.buttons == kSecondaryMouseButton) {
                  if (controller.mapbox == null) return;
                  final latLng = await controller.mapbox!.toLatLng(
                    Point(event.localPosition.dx, event.localPosition.dy),
                  );
                  controller.openContextMenu(
                    position: event.localPosition,
                    latLng: latLng,
                  );
                }
              },
              child: MapboxMap(
                accessToken: controller.mapboxToken,
                onMapCreated: controller.onMapCreated,
                onCameraIdle: controller.onCameraIdle,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-23.5505, -46.6333),
                  zoom: 11,
                ),
              ),
            ),

            BaseBuilder(
              controller: clientController,
              build: (context, state) {
                if (state is ClientLoadingStates) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ListClientsSuccessStates) {
                  controller.setClientMarkers(state.clients);

                  return IgnorePointer(
                    ignoring: false,
                    child: Stack(
                      children: controller.screenMarkers.map((m) {
                        return MapMarkerWidget(
                          markerId: m.id,
                          position: m.screenPosition, // ✅ pixels
                          color: m.color,
                          client: state.clients.firstWhere((c) => c.id == m.id),
                        );
                      }).toList(),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ],
        );
      },
    );
  }
}
