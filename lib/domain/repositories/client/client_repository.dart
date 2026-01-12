import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class ClientRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, String>> createClient({
    required ClientParam param,
  });

  Future<BaseWhich<BaseFailure, List<ClientEntity>>> getAllClients({
    String? search,
    String? cnpj,
    ClientStatus? status,
  });

  Future<BaseWhich<BaseFailure, int>> importClients({
    required List<ClientParam> param,
  });

  Future<BaseWhich<BaseFailure, bool>> deleteClient({required String clientId});

  Future<BaseWhich<BaseFailure, bool>> updateClient({
    required String clientId,
    required ClientParam param,
  });
}
