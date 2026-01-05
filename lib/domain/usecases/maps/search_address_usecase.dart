import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class SearchAddressUsecase {
  final GeocodingRepository repository;

  SearchAddressUsecase(this.repository);

  Future<BaseWhich<BaseFailure, LatLng?>> call(String query, String token) {
    if (query.isEmpty) return Future.value(null);
    return repository.searchAddress(query, token);
  }
}
