import 'package:flutter/material.dart';
import 'package:geogestao_front/core/consts/strings_const.dart';
import 'package:geogestao_front/shared/map/geo_map.dart';
import 'package:geogestao_front/shared/map/geo_point.dart';
import 'package:latlong2/latlong.dart';

import '/presentations/pages/home/controllers/home_controller.dart';
import '/shared/shared.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final points = List.generate(5000, (i) {
      final status = switch (i % 4) {
        0 => ClientStatus.ativo,
        1 => ClientStatus.atrasado,
        2 => ClientStatus.emVisita,
        _ => ClientStatus.inativo,
      };

      return GeoPoint(id: 'cliente_$i', position: LatLng(-23.55 + (i % 200) * 0.001, -46.63 + (i % 200) * 0.001), status: status);
    });
    return ResponsiveLayout(
      metas: controller.meta,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GeoMap(
              mapboxAccessToken: StringsConst().mapbox,
              height: 520,
              points: points,
              zones: [
                GeoZone(id: 'z1', points: [LatLng(-23.5480, -46.6500), LatLng(-23.5400, -46.6300), LatLng(-23.5600, -46.6200), LatLng(-23.5700, -46.6450)]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// lib/shared/widgets/map
