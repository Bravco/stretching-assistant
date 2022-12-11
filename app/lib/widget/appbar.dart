import 'package:app/utils.dart' as utils;
import 'package:flutter/material.dart';

class AppBarPf extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppBarPf({
    Key? key,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: utils.color0,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: utils.color30,
      iconTheme: const IconThemeData(
        color: utils.color0,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}