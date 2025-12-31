import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class FormsViewRepositoryImpl extends FormsViewRepository {
  final FormsViewDatasource datasource;

  FormsViewRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, FormsViewEntity>> getFormGate({required FormsViewParam param}) async {
    return tryExecute(() async {
      final response = await datasource.getFormGate(param: param);
      return FormsViewEntity.fromJson(response);
    });
  }
}
