import 'package:flutter/material.dart';

import 'colors.dart';

class TTextTheme {
  TTextTheme._(); // Private constructor

  static TextTheme lightTextTheme = const TextTheme(
    bodyMedium: TextStyle(
      color: mainColor,
    ), // Default text color for light theme
  );

  static TextTheme darkTextTheme = const TextTheme(
    bodyMedium: TextStyle(
      color: Colors.white,
    ), // Default text color for dark theme
  );
}
