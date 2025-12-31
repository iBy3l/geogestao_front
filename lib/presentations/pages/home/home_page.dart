import 'package:flutter/material.dart';
import 'package:geogestao_front/core/core.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '/presentations/pages/home/controllers/home_controller.dart';
import '/shared/shared.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    debugPrint('key map => ${StringsConst().mapbox}');
    return ResponsiveLayout(
      metas: controller.meta,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MapboxMap(
          initialCameraPosition: const CameraPosition(target: LatLng(-23.55052, -46.633308), zoom: 10),
          accessToken: StringsConst().mapbox,
        ),
      ),
    );
  }
}

// lib/shared/widgets/map
