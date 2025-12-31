import '/core/core.dart';

class HttpImpl implements IHttp {
  final Dio _dio;
  final AppLogger _logger = AppLogger();

  HttpImpl(this._dio, {Interceptor? interceptor}) {
    if (interceptor != null) {
      addInterceptor(interceptor);
    }
  }

  Future<Response> _execute(Future<Response> Function() func) async {
    try {
      final response = await func();
      _logInfos(
        response.requestOptions.path,
        response.requestOptions.method,
        queryParameters: response.requestOptions.queryParameters,
        headers: response.requestOptions.headers,
        data: response.requestOptions.data,
      );
      if (response.statusCode != null) {
        _logResponse(response.requestOptions.path, response.requestOptions.method, headers: response.requestOptions.headers, response: response);
      }
      return response;
    } on DioException catch (e) {
      _logInfosError(e.requestOptions.path, e.requestOptions.method, queryParameters: e.requestOptions.queryParameters, headers: e.requestOptions.headers, data: e.requestOptions.data);
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('code')) {
        handleSupabaseError(data);
      }
      if (e.response?.statusCode != null) {
        _logErrorResponse(e.response!);
        final errorMessage = _extractErrorMessage(e.response?.data);

        throw ServerException(statusCode: e.response?.statusCode ?? 0, statusMessage: errorMessage, dataMessage: errorMessage);
      } else {
        throw NoConnectionException();
      }
    } on TypeError catch (e, stackTrace) {
      _logger.e("TypeError: $e\nStackTrace: $stackTrace");
      throw DataPersistenceException();
    } on UnauthorizedException catch (e) {
      throw UnauthorizedFailure(stackTrace: e.stackTrace);
    } on SupabaseException catch (e) {
      throw SupabseFailure(stackTrace: e.stackTrace);
    } catch (e, stackTrace) {
      _logger.e("Unexpected error: $e\nStackTrace: $stackTrace");
      if (e is ServerException || e is DataPersistenceException) {
        rethrow;
      }
      throw NoConnectionException();
    }
  }

  // Função para extrair a mensagem principal
  String _extractErrorMessage(dynamic data) {
    if (data is Map<String, dynamic> && data['message'] != null) {
      return data['message'] as String;
    }
    return data?.toString() ?? 'Erro desconhecido';
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.get(path, queryParameters: queryParameters));

  @override
  Future<Response> post(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.post(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters, dynamic data}) async => _execute(() => _dio.delete(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> put(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.put(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> patch(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.patch(path, queryParameters: queryParameters, data: data));

  @override
  void addInterceptor(Interceptor interceptor) => _dio.interceptors.add(interceptor);

  void _logInfos(String path, String method, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, dynamic data}) {
    _logger.i(
      'Method: $method \nPath: ${_dio.options.baseUrl}$path \nQueryParam: $queryParameters \nData: $data \nHeaders: $headers',
      time: DateTime.now(),
      error: 'Request',
      stackTrace: StackTrace.current,
    );
  }

  void _logInfosError(String path, String method, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, dynamic data}) {
    _logger.e(
      '[Error Method]: $method \nPath: ${_dio.options.baseUrl}$path \nQueryParam: $queryParameters \nData: $data \nHeaders: $headers',
      time: DateTime.now(),
      error: 'Request',
      stackTrace: StackTrace.current,
    );
  }

  void _logResponse(String path, String method, {Map<String, dynamic>? headers, Response? response}) {
    _logger.d('[RESPONSE]: ${response?.statusCode}\nMethod: $method \nPath: ${_dio.options.baseUrl}$path \nResponse: ${response?.data}');
  }

  void _logErrorResponse(Response response) {
    _logger.e(
      '[ERROR RESPONSE]: ${response.statusCode}\nPath: ${response.requestOptions.path} \nResponse: ${response.data}',
      time: DateTime.now(),
      error: response.statusMessage,
      stackTrace: StackTrace.current,
    );
  }
}
