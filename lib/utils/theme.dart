import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white),
        color: Color(0xFF10B401),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      // primaryColor: const Color(0xFFC3E8F6),
      textTheme: const TextTheme(titleLarge: TextStyle(color: Colors.green)),
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




/*
import 'package:flutter/material.dart';
import 'package:hercules/src/theme_colors.dart';
import 'package:hercules/ui/widgets/app_bar.dart';

class AppThemes {
  static const Color tableHeaderColor = Colors.red;
  static ThemeData lightThemeData =
      ThemeData(colorSchemeSeed: Colors.indigo).copyWith(
    useMaterial3: true,
    brightness: Brightness.light,
    dividerColor: Colors.transparent,
    cardColor: Colors.white,
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.indigo,
    ),
    navigationBarTheme: NavigationBarThemeData(
        indicatorColor: ThemeColors.primaryColor.withOpacity(0.3),
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Colors.indigo))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 4.0,
      landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
      showUnselectedLabels: true,
      selectedItemColor: Colors.indigo,
      unselectedItemColor: Colors.black,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme: IconThemeData(color: Colors.indigo),
      unselectedIconTheme: IconThemeData(color: Colors.black),
    ),
    dialogTheme: const DialogTheme().copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.grey, foregroundColor: Colors.white),
    inputDecorationTheme: const InputDecorationTheme(iconColor: Colors.black),
// brightness: Brightness.dark,
    colorScheme: const ColorScheme.light(onPrimary: ThemeColors.primaryColor),
  );

  static ThemeData darkThemeData = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.black,
          indicatorColor: ThemeColors.primaryColorLight),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 4.0,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showUnselectedLabels: true,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.white),
      ),
      navigationRailTheme:
          const NavigationRailThemeData(indicatorColor: Colors.blueAccent),
      inputDecorationTheme: const InputDecorationTheme(
        iconColor: Colors.white,
      ),
      colorScheme: const ColorScheme.dark(
        primary: ThemeColors.primaryColor,
        onPrimary: ThemeColors.primaryColor,
        // onPrimaryContainer: Colors.white,
      ),
      dialogTheme: DialogTheme());
}


*/
