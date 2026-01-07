import 'package:flutter/material.dart';

class MapContextMenu extends StatelessWidget {
  final Offset position;
  final VoidCallback onClose;
  final VoidCallback onMarkPoint;
  final VoidCallback onSelectStreet;
  final VoidCallback onCreateZone;
  final VoidCallback onGoToSP;

  const MapContextMenu({
    super.key,
    required this.position,
    required this.onClose,
    required this.onMarkPoint,
    required this.onSelectStreet,
    required this.onCreateZone,
    required this.onGoToSP,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 220),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _item(Icons.place, 'Marcar ponto', onMarkPoint),
              _item(
                Icons.alt_route,
                'Selecionar trecho da rua',
                onSelectStreet,
              ),
              _item(Icons.layers, 'Criar zona', onCreateZone),
              const Divider(height: 1),
              _item(Icons.location_city, 'Voltar para São Paulo', onGoToSP),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(text)),
          ],
        ),
      ),
    );
  }
}
