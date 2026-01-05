import 'package:geogestao_front/core/sdk/sdk.dart';
import 'package:geogestao_front/data/data.dart';
import 'package:geogestao_front/domain/domain.dart';
import 'package:geogestao_front/presentations/pages/maps/controller/map_controller.dart';

class MapsModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<MapboxGeocodingDatasource>(MapboxGeocodingDatasourceImpl.new);
    i.addLazySingleton<GeocodingRepository>(GeocodingRepositoryImpl.new);
    i.addLazySingleton(SearchAddressUsecase.new);
    i.addLazySingleton(GenerateRandomMarkersUsecase.new);
    i.addLazySingleton(AutocompleteAddressUsecase.new);
    i.addLazySingleton(MapController.new);
  }
}
