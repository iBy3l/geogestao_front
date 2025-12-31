import 'package:flutter/material.dart';

import '/core/core.dart';
import '/presentations/presentations.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [CoreModule(), AuthModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<AuthService>(AuthService.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      Modular.initialRoute,
      child: (context) => SplashPage(initialRoute: '/auth/sign-in/'),
      transition: TransitionType.rotate,
    );
    r.module(AuthDependency.routeName, module: AuthDependency());
    r.module(HomeDependency.routeName, module: HomeDependency(), guards: [AppRouteGuard(Modular.get<AuthService>())]);
    VerifyModuler().routes(r);
  }
}

class VerifyModuler extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/verify/:token?', child: (context) => SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  final String? initialRoute;
  const SplashPage({super.key, this.initialRoute});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> init() async {
    Storage storage = Modular.get<Storage>();
    await storage.initialize();
    await Future.delayed(Duration(seconds: 2));
    if (storage.uuid != '') {
      Modular.to.pushReplacementNamed('/home');
      return;
    }
    Modular.to.pushReplacementNamed(widget.initialRoute ?? '/home');
  }

  @override
  void initState() {
    if (widget.initialRoute == null) return;
    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Color(0xff1976D2),
        highlightColor: context.theme.colorScheme.onPrimary,
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 1500),
        enabled: true,
        child: Image.asset(context.image.logoPrimary, fit: BoxFit.cover, height: 50),
      ),
    );
  }
}
