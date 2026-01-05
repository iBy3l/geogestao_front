import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';

class AutocompleteAddressUsecase {
  final GeocodingRepository repository;

  AutocompleteAddressUsecase(this.repository);

  Future<BaseWhich<BaseFailure, List<AddressSuggestion>>> call(String query, String token) {
    if (query.length < 3) {
      return Future.value(IsResult([]));
    }
    return repository.autocomplete(query, token);
  }
}
