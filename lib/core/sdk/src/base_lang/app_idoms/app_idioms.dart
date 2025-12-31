// import 'package:vexpress_front/core/sdk/dependecies/dependecies.dart';
// import 'package:vexpress_front/core/sdk/src/src.dart';

// class AppIdoms implements IAppIdioms {
//   static final AppIdoms instance = AppIdoms._internal();

//   AppIdoms._internal();

//   @override
//   Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates = [
//     GlobalMaterialLocalizations.delegate,
//     GlobalWidgetsLocalizations.delegate,
//     GlobalCupertinoLocalizations.delegate,
//     LocalJsonLocalization.delegate,
//   ];

//   @override
//   Locale? locale;

//   @override
//   LocaleResolutionCallback? localeResolutionCallback = (locale, supportedLocales) {
//     if (supportedLocales.contains(locale)) {
//       return locale;
//     }
//     if (locale?.languageCode == 'en') {
//       return const Locale('en', 'US');
//     }
//     return const Locale('pt', 'BR');
//   };

//   void changeLocale(Locale locale) {
//     this.locale = locale;
//   }

//   @override
//   Iterable<Locale>? supportedLocales = locales;

//   @override
//   List<String> directories = ['assets/lang'];

//   @override
//   Locale localeOf(BuildContext context) {
//     return Localizations.localeOf(context);
//   }
// }

// List<Locale> locales = [
//   const Locale('pt', 'BR'),
//   const Locale('en', 'US'),
// ];
