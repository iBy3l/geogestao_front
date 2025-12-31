import 'package:flutter/material.dart';

import '/core/core.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  static const Color primaryColor = Color(0xFF19D29A);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: context.text.appName,
      color: Colors.white,
      theme: ThemeData(
        useMaterial3: true,

        // 🔹 CORES BASE
        primaryColor: primaryColor,

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: Colors.white,
          secondary: primaryColor.withOpacity(0.85),
          onSecondary: Colors.white,
          surface: const Color(0xFFF5F8FD),
          onSurface: Colors.black,
          error: const Color(0xFFB00020),
          onError: Colors.white,
        ),

        scaffoldBackgroundColor: Colors.white,

        // 🔹 TIPOGRAFIA
        fontFamily: GoogleFonts.poppins().fontFamily,

        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, height: 1.2),
          headlineMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, height: 1.2),
          titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.2),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.4),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.35),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.3),
          labelMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, height: 1.2),
          labelSmall: TextStyle(fontSize: 9, fontWeight: FontWeight.w300, height: 1.2),
        ),

        // 🔹 BOTÕES
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),

        // 🔹 INPUTS
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      routerDelegate: Modular.routerDelegate,
      routeInformationParser: Modular.routeInformationParser,
    );
  }
}
