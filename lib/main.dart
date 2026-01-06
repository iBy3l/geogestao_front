import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:window_manager/window_manager.dart';

import '/core/core.dart';
import 'apps/apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'assets/.env');
  if (!kIsWeb) {
    windowManager.setFullScreen(true);
  }

  usePathUrlStrategy();
  initializeSEO();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
