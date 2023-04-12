import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData dark = FlexThemeData.dark(
    scheme: FlexScheme.mandyRed,
    useMaterial3: true,
    fontFamily: GoogleFonts.poppins().fontFamily,
    surface: Colors.blueGrey.shade800,
  );
  static ThemeData light = FlexThemeData.light(
      scheme: FlexScheme.mandyRed,
      useMaterial3: true,
      fontFamily: GoogleFonts.poppins().fontFamily,
      surface: Colors.indigo.shade200,
      scaffoldBackground: Colors.indigo.shade100,
      secondary: Colors.black);
}
