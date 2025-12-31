import 'package:flutter/material.dart';

abstract class IAppIdioms {
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  Iterable<Locale>? supportedLocales;
  Locale? locale;
  LocaleResolutionCallback? localeResolutionCallback;
  List<String> directories = [];
  Locale localeOf(BuildContext context);
}
