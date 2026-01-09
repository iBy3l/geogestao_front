import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/client/client_page.dart';
import 'package:geogestao_front/presentations/pages/client/controllers/client_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/cep_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_controls.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_view.dart';

class MapPage extends StatelessWidget {
  final MapController controller;
  final ClientController clientController;
  final CepController cepController;

  const MapPage({
    super.key,
    required this.controller,
    required this.clientController,
    required this.cepController,
  });

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
              Row(
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    switchInCurve: Curves.easeOut,
                    switchOutCurve: Curves.easeIn,
                    child: clientController.isClientsPanelOpen
                        ? SizedBox(
                            key: const ValueKey('clients_panel_open'),
                            width: 360,
                            child: ClientPage(
                              controller: clientController,
                              cepController: cepController,
                              mapController: controller,
                            ),
                          )
                        : const SizedBox(
                            key: ValueKey('clients_panel_closed'),
                            width: 0,
                            height: 0,
                          ),
                  ),
                  Expanded(
                    child: MapView(
                      controller: controller,
                      clientController: clientController,
                    ),
                  ),
                ],
              ),

              Positioned(
                right: 16,
                bottom: 100,
                child: MapControls(controller: controller),
              ),
              if (!clientController.isClientsPanelOpen)
                Positioned(
                  left: 16,
                  top: 80,
                  child: AnimatedMapButton(
                    onTap: clientController.toggleClientsPanel,
                    icon: const Icon(Icons.people),
                  ),
                ),

              Positioned(
                top: 32,
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
