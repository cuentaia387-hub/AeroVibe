import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AeroColors {
  // Primary palette — aqua, sky blue, nature green
  static const Color primaryAqua = Color(0xFF4ECDC4);
  static const Color skyBlue = Color(0xFF45B7D1);
  static const Color deepSkyBlue = Color(0xFF0EA5E9);
  static const Color natureGreen = Color(0xFF6BCB77);
  static const Color softGreen = Color(0xFF96CEB4);
  static const Color grassGreen = Color(0xFF4CAF50);
  static const Color mintGreen = Color(0xFFBEF1E5);

  // Backgrounds
  static const Color deepOcean = Color(0xFF0A1628);
  static const Color nightBlue = Color(0xFF0F2044);
  static const Color auroraBlue = Color(0xFF1A3A5C);
  static const Color glassWhite = Color(0x26FFFFFF); // 15% white
  static const Color glassBorder = Color(0x4DFFFFFF); // 30% white

  // Accent & warm tones
  static const Color sunGold = Color(0xFFFFD93D);
  static const Color sunsetOrange = Color(0xFFFF6B6B);
  static const Color softPurple = Color(0xFFC084FC);
  static const Color auroraViolet = Color(0xFF8B5CF6);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xB3FFFFFF); // 70% white
  static const Color textMuted = Color(0x80FFFFFF); // 50% white

  // Gradients
  static const LinearGradient skyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0EA5E9),
      Color(0xFF4ECDC4),
      Color(0xFF6BCB77),
    ],
  );

  static const LinearGradient auroraGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0F2044),
      Color(0xFF1A3A5C),
      Color(0xFF0EA5E9),
      Color(0xFF4ECDC4),
    ],
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  static const LinearGradient deepAuroraGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0A1628),
      Color(0xFF0D2137),
      Color(0xFF0E3356),
      Color(0xFF1A4A6E),
    ],
  );

  static const LinearGradient glossGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.center,
    colors: [
      Color(0x66FFFFFF), // 40% white
      Color(0x00FFFFFF), // transparent
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x33FFFFFF), // 20% white
      Color(0x0DFFFFFF), // 5% white
    ],
  );

  static const LinearGradient aquaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF4ECDC4),
      Color(0xFF45B7D1),
    ],
  );

  static const LinearGradient greenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6BCB77),
      Color(0xFF4CAF50),
    ],
  );

  static const LinearGradient goldenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFD93D),
      Color(0xFFFF8C42),
    ],
  );
}

class AeroTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AeroColors.primaryAqua,
        secondary: AeroColors.skyBlue,
        tertiary: AeroColors.natureGreen,
        surface: AeroColors.nightBlue,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),
      scaffoldBackgroundColor: AeroColors.deepOcean,
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme: GoogleFonts.nunitoTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: AeroColors.textPrimary,
            letterSpacing: -1.0,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
            letterSpacing: -0.5,
          ),
          headlineLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: AeroColors.textPrimary,
          ),
          headlineMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.textPrimary,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w400,
            color: AeroColors.textSecondary,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            color: AeroColors.textSecondary,
          ),
          labelLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: AeroColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontFamily: 'Nunito',
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: Colors.white,
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}
