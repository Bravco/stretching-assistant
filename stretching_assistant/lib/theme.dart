import 'package:flutter/material.dart';
import 'package:stretching_assistant/utils.dart';

class MyTheme {
  static final ThemeData themeData = ThemeData(
    fontFamily: "Outfit",
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Utils.primaryColor),
    scaffoldBackgroundColor: Utils.primaryBackgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: Colors.black,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Utils.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(120, 32)),
        backgroundColor: MaterialStateProperty.all(Utils.primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  );
}