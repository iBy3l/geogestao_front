import 'dart:math';

import 'package:flutter/material.dart';

class MapMarkerWidget extends StatelessWidget {
  final Point<double> position;
  final Color color;
  final String markerId;

  const MapMarkerWidget({
    super.key,
    required this.position,
    required this.color,
    required this.markerId,
  });

  @override
  Widget build(BuildContext context) {
    const size = 20.0;

    return Positioned(
      left: position.x - size / 2,
      top: position.y - size,
      child: GestureDetector(
        onTapDown: (details) {
          debugPrint('Marker $markerId tapped at ${details.globalPosition}');
          if (markerId == 'search') {
            _showMarkerMenu(context, details.globalPosition);
          } else {
            debugPrint('Marker $markerId tapped');
          }
        },
        child: Icon(
          markerId == 'search' ? Icons.place : Icons.location_on,
          color: markerId == 'search' ? Colors.blue : Colors.red,
          size: size,
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
    ).then((value) {
      if (value == null) return;

      switch (value) {
        case 'info':
          debugPrint('Info do marker');
          break;
        case 'street':
          debugPrint('Selecionar rua');
          break;
        case 'zone':
          debugPrint('Criar zona');
          break;
      }
    });
  }
}
