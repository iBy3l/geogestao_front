import '/core/core.dart';

abstract class IHttp {
  IHttp._();

  Future<Response<dynamic>> get(String path, {Map<String, dynamic>? queryParameters});

  Future<Response<dynamic>> post(String url, dynamic data, {Map<String, dynamic>? queryParameters});

  Future<Response<dynamic>> put(String url, dynamic data, {Map<String, dynamic>? queryParameters});

  Future<Response<dynamic>> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters});

  Future<Response> patch(String path, dynamic data, {Map<String, dynamic>? queryParameters});

  addInterceptor(Interceptor interceptor);
}
