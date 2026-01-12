import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class ClientRepositoryImpl extends ClientRepository {
  final ClientDatasource datasource;

  ClientRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, String>> createClient({
    required ClientParam param,
  }) async {
    return tryExecute(() async {
      final response = await datasource.createClient(param: param);
      return response;
    });
  }

  @override
  Future<BaseWhich<BaseFailure, List<ClientEntity>>> getAllClients({
    String? search,
    String? cnpj,
    ClientStatus? status,
  }) async {
    return tryExecute(() async {
      final response = await datasource.getAllClients(
        search: search,
        cnpj: cnpj,
        status: status,
      );
      final clients = response
          .map((data) => ClientEntity.fromJson(data))
          .toList(growable: false);
      return clients;
    });
  }

  @override
  Future<BaseWhich<BaseFailure, int>> importClients({
    required List<ClientParam> param,
  }) async {
    return tryExecute(() async {
      final response = await datasource.importClients(param: param);
      return response;
    });
  }

  @override
  Future<BaseWhich<BaseFailure, bool>> deleteClient({
    required String clientId,
  }) async {
    return tryExecute(() async {
      final response = await datasource.deleteClient(clientId: clientId);
      return response;
    });
  }

  @override
  Future<BaseWhich<BaseFailure, bool>> updateClient({
    required String clientId,
    required ClientParam param,
  }) async {
    return tryExecute(() async {
      final response = await datasource.updateClient(
        clientId: clientId,
        param: param,
      );
      return response;
    });
  }
}
