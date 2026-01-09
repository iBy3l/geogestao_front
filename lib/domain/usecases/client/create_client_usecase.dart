import 'package:geogestao_front/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

class CreateClientUsecaseImpl {
  final ClientRepository repository;

  CreateClientUsecaseImpl(this.repository);

  Future<BaseWhich<BaseFailure, String>> call(ClientParam param) async {
    return await repository.createClient(param: param);
  }
}
