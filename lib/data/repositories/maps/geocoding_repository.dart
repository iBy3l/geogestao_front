import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/data/datasources/datasources.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class GeocodingRepositoryImpl extends GeocodingRepository {
  final MapboxGeocodingDatasource datasource;

  GeocodingRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, LatLng?>> searchAddress(String query, String token) async {
    return tryExecute<LatLng?>(() async {
      final json = await datasource.search(query, token);

      final features = json['features'];
      if (features is! List || features.isEmpty) return null;

      final coords = features.first['geometry']['coordinates'];
      if (coords is! List) return null;

      return LatLng(coords[1], coords[0]);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, List<AddressSuggestion>>> autocomplete(String query, String token) async {
    return tryExecute(() async {
      final json = await datasource.autocomplete(query, token);

      final features = json['features'];
      if (features is! List) return [];

      return features.map<AddressSuggestion>((f) {
        final coords = f['geometry']['coordinates'];
        return AddressSuggestion(label: f['place_name'], position: LatLng(coords[1], coords[0]));
      }).toList();
    });
  }
}
