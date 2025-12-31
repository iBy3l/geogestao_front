import '/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class UpdateFileDatasource {
  Future<Map<String, dynamic>> createUpdateFile({required UpdateFileParam param});
}

class UpdateFileDatasourceImpl extends UpdateFileDatasource {
  final IGateway gateway;

  UpdateFileDatasourceImpl(this.gateway);

  static const String _endpoint = '';

  @override
  Future<Map<String, dynamic>> createUpdateFile({required UpdateFileParam param}) async {
    final response = await gateway.post(_endpoint, {});
    return response.data;
  }
}
