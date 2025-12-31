import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';
import '/domain/usecases/auth/get_user_usecase.dart';

class AuthModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {
    i.addLazySingleton<AuthDatasource>(AuthDatasourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<GetUserUsecase>(GetUserUsecase.new);
  }
}
