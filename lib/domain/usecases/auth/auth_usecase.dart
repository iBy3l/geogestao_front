import '/core/core.dart';

import '../../entities/entities.dart';
import '../../repositories/repositories.dart';

abstract class AuthUsecase extends BaseUsecase<AuthParam, SignInEntity> {}

class AuthUsecaseImpl extends AuthUsecase {
  final AuthRepository repository;

  AuthUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, SignInEntity>> call(AuthParam param) async {
    return await repository.signIn(params: param);
  }
}
