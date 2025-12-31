import '/core/core.dart';
import '/domain/entities/user/user_entity.dart';
import '/domain/repositories/auth/auth_repository.dart';

class GetUserUsecase {
  final AuthRepository authRepository;
  GetUserUsecase(this.authRepository);

  Future<BaseWhich<BaseFailure, UserEntity>> call() async {
    return await authRepository.getUser();
  }
}
