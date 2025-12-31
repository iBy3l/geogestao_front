import '/core/core.dart';
import '/domain/entities/user/user_entity.dart';

import '../../../domain/entities/entities.dart';

abstract class AuthRepository extends BaseRepository {
  Future<BaseWhich<BaseFailure, SignInEntity>> signIn({required AuthParam params});
  Future<BaseWhich<BaseFailure, SignUpEntity>> signUp({required AuthParam params});
  Future<BaseWhich<BaseFailure, AuthEntity>> signOut({required AuthParam params});
  Future<BaseWhich<BaseFailure, AuthEntity>> forgotPassword({required AuthParam params});
  Future<BaseWhich<BaseFailure, AuthEntity>> resetPassword({required AuthParam params});
  Future<BaseWhich<BaseFailure, AuthEntity>> refreshToken({required AuthParam params});
  Future<BaseWhich<BaseFailure, InsertNameResponse>> insertName({required String name, required String id, required bool accepted});
  Future<BaseWhich<BaseFailure, UserEntity>> getUser();
}
