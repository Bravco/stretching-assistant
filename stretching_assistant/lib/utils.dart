import 'package:flutter/material.dart';

class Utils {
  // Variables
  static final MaterialColor primaryColor = MaterialColor(0xFF5E8BE3, {
    50: const Color(0xFF5E8BE3).withOpacity(.1),
    100: const Color(0xFF5E8BE3).withOpacity(.2),
    200: const Color(0xFF5E8BE3).withOpacity(.3),
    300: const Color(0xFF5E8BE3).withOpacity(.4),
    400: const Color(0xFF5E8BE3).withOpacity(.5),
    500: const Color(0xFF5E8BE3).withOpacity(.6),
    600: const Color(0xFF5E8BE3).withOpacity(.7),
    700: const Color(0xFF5E8BE3).withOpacity(.8),
    800: const Color(0xFF5E8BE3).withOpacity(.9),
    900: const Color(0xFF5E8BE3).withOpacity(1),
  });

  static final Color primaryColorAlt = primaryColor.withOpacity(.3);
  static final BoxShadow primaryColorBoxShadow = boxShadow(primaryColor.withOpacity(.75));

  static const Color primaryBackgroundColor = Color.fromRGBO(40, 44, 52, 1);
  static const Color secondaryBackgroundColor = Color.fromRGBO(33, 37, 43, 1);

  static const Color textColor = Colors.white;
  static final Color textColorAlt = textColor.withOpacity(.3);

  // Theme
  static final ThemeData themeData = ThemeData(
    fontFamily: "Outfit",
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(),
    primarySwatch: Utils.primaryColor,
    scaffoldBackgroundColor: Utils.primaryBackgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      foregroundColor: textColor,
      backgroundColor: Colors.transparent,
      centerTitle: true,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
      backgroundColor: Utils.primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(120, 32)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Utils.primaryColor),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: primaryColor,
        ),
      ),
    ),
  );

  // Other
  static String formatSeconds(int seconds) {
    return Duration(seconds: seconds).toString().substring(2, 7);
  }

  static BoxShadow boxShadow(Color color) {
    return BoxShadow(
      color: color,
      spreadRadius: 0,
      blurRadius: 20,
      offset: const Offset(0, 4),
    );
  }
}