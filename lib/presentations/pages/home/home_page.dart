import 'package:flutter/material.dart';
import 'package:geogestao_front/presentations/pages/client/import_clients_dialog.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/animated_map_button.dart';
import 'package:geogestao_front/presentations/pages/maps/widgets/map_widget.dart';

import '/presentations/pages/home/controllers/home_controller.dart';
import '/shared/shared.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      metas: widget.controller.meta,
      import: () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => ImportClientsDialog(
            onImport: (c) async =>
                await widget.controller.clientController.importClients(c),
          ),
        );
      },

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(128),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          height: double.infinity,
          width: double.infinity,
          child: AnimatedBuilder(
            animation: widget.controller.clientController,
            builder: (context, _) {
              return Stack(
                children: [
                  /// MAPA (base)
                  MapPage(
                    controller: widget.controller.mapController,
                    clientController: widget.controller.clientController,
                    cepController: widget.controller.cepController,
                  ),

                  /// BOTÃO FLUTUANTE (abrir painel)
                  if (!widget.controller.clientController.isClientsPanelOpen)
                    Positioned(
                      left: 16,
                      top: 16,
                      child: AnimatedMapButton(
                        onTap: widget
                            .controller
                            .clientController
                            .toggleClientsPanel,
                        icon: const Icon(Icons.arrow_right),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
