import 'package:flutter/material.dart';

import 'base_routes.dart';

abstract class IRoutesManager {
  GlobalKey<NavigatorState> get navigatorKey;
  BuildContext get currentContext;
  String get initialRoute;
  Route<dynamic> generateRoute(RouteSettings settings);
}

class RoutesManager implements IRoutesManager {
  RoutesManager._();
  static final RoutesManager _instance = RoutesManager._();
  static RoutesManager get instance => _instance;

  final List<IRoutes> _routes = [AppRoutesManager.instance];

  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  BuildContext get currentContext => _navigatorKey.currentState!.overlay!.context;

  @override
  String get initialRoute => _routes.whereType<AppRoutesManager>().where((element) => element.initialRoute.isNotEmpty).first.initialRoute;

  @override
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    for (final route in _routes) {
      final routes = route.routes;
      if (routes.containsKey(settings.name)) {
        return MaterialPageRoute(builder: (context) => routes[settings.name]!(context, args), settings: RouteSettings(name: settings.name));
      }
    }

    return MaterialPageRoute(builder: (context) => Scaffold(body: Center(child: Text("Rota não encontrada: ${settings.name}"))));
  }

  void addRoutes(IRoutes routes) {
    _routes.add(routes);
  }
}

class FadeInRoute extends PageRouteBuilder {
  final Widget page;

  FadeInRoute({required this.page, required String routeName})
      : super(
          settings: RouteSettings(name: routeName), // set name here
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
        );
}
