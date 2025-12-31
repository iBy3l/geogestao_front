import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class FormsRepositoryImpl extends FormsRepository {
  final FormsDatasource datasource;

  FormsRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, FormsEntity>> createForms({required FormsParam param}) async {
    return tryExecute(() async {
      final response = await datasource.createForms(param: param);
      return FormsEntity.fromJson(response);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, FormsListResponses>> getListForms({required GetListFormsParam param}) async {
    return tryExecute(() async {
      final response = await datasource.getForms(param);
      return FormsListResponses.fromJson(response);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, FormsEntity>> updateForms({required FormsParam param}) async {
    return tryExecute(() async {
      final response = await datasource.updateForms(param);
      return FormsEntity.fromJson(response);
    });
  }
}
