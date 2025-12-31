import 'package:flutter/material.dart';

import '/core/core.dart';

extension ThemeExtension on BuildContext {
  // context.theme
  ThemeData get theme => Theme.of(this);

  // context.textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  //CustomColorsScheme
  CustomColors get color => CustomColors();

  TextConst get text => TextConst();

  IconConst get icon => IconConst();

  // // image
  ImageConst get image => ImageConst();

  double get sizewidth => MediaQuery.of(this).size.width;
  double get sizeheight => MediaQuery.of(this).size.height;
}

extension DateTimeExtension on DateTime {
  String toDateString() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }
}
