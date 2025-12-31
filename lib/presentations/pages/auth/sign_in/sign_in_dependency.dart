import '/core/core.dart';
import '/domain/domain.dart';
import '/presentations/presentations.dart';

import '../../../../data/datasources/datasources.dart';
import '../../../../data/repositories/repositories.dart';

class SignInDependency extends Module {
  static const String routeName = 'sign-in/';
  static const String routePath = '${AuthDependency.routeName}$routeName';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthDatasource>(AuthDatasourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<SignInUsecase>(SignInUsecaseImpl.new);
    i.addLazySingleton(SignInController.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => SignInPage(controller: Modular.get<SignInController>()));
  }
}
