import 'package:flutter/material.dart';

class AppTextTheme {
  static final TextTheme lightTextTheme = TextTheme(
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Color.fromRGBO(58, 58, 58, 0.5),
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.normal, color: Colors.white),
  );
}
