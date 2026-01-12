import 'package:geogestao_front/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

class UpdateClientUsecase {
  final ClientRepository repository;

  UpdateClientUsecase(this.repository);

  Future<BaseWhich<BaseFailure, bool>> call({
    required String clientId,
    required ClientParam param,
  }) async {
    return await repository.updateClient(clientId: clientId, param: param);
  }
}
