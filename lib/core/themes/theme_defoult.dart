import 'package:flutter/material.dart';

import '/core/core.dart';

class ThemeDefoult {
  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: CustomColors.branco,
    appBarTheme: AppBarTheme(backgroundColor: CustomColors.laranja, foregroundColor: CustomColors.branco, centerTitle: true),
    progressIndicatorTheme: ProgressIndicatorThemeData(color: CustomColors.laranja),
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: CustomColors.laranja),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(CustomColors.laranja),
        foregroundColor: WidgetStatePropertyAll<Color>(CustomColors.branco),
        textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
        iconColor: WidgetStatePropertyAll<Color>(CustomColors.branco),
      ),
    ),
    // switch
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return states.contains(WidgetState.selected) ? CustomColors.bege : CustomColors.cinza;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return states.contains(WidgetState.selected) ? CustomColors.laranja : CustomColors.bege;
      }),
      trackOutlineWidth: WidgetStateProperty.resolveWith<double>((Set<WidgetState> states) {
        return states.contains(WidgetState.selected) ? 0 : 0;
      }),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll<Color>(CustomColors.laranja),
        textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        overlayColor: WidgetStatePropertyAll<Color>(CustomColors.laranjaOpaco),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return states.contains(WidgetState.selected) ? CustomColors.laranja : CustomColors.apple;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return states.contains(WidgetState.selected) ? CustomColors.apple : CustomColors.laranja;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return states.contains(WidgetState.selected) ? CustomColors.cinza : CustomColors.cinza;
        }),
        iconColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
          return states.contains(WidgetState.selected) ? CustomColors.branco : CustomColors.laranja;
        }),
        textStyle: const WidgetStatePropertyAll<TextStyle>(TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(EdgeInsets.symmetric(horizontal: 8, vertical: 10)),
      ),
    ),
    // checkbox
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return states.contains(WidgetState.selected) ? CustomColors.laranja : CustomColors.branco;
      }),
      checkColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        return states.contains(WidgetState.selected) ? CustomColors.branco : CustomColors.laranja;
      }),
      side: BorderSide(color: CustomColors.preto, width: 2),
    ),
    // inputs
    textSelectionTheme: TextSelectionThemeData(cursorColor: CustomColors.laranja, selectionColor: CustomColors.laranjaOpaco, selectionHandleColor: CustomColors.laranja),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: CustomColors.cinza, fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: CustomColors.cinza, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: CustomColors.laranja, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: CustomColors.vermelho, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: CustomColors.vermelho, width: 2),
      ),
      errorStyle: TextStyle(color: CustomColors.vermelho, fontSize: 14),
      labelStyle: TextStyle(color: CustomColors.cinza, fontSize: 16),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      iconColor: CustomColors.laranja,
      textColor: CustomColors.laranja,
      // divisor transparante
      shape: RoundedRectangleBorder(side: BorderSide(color: CustomColors.branco, width: 0)),
    ),
    // tabs
  );
}
