import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class SellerDatasource {
  Future<Map<String, dynamic>> createSeller({required SellerParam param});
}

class SellerDatasourceImpl extends SellerDatasource {
  final IGateway gateway;

  SellerDatasourceImpl(this.gateway);

  static const String _endpoint = '';

  @override
  Future<Map<String, dynamic>> createSeller({
    required SellerParam param,
  }) async {
    final response = await gateway.post(_endpoint, {});
    return response.data;
  }
}
