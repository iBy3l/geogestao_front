import '/core/core.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) async {
    i.addInstance<StringsConst>(StringsConst());
    i.addLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addLazySingleton<BaseStorageSecure>(SecureStorage.new);
    i.addLazySingleton<BaseStorage>(BaseStoredImpl.new);
    i.addLazySingleton<UserStorage>(UserStorageImpl.new);
    i.addLazySingleton<Storage>(Storage.new);
    i.addLazySingleton<AuthService>(AuthService.new);
    i.addLazySingleton<Interceptor>(SupabaseInterceptor.new);
    i.addLazySingleton<IGateway>(Gateway.new);
    i.addLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: i<StringsConst>().baseUrl)));
  }
}
