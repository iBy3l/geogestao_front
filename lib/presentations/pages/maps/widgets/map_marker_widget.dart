import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geogestao_front/domain/entities/client/client_entity.dart';

class MapMarkerWidget extends StatefulWidget {
  final Point<double> position;
  final String markerId;
  final ClientEntity? client;

  const MapMarkerWidget({
    super.key,
    required this.position,
    required this.markerId,
    this.client,
  });

  @override
  State<MapMarkerWidget> createState() => _MapMarkerWidgetState();
}

class _MapMarkerWidgetState extends State<MapMarkerWidget> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    const size = 20.0;

    return Positioned(
      left: widget.position.x - size / 2,
      top: widget.position.y - size,
      child: MouseRegion(
        onEnter: (_) => setState(() => hovering = true),
        onExit: (_) => setState(() => hovering = false),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // 📍 Marker
            GestureDetector(
              onTapDown: (details) {
                if (widget.markerId == 'search') {
                  _showMarkerMenu(context, details.globalPosition);
                }
              },
              child: Icon(
                Icons.location_on,
                color: widget.client?.status.color,
                size: size,
              ),
            ),

            // 🟡 Hover card
            if (hovering && widget.client != null)
              Positioned(
                left: 24,
                top: -10,
                child: ClientHoverCard(client: widget.client!),
              ),
          ],
        ),
      ),
    );
  }

  void _showMarkerMenu(BuildContext context, Offset globalPosition) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(globalPosition.dx, globalPosition.dy, 1, 1),
        Offset.zero & overlay.size,
      ),
      items: const [
        PopupMenuItem(value: 'info', child: Text('Informações do endereço')),
        PopupMenuItem(value: 'street', child: Text('Selecionar rua')),
        PopupMenuItem(value: 'zone', child: Text('Criar zona aqui')),
      ],
    );
  }
}

class ClientHoverCard extends StatelessWidget {
  final ClientEntity client;

  const ClientHoverCard({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              client.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Container(
              margin: const EdgeInsets.only(left: 8, top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: client.status.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                client.status.decription,
                style: TextStyle(color: client.status.color, fontSize: 12),
              ),
            ),
            if (client.phone != null) Text('📞 ${client.phone}'),
            if (client.email != null) Text('✉️ ${client.email}'),
          ],
        ),
      ),
    );
  }
}
