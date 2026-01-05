import 'dart:math';

import 'package:geogestao_front/domain/domain.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GenerateRandomMarkersUsecase {
  final Random _rnd = Random();

  List<MapMarker> call({required int amount, required LatLngBounds bounds}) {
    return List.generate(amount, (i) {
      final lat = bounds.southwest.latitude + _rnd.nextDouble() * (bounds.northeast.latitude - bounds.southwest.latitude);

      final lng = bounds.southwest.longitude + _rnd.nextDouble() * (bounds.northeast.longitude - bounds.southwest.longitude);

      return MapMarker(id: i.toString(), position: LatLng(lat, lng));
    });
  }
}
