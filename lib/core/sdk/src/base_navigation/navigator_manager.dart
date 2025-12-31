import 'package:flutter/material.dart';

import 'routes_manager.dart';

abstract class INavigationManager {
  Future<T?> pushNamed<T extends Object?>(String route, {Object? arguments});
  Future<T?> pushReplacementNamed<T extends Object?>(String route, {Object? arguments});
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String route, {Object? arguments});
  void pop<T extends Object?>([T? result]);
}

class NavigatorManager implements INavigationManager {
  static final _context = RoutesManager.instance.currentContext;

  @override
  Future<T?> pushNamed<T extends Object?>(String route, {Object? arguments}) async {
    return await Navigator.pushNamed<T>(_context, route, arguments: arguments);
  }

  @override
  Future<T?> pushReplacementNamed<T extends Object?>(String route, {Object? arguments}) async {
    return await Navigator.pushReplacementNamed<T, Object?>(_context, route, arguments: arguments);
  }

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(String route, {Object? arguments}) async {
    return await Navigator.pushNamedAndRemoveUntil<T>(_context, route, (route) => false, arguments: arguments);
  }

  @override
  void pop<T extends Object?>([T? result]) => Navigator.pop(_context, result);
}
