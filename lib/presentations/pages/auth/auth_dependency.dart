import '/core/core.dart';
import '/presentations/presentations.dart';

class AuthDependency extends Module {
  static const String routeName = '/auth/';

  @override
  void routes(RouteManager r) {
    r.module(SignInDependency.routeName, module: SignInDependency());
    r.module(SignUpDependency.routeName, module: SignUpDependency());
  }
}
