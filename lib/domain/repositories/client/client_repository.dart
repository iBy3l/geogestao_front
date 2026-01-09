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
}
