import '/core/core.dart';
import '/domain/domain.dart';

abstract class InsertDataUserUsecase extends BaseUsecase<InsertDataUserParamUsername, InsertNameResponse> {}

class InsertDataUserParamUsername {
  final String? id;
  final String name;
  final bool accepted;

  InsertDataUserParamUsername({required this.name, required this.accepted, this.id});
}

class InsertDataUserUsecaseImpl extends InsertDataUserUsecase {
  final AuthRepository repository;

  InsertDataUserUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, InsertNameResponse>> call(InsertDataUserParamUsername param) async {
    return await repository.insertName(name: param.name, id: param.id ?? '', accepted: param.accepted);
  }
}
