import 'package:flutter/material.dart';

class Stretching {
  final String title;
  final int stretches;
  final AssetImage logo;

  Stretching({
    required this.title,
    required this.stretches,
    required this.logo,
  });
}

class CustomStretching {
  final String title;
  final List<int> stretches;

  CustomStretching({
    required this.title,
    required this.stretches,
  });
}