import 'package:flutter/material.dart';

typedef Routes = Map<String, Function(BuildContext context, Object? params)>;

abstract interface class IRoutes {
  Routes get routes;
}

class AppRoutesManager implements IRoutes {
  AppRoutesManager._();

  static final AppRoutesManager instance = AppRoutesManager._();

  final List<Routes> _routes = [];

  String get initialRoute => '/';

  @override
  Routes get routes => _routes.fold({}, (prev, element) => {...prev, ...element});

  childInitialRouter(AppRoutesManager r, Widget Function(BuildContext context, Object? params) initialRoute) {
    r.page({
      r.initialRoute: (context, params) => initialRoute(context, params),
    });
  }

  erroNotFoud(AppRoutesManager r, Widget Function(BuildContext context, Object? params) errorRoute) {
    r.page({
      r.initialRoute: (context, params) => errorRoute(context, params),
    });
  }

  erroPage(AppRoutesManager r, Widget Function(BuildContext context, Object? params) errorRoute) {
    r.page({
      r.initialRoute: (context, params) => errorRoute(context, params),
    });
  }

  page(Routes routes) {
    _routes.add(routes);
  }
}
