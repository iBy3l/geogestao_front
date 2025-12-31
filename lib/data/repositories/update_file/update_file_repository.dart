import '/core/core.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class UpdateFileRepositoryImpl extends UpdateFileRepository {
  final UpdateFileDatasource datasource;

  UpdateFileRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, UpdateFileEntity>> createUpdateFile({required UpdateFileParam param}) async {
    return tryExecute(() async {
      final response = await datasource.createUpdateFile(param: param);
      return UpdateFileEntity.fromJson(response);
    });
  }
}
