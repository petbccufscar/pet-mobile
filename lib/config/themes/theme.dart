import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF1485BF),
          brightness: Brightness.light,
          primary: Color(0xFF1485BF),
          secondary: Colors.blue),
      scaffoldBackgroundColor: Color(0xFFDFECEB),
      fontFamily: 'Hack',
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.purple,
      ),
    );
  }
}
