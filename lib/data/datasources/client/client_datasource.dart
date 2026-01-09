import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class ClientDatasource {
  Future<String> createClient({required ClientParam param});
  // Future<Map<String, dynamic>> updateClient({required ClientParam param});
  // Future<Map<String, dynamic>> deleteClient({required int clientId});
  Future<List<Map<String, dynamic>>> getAllClients({
    String? search,
    String? cnpj,
    ClientStatus? status,
  });

  Future<int> importClients({required List<ClientParam> param});
}

class ClientDatasourceImpl extends ClientDatasource {
  final IGateway gateway;

  ClientDatasourceImpl(this.gateway);

  static const String _endpointCreate = '/rest/v1/rpc/create_client';
  static const String _endpointUpdate = '/rest/v1/rpc/update_client';
  static const String _endpointDelete = '/rest/v1/rpc/delete_client';
  static const String _endpointGetAll = '/rest/v1/rpc/get_clients';
  static const String _endpointImport = '/rest/v1/rpc/import_clients';

  @override
  Future<String> createClient({required ClientParam param}) async {
    final response = await gateway.post(_endpointCreate, param.toMap());
    return response.data;
  }

  @override
  Future<List<Map<String, dynamic>>> getAllClients({
    String? search,
    String? cnpj,
    ClientStatus? status,
  }) async {
    final response = await gateway.post(_endpointGetAll, {
      if (search != null) 'p_search': search,
      if (cnpj != null) 'p_cnpj': cnpj,
      if (status != null) 'p_status': status.name,
    });
    return List<Map<String, dynamic>>.from(response.data);
  }

  @override
  Future<int> importClients({required List<ClientParam> param}) async {
    final response = await gateway.post(_endpointImport, {
      'p_clients': param.map((e) => e.toMap()).toList(),
    });
    return response.data;
  }
}
