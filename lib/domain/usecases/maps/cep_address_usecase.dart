import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';

class CepAddressUsecase {
  final GeocodingRepository repository;

  CepAddressUsecase(this.repository);

  Future<BaseWhich<BaseFailure, AddressModel>> call(String cep) async {
    return repository.cepAddress(cep);
  }
}
