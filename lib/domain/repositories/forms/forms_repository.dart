import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';

abstract class FormsRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, FormsEntity>> createForms({required FormsParam param});
  Future<BaseWhich<BaseFailure, FormsListResponses>> getListForms({required GetListFormsParam param});
  Future<BaseWhich<BaseFailure, FormsEntity>> updateForms({required FormsParam param});
}
