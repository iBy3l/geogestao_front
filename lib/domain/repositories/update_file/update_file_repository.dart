import '/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class UpdateFileRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, UpdateFileEntity>> createUpdateFile({required UpdateFileParam param});
}
