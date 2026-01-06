import 'package:geogestao_front/core/core.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class SellerRepositoryImpl extends SellerRepository {
  final SellerDatasource datasource;

  SellerRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, SellerEntity>> createSeller({
    required SellerParam param,
  }) async {
    return tryExecute(() async {
      final response = await datasource.createSeller(param: param);
      return SellerEntity.fromJson(response);
    });
  }
}
