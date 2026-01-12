import 'package:geogestao_front/core/core.dart';
import 'package:geogestao_front/domain/domain.dart';

class DeleteClientUsecase {
  final ClientRepository repository;

  DeleteClientUsecase({required this.repository});

  Future<BaseWhich<BaseFailure, bool>> call({required String clientId}) async {
    return await repository.deleteClient(clientId: clientId);
  }
}
