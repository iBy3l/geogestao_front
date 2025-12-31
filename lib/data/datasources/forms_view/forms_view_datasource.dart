import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';

abstract class FormsViewDatasource {
  Future<Map<String, dynamic>> getFormGate({required FormsViewParam param});
}

class FormsViewDatasourceImpl extends FormsViewDatasource {
  final IGateway gateway;

  FormsViewDatasourceImpl(this.gateway);

  static const String _endpoint = '/rest/v1/rpc/get_form_gate';

  @override
  Future<Map<String, dynamic>> getFormGate({required FormsViewParam param}) async {
    final response = await gateway.post(_endpoint, param.toMap());
    return response.data;
  }
}
