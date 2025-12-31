import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';
import '/presentations/presentations.dart';

class SignUpDependency extends Module {
  static const String routeName = 'sign-up/';
  static const String routePath = '${AuthDependency.routeName}$routeName';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthDatasource>(AuthDatasourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<SignUpUsecase>(SignUpUsecaseImpl.new);
    i.addLazySingleton<InsertDataUserUsecase>(InsertDataUserUsecaseImpl.new);
    i.addLazySingleton(SignUpController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(Modular.initialRoute, child: (context) => SignUpPage(controller: context.read<SignUpController>()));
    r.module(EmailConfirmationDependency.routeName, module: EmailConfirmationDependency());
  }
}
