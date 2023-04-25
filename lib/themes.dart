import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomThemes {
  static ThemeData themes() {
    return ThemeData(
        textTheme: TextTheme(
          bodySmall: GoogleFonts.rubikDistressed(fontSize: 24),
          bodyMedium: GoogleFonts.rubikDistressed(fontSize: 42),
          titleMedium:
              GoogleFonts.ruslanDisplay(color: Colors.white, fontSize: 24),
          titleLarge: GoogleFonts.ruslanDisplay(fontSize: 40),
        ),
        primaryIconTheme: const IconThemeData(size: 50),
        cardColor: Colors.green,
        shadowColor: Colors.yellow,
        iconTheme: const IconThemeData(color: Colors.white));
  }
}
