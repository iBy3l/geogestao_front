import '/core/core.dart';
import '/data/data.dart';
import '/domain/domain.dart';
import '/presentations/presentations.dart';

class EmailConfirmationDependency extends Module {
  static const String routeName = 'email-confirmation';
  static const String routePath = '${SignUpDependency.routePath}$routeName';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthDatasource>(AuthDatasourceImpl.new);
    i.addLazySingleton<AuthRepository>(AuthRepositoryImpl.new);
    i.addLazySingleton<SignUpUsecase>(SignUpUsecaseImpl.new);
    i.addLazySingleton(EmailConfirmationController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) {
        final data = r.args.data as Map<String, dynamic>? ?? {};
        final email = data['email'] ?? '';
        return EmailConfirmationPage(email: email, controller: context.read<EmailConfirmationController>());
      },
    );
  }
}
