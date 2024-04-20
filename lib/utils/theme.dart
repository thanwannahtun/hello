import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(color: Color(0xFF10B401)),
      // primaryColor: const Color(0xFFC3E8F6),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
        textStyle: MaterialStatePropertyAll(TextStyle(color: Colors.green)),
      )),
      buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary, hoverColor: Colors.red),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF10B401),
      ),
      brightness: Brightness.light);

  static ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF246E13)),
      primaryColor: const Color(0xFF114349),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF10B401)),
      brightness: Brightness.dark);

  static ThemeData of(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.copyWith(primaryColor: Colors.green);
    // add others later
  }
}
