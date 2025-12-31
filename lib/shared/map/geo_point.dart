import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

enum ClientStatus { ativo, atrasado, emVisita, inativo }

extension ClientStatusColor on ClientStatus {
  Color get color => switch (this) {
    ClientStatus.ativo => Colors.green,
    ClientStatus.atrasado => Colors.red,
    ClientStatus.emVisita => Colors.orange,
    ClientStatus.inativo => Colors.grey,
  };
}

class GeoPoint {
  final String id;
  final LatLng position;
  final ClientStatus status;

  GeoPoint({required this.id, required this.position, required this.status});

  Color get color => status.color;
}
