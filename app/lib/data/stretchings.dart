import 'package:flutter/cupertino.dart';
import 'package:app/model/stretching.dart';

String? tempTitle;
List<int> selected = [];

List<Stretching> stretchings = <Stretching>[
  Stretching(
    title: "karate",
    stretches: 50,
    logo: const AssetImage("assets/stretchings/karate/logo.png"),
  ),
];

List<CustomStretching> customStretchings = <CustomStretching>[];