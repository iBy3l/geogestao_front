import '../../../core/core.dart';
import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

abstract class CreateFormsUsecase extends BaseUsecase<FormsParam, FormsEntity> {}

class CreateFormsUsecaseImpl extends CreateFormsUsecase {
  final FormsRepository repository;

  CreateFormsUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, FormsEntity>> call(FormsParam param) async {
    return await repository.createForms(param: param);
  }
}

abstract class GetListFormsUsecase extends BaseUsecase<GetListFormsParam, FormsListResponses> {}

class GetListFormsUsecaseImpl extends GetListFormsUsecase {
  final FormsRepository repository;

  GetListFormsUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, FormsListResponses>> call(GetListFormsParam param) async {
    return await repository.getListForms(param: param);
  }
}

abstract class UpdateFormsUsecase extends BaseUsecase<FormsParam, FormsEntity> {}

class UpdateFormsUsecaseImpl extends UpdateFormsUsecase {
  final FormsRepository repository;

  UpdateFormsUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, FormsEntity>> call(FormsParam param) async {
    return await repository.updateForms(param: param);
  }
}
