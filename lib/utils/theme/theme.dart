import 'package:flutter/material.dart';
import 'package:nai_hub/utils/theme/text_theme.dart';

import 'colors.dart';

class TAppTheme {
  // _ means private sign.SO the constructor is private
  TAppTheme._();

  // Because constructor is private su we can only use static function
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: mainColor,
    scaffoldBackgroundColor: white,
    textTheme: TTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: mainColor,
    scaffoldBackgroundColor: black,
    textTheme: TTextTheme.darkTextTheme,
  );
}
