import 'package:flutter/material.dart';
import 'package:geogestao_front/shared/map/map_tooltip_controller.dart';

class MapGlobalTooltip extends StatelessWidget {
  final MapTooltipController controller;

  const MapGlobalTooltip({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        if (controller.position == null || controller.client == null) {
          return const SizedBox.shrink();
        }

        return Positioned(
          left: controller.position!.dx + 12,
          top: controller.position!.dy + 12,
          child: Material(
            color: Colors.transparent,
            child: _ClientTooltip(client: controller.client!),
          ),
        );
      },
    );
  }
}

class _ClientTooltip extends StatelessWidget {
  final ClientMapData client;

  const _ClientTooltip({required this.client});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 12, color: Colors.black26)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(client.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            Text(client.address, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.circle, size: 10, color: Colors.green),
                const SizedBox(width: 6),
                Text(client.status, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
