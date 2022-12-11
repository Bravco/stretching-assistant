import 'package:flutter/material.dart';

const Color color60 = Color.fromRGBO(255, 255, 255, 1);
const Color color60Alt = Color.fromRGBO(255, 255, 255, .3);

const Color color30 = Color.fromRGBO(230, 230, 230, 1);
const Color color30Alt = Color.fromRGBO(230, 230, 230, .3);

const Color color10 = Color.fromRGBO(154, 118, 254, 1);
const Color color10Alt = Color.fromRGBO(154, 118, 254, .3);

const SweepGradient color10gradient = SweepGradient(
  colors: <Color>[
   Color.fromARGB(255, 95, 36, 255),
   Color.fromRGBO(154, 118, 254, 1),
   Color.fromARGB(255, 194, 172, 255),
  ],
  stops: <double>[
    .2,
    .6,
    .8,
  ],
);

const Color color0 = Color.fromRGBO(0, 0, 0, 1);
const Color color0Alt = Color.fromRGBO(0, 0, 0, .3);

String formatTime(int seconds) {
  return Duration(seconds: seconds).toString().substring(3, 7);
}