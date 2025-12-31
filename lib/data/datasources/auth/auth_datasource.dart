import '/core/core.dart';

import '../../../domain/entities/entities.dart';

abstract class AuthDatasource {
  Future<Map<String, dynamic>> signIn({required AuthParam params});
  Future<Map<String, dynamic>> signUp({required AuthParam params});
  Future<Map<String, dynamic>> signOut({required AuthParam params});
  Future<Map<String, dynamic>> forgotPassword({required AuthParam params});
  Future<Map<String, dynamic>> insertName({required String id, required String name, required bool accepted});
  Future<Map<String, dynamic>> getUser();
}

class AuthDatasourceImpl extends AuthDatasource {
  final IGateway gateway;
  final StringsConst stringsConst;

  AuthDatasourceImpl(this.gateway, this.stringsConst);

  static const String _endpointSignIn = '/auth/v1/token?grant_type=password';
  static const String _endpointSignUp = '/auth/v1/signup';
  static const String _endpointSignOut = '/auth/v1/logout';
  static const String _endpointForgotPassword = '/auth/v1/recover';
  static const String _endpointInsertName = '/rest/v1/rpc/insert_user_name';
  static const String _endpointGetUser = '/auth/v1/user';

  @override
  Future<Map<String, dynamic>> signIn({required AuthParam params}) async {
    final response = await gateway.post(_endpointSignIn, params.toJson());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> signUp({required AuthParam params}) async {
    final response = await gateway.post(_endpointSignUp, params.toJson());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> signOut({required AuthParam params}) async {
    final response = await gateway.post(_endpointSignOut, params.toJson());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> forgotPassword({required AuthParam params}) async {
    final response = await gateway.post(_endpointForgotPassword, params.toJson());
    return response.data;
  }

  @override
  Future<Map<String, dynamic>> insertName({required String id, required String name, required bool accepted}) async {
    gateway.addInterceptor(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${stringsConst.apikey}';
          return handler.next(options);
        },
      ),
    );
    final response = await gateway.post(_endpointInsertName, {'uuid_input': id, 'name_input': name, 'accepted_input': accepted});

    return response.data;
  }

  @override
  Future<Map<String, dynamic>> getUser() async {
    final response = await gateway.get(_endpointGetUser);
    return response.data;
  }
}
