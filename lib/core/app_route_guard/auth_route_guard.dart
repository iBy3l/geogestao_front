import 'dart:async';

import '/core/core.dart';
import '/domain/usecases/auth/get_user_usecase.dart';

class AppRouteGuard extends RouteGuard {
  final AuthService _authService;

  AppRouteGuard(this._authService) : super(redirectTo: Modular.initialRoute);

  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final isAuthenticated = await _authService.isAuthenticated();
    if (isAuthenticated) {
      return true;
    }

    Modular.to.pushReplacementNamed(Modular.initialRoute);
    return false;
  }
}

class AuthService {
  final GetUserUsecase getUserUsecase;
  AuthService(this.getUserUsecase);
  Future<bool> isAuthenticated() async {
    final result = await getUserUsecase();
    return result.ways((user) => user.email.isNotEmpty && !user.isAnonymous, (_) => false);
  }
}
