import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AeroColors {
  // Authentic Frutiger Aero Bright Palette
  static const Color skyBlue = Color(0xFF63B4D1);
  static const Color brightCyan = Color(0xFF00E5FF);
  static const Color natureGreen = Color(0xFF7CDB2A);
  static const Color grassGreen = Color(0xFF4CAF50);
  static const Color waterBlue = Color(0xFF29B6F6);
  static const Color sunnyYellow = Color(0xFFFFD54F);
  
  // Backgrounds
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF0F8FF); // Alice Blue
  static const Color glassWhite = Color(0x66FFFFFF); // 40% white
  static const Color glassBorder = Color(0x80FFFFFF); // 50% white
  static const Color darkText = Color(0xFF1E3A5F);
  static const Color mutedText = Color(0xFF546E7A);

  // Gradients
  static const LinearGradient brightSkyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF4FC3F7), // Light Blue
      Color(0xFFE1F5FE), // Very Light Blue
      Color(0xFFFFFFFF), // White horizon
    ],
  );

  static const LinearGradient freshGrassGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFAED581),
      Color(0xFF7CB342),
    ],
  );

  static const LinearGradient glossyWhiteGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xE6FFFFFF), // 90% white
      Color(0x80FFFFFF), // 50% white
    ],
  );
}

class AeroTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AeroColors.waterBlue,
        secondary: AeroColors.natureGreen,
        tertiary: AeroColors.sunnyYellow,
        surface: AeroColors.glassWhite,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AeroColors.darkText,
      ),
      scaffoldBackgroundColor: AeroColors.offWhite,
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme: GoogleFonts.nunitoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: AeroColors.darkText,
            letterSpacing: -1.0,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.darkText,
            letterSpacing: -0.5,
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.darkText,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.darkText,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.darkText,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.darkText,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.darkText,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            color: AeroColors.mutedText,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.waterBlue,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AeroColors.darkText),
        titleTextStyle: TextStyle(
          color: AeroColors.darkText,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
