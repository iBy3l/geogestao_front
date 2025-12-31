import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/core/core.dart';

class CustomScaffold extends StatelessWidget {
  final Meta? metas;
  final Widget? body;
  final Widget? drawer;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  const CustomScaffold({super.key, this.metas, this.body, this.appBar, this.drawer, this.bottomNavigationBar, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    if (metas != null) if (kIsWeb) metas?.setMeta();
    return SelectionArea(
      child: Scaffold(drawer: drawer, appBar: appBar, body: body, backgroundColor: backgroundColor ?? context.theme.colorScheme.surface, bottomNavigationBar: bottomNavigationBar),
    );
  }
}
