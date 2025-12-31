import '../../../core/core.dart';
import '../../../domain/entities/entities.dart';

abstract class FormsViewRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, FormsViewEntity>> getFormGate({required FormsViewParam param});
}
