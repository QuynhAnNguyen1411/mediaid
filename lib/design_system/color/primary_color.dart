import 'package:flutter/material.dart';

class PrimaryColor {
  // Primary Color 05
  static const Color primary_05 = Color.fromARGB(255, 1, 92, 137);

  // Tinting function (add white or black based on percentage)
  static Color mixColor(Color baseColor, Color mixWith, double percent) {
    return Color.lerp(baseColor, mixWith, percent)!;
  }

  // Primary color with light and dark levels
  static final Color primary_00 = mixColor(primary_05, Colors.white, 1);
  static final Color primary_01 = mixColor(primary_05, Colors.white, 0.8);
  static final Color primary_02 = mixColor(primary_05, Colors.white, 0.6);
  static final Color primary_03 = mixColor(primary_05, Colors.white, 0.4);
  static final Color primary_04 = mixColor(primary_05, Colors.white, 0.2);
  static final Color primary_06 = mixColor(primary_05, Colors.black, 0.2);
  static final Color primary_07 = mixColor(primary_05, Colors.black, 0.4);
  static final Color primary_08 = mixColor(primary_05, Colors.black, 0.6);
  static final Color primary_09 = mixColor(primary_05, Colors.black, 0.8);
  static final Color primary_10 = mixColor(primary_05, Colors.black, 1);

}