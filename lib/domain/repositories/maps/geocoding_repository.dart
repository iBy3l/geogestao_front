import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/entities/entities.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

abstract class GeocodingRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, LatLng?>> searchAddress(
    String query,
    String token,
  );

  Future<BaseWhich<BaseFailure, List<AddressSuggestion>>> autocomplete(
    String query,
    String token,
  );

  Future<BaseWhich<BaseFailure, AddressModel>> cepAddress(String cep);
}
