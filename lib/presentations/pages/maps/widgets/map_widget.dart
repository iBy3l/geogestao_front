import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/client/client_page.dart';
import 'package:geogestao_front/presentations/pages/client/controllers/client_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/cep_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_controls.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_view.dart';

class MapPage extends StatefulWidget {
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
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void didUpdateWidget(covariant MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.onLayoutChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, __) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: widget.controller.isFullscreen
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
                    child: widget.clientController.isClientsPanelOpen
                        ? SizedBox(
                            key: const ValueKey('clients_panel_open'),
                            width: 360,
                            child: ClientPage(
                              controller: widget.clientController,
                              cepController: widget.cepController,
                              mapController: widget.controller,
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
                      controller: widget.controller,
                      clientController: widget.clientController,
                    ),
                  ),
                ],
              ),

              Positioned(
                right: 16,
                bottom: 100,
                child: MapControls(controller: widget.controller),
              ),

              Positioned(
                top: 32,
                right: 16,
                child: AnimatedMapButton(
                  onTap: widget.controller.toggleFullscreen,
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
