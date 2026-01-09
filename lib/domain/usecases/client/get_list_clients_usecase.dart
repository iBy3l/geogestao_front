import 'package:geogestao_front/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

class GetListClientsUsecaseImpl {
  final ClientRepository repository;

  GetListClientsUsecaseImpl(this.repository);

  Future<BaseWhich<BaseFailure, List<ClientEntity>>> call({
    String? search,
    String? cnpj,
    ClientStatus? status,
  }) async {
    return await repository.getAllClients(
      search: search,
      cnpj: cnpj,
      status: status,
    );
  }
}
