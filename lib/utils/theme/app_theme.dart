import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color background = Color(0xFF0D0D0F);
  static const Color buttonSurface = Color(0xFF1C1C1E);
  static const Color operatorColor = Color(0xFFFF9500);
  static const Color errorColor = Color(0xFFFF453A);
  static const Color accentGray = Color(0xFF8E8E93);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.outfitTextTheme(
        ThemeData.dark().textTheme,
      ),
    );
  }

  static TextStyle get displayLargeStyle {
    return GoogleFonts.outfit(
      fontSize: 64,
      fontWeight: FontWeight.w300,
      color: AppColors.textPrimary,
      letterSpacing: 0,
    );
  }

  static TextStyle get expressionStyle {
    return GoogleFonts.outfit(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary.withOpacity(0.5),
      letterSpacing: 0,
    );
  }

  static TextStyle get buttonLabelStyle {
    return GoogleFonts.outfit(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.textPrimary,
      letterSpacing: 0,
    );
  }

  static TextStyle get errorStyle {
    return GoogleFonts.outfit(
      fontSize: 64,
      fontWeight: FontWeight.w300,
      color: AppColors.errorColor,
      letterSpacing: 0,
    );
  }
}
