import '/core/core.dart';
import '/domain/domain.dart';

abstract class SignUpUsecase extends BaseUsecase<SignUpParamUsername, SignUpEntity> {}

class SignUpParamUsername {
  final String email;
  final String password;

  SignUpParamUsername({required this.email, required this.password});
}

class SignUpUsecaseImpl extends SignUpUsecase {
  final AuthRepository repository;

  SignUpUsecaseImpl(this.repository);

  @override
  Future<BaseWhich<BaseFailure, SignUpEntity>> call(SignUpParamUsername param) async {
    return await repository.signUp(
      params: AuthParam(email: param.email, password: param.password),
    );
  }
}
