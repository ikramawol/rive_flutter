import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _primaryColor = Color.fromARGB(255, 255, 255, 255);
  static const _secondaryColor = Color.fromARGB(255, 110, 164, 235);
  // static const _accentColor = Color(0xFF00D4AA);
  // static const _gradientStart = Color(0xFF667eea);
  // static const _gradientEnd = Color(0xFF764ba2);

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Color.fromARGB(255, 34, 34, 34),
      onSurface: Colors.black,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      secondary: _secondaryColor,
      surface: Color.fromARGB(255, 22, 28, 36),
      onPrimary: Colors.white,
      onSecondary: Color.fromARGB(255, 20, 20, 20),
      onSurface: Colors.white,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    ),
  );
} 