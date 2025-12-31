import '/core/core.dart';
import '/domain/entities/user/user_entity.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/repositories/repositories.dart';
import '../../datasources/datasources.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Future<BaseWhich<BaseFailure, AuthEntity>> forgotPassword({required AuthParam params}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseWhich<BaseFailure, AuthEntity>> refreshToken({required AuthParam params}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<BaseWhich<BaseFailure, AuthEntity>> resetPassword({required AuthParam params}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<BaseWhich<BaseFailure, SignInEntity>> signIn({required AuthParam params}) {
    return tryExecute(() async {
      final response = await datasource.signIn(params: params);
      return SignInEntity.fromJson(response);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, AuthEntity>> signOut({required AuthParam params}) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<BaseWhich<BaseFailure, SignUpEntity>> signUp({required AuthParam params}) async {
    return tryExecute(() async {
      final response = await datasource.signUp(params: params);
      return SignUpEntity.fromJson(response);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, InsertNameResponse>> insertName({required String id, required String name, required bool accepted}) async {
    return tryExecute(() async {
      final response = await datasource.insertName(id: id, name: name, accepted: accepted);
      return InsertNameResponse.fromJson(response);
    });
  }

  @override
  Future<BaseWhich<BaseFailure, UserEntity>> getUser() async {
    return tryExecute(() async {
      final response = await datasource.getUser();
      return UserEntity.fromJson(response);
    });
  }
}
