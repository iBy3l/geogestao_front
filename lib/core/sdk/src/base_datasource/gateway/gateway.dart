import '/core/core.dart';

abstract interface class IGateway implements IHttp {}

class Gateway extends HttpImpl implements IGateway {
  final Dio dio;
  final Interceptor interceptor;

  Gateway({required this.dio, required this.interceptor}) : super(dio, interceptor: interceptor);
}
