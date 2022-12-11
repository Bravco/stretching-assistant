import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

class OutlinedButtonPf extends StatelessWidget {
  final VoidCallback? voidCallback;
  final String title;
  final Color titleColor;
  final IconData? iconData;
  final Color iconColor;
  final Color overlayColor;

  const OutlinedButtonPf({
    Key? key,
    required this.voidCallback,
    required this.title,
    this.titleColor = utils.color0,
    required this.iconData,
    this.iconColor = utils.color10,
    this.overlayColor = utils.color10Alt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: voidCallback,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(overlayColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      icon: Icon(
        iconData,
        size: 32,
        color: iconColor,
      ),
      label: Text(
        title,
        style: TextStyle(
          color: titleColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}