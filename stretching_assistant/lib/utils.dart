import 'package:flutter/material.dart';

class Utils {
  static const Color primaryColor = Color.fromRGBO(128, 133, 255, 1);
  static final Color primaryColorAlt = primaryColor.withOpacity(.3);
  static final BoxShadow primaryColorBoxShadow = boxShadow(primaryColor.withOpacity(.75));

  static const Color primaryBackgroundColor = Color.fromRGBO(240, 240, 240, 1);
  static const Color secondaryBackgroundColor = Colors.white;

  static const Color textColor = Color.fromRGBO(0, 0, 0, 1);
  static final Color textColorAlt = textColor.withOpacity(.3);

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