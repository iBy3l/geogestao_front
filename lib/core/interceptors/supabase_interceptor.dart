import '/core/core.dart';

class SupabaseInterceptor extends Interceptor {
  final Dio dio;
  final UserStorage storage;
  final StringsConst stringsConst;

  SupabaseInterceptor(this.dio, this.storage, this.stringsConst);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['apikey'] = stringsConst.apikey;
    if (!options.path.contains('auth/v1/token') && !options.path.contains('auth/v1/signup') && !options.path.contains('auth/v1/token?grant_type=password')) {
      final accessToken = await storage.getToken();

      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      final refreshToken = await storage.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await dio.post(
            '${stringsConst.baseUrl}/auth/v1/token?grant_type=refresh_token',
            data: {'refresh_token': refreshToken},
            options: Options(headers: {'apikey': stringsConst.apikey, 'Content-Type': 'application/json'}),
          );

          final newAccessToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];
          await storage.saveToken(newAccessToken);
          await storage.saveRefreshToken(newRefreshToken);

          // Reenvia a requisição original com o novo token
          final retryRequest = err.requestOptions;
          retryRequest.headers['Authorization'] = 'Bearer $newAccessToken';
          final retryResponse = await dio.fetch(retryRequest);
          return handler.resolve(retryResponse);
        } catch (e) {
          return super.onError(err, handler);
        }
      }
    }

    super.onError(err, handler);
  }
}
