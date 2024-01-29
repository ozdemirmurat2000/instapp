import 'package:flutter/material.dart';

class KTextStyle {
  static TextStyle KHeaderTextStyle(
      {Color? textColor, required double fontSize, FontWeight? fontWeight}) {
    return TextStyle(
        fontFamily: 'Manrope',
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight);
  }
}
