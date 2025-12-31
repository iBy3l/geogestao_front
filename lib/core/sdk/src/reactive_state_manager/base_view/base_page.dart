import 'package:flutter/material.dart';

import '/core/core.dart';

abstract class BasePage<T extends StatefulWidget, C extends BaseController> extends State<T> {
  C get _controller => Modular.get<C>();

  C get controller => _controller;

  @override
  void initState() {
    debugPrint('INITIALIZED $C');
    if (mounted) {
      C;
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    debugPrint('DISPOSED $C');
    super.dispose();
  }
}
