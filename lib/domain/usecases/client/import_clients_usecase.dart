import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';

class ImportClientsUsecase {
  final ClientRepository repository;

  ImportClientsUsecase({required this.repository});

  Future<BaseWhich<BaseFailure, int>> call({required List<ClientParam> param}) {
    return repository.importClients(param: param);
  }
}
