import '/core/core.dart';
import '/domain/domain.dart';

abstract class SignInUsecase extends BaseUsecase<AuthParam, SignInEntity> {}

class SignInUsecaseImpl extends SignInUsecase {
  final AuthRepository repository;

  SignInUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, SignInEntity>> call(AuthParam param) async {
    return await repository.signIn(params: param);
  }
}
