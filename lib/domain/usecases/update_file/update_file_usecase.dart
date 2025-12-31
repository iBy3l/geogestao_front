import '/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

abstract class UpdateFileUsecase extends BaseUsecase<UpdateFileParam, UpdateFileEntity> {}

class UpdateFileUsecaseParams {
  // final Example example;
  // final Example2 example2;

  // UpdateFileUsecaseParams({required this.example, required this.example2});
}

class UpdateFileUsecaseImpl extends UpdateFileUsecase {
  final UpdateFileRepository repository;

  UpdateFileUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, UpdateFileEntity>> call(UpdateFileParam param) async {
    return await repository.createUpdateFile(param: param);
  }
}
