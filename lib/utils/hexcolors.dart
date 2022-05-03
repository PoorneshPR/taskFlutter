import 'package:flutter/material.dart';

class HexColors extends Color {
  HexColors(final String hexColors) : super(_getColorFromHex(hexColors));

  static int _getColorFromHex(String hexColors) {
    hexColors = hexColors.toUpperCase().replaceAll('#', '');
    if (hexColors.length == 6) {
      hexColors = 'FF' + hexColors;

    }
    return int.parse(hexColors, radix: 16);
  }
}