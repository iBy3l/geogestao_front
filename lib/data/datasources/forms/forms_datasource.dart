import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';

abstract class FormsDatasource {
  Future<Map<String, dynamic>> createForms({required FormsParam param});

  Future<Map<String, dynamic>> getForms(GetListFormsParam param);

  Future<Map<String, dynamic>> updateForms(FormsParam param);
}

class FormsDatasourceImpl extends FormsDatasource {
  final IGateway gateway;

  FormsDatasourceImpl(this.gateway);

  static const String _endpoint = '/rest/v1/rpc/create_form';
  static const String _getListEndpoint = '/rest/v1/rpc/get_list_forms';
  static const String _updateEndpoint = '/rest/v1/rpc/update_form';

  @override
  Future<Map<String, dynamic>> createForms({required FormsParam param}) async {
    final response = await gateway.post(_endpoint, param.toMap());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getForms(GetListFormsParam param) async {
    final response = await gateway.post(_getListEndpoint, param.toMap());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> updateForms(FormsParam param) async {
    final response = await gateway.post(_updateEndpoint, param.toMap());
    return response.data;
  }
}
