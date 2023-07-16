import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData defaultThemeData() {
  return ThemeData();
}

class AppTheme {
  AppTheme._();

  static const primaryColor = Color(0xFF13361C);
  static const $222222 = Color(0xFF222222);

  static TextStyle textStyle({
    Color? color = $222222,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    double? wordSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      color: color,
      backgroundColor: backgroundColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
    );
  }
}
