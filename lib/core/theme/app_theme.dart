import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,

      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
        surfaceContainer: AppColors.surfaceCard, // card, chips
        surfaceContainerHighest: AppColors.surfaceContainer, // input, sheet
        error: AppColors.danger,
      ),

      textTheme: _buildTextTheme(
        AppColors.onSurface,
        AppColors.onSurfaceVariant,
        AppColors.primaryDark,
      ),

      cardTheme: _buildCardTheme(AppColors.surfaceCard, AppColors.onSurface),

      inputDecorationTheme: _buildInputTheme(
        AppColors.surfaceContainer,
        AppColors.outline,
        AppColors.primary,
        AppColors.danger,
        AppColors.onSurfaceVariant,
      ),
    );
  }

  static ThemeData get darkTheme {
    const darkSurface = Color(0xFF1A1C1E);
    const darkSurfaceContainer = Color(0xFF252729);
    const darkSurfaceCard = Color(0xFF2C2F33);
    const darkOnSurface = Color(0xFFE3E5E8);
    const darkOnSurfaceVariant = Color(0xFF8B9199);
    const darkOutline = Color(0xFF3A3D42);

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: darkSurface,

      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        surface: darkSurface,
        onSurface: darkOnSurface,
        onSurfaceVariant: darkOnSurfaceVariant,
        outline: darkOutline,
        surfaceContainer: darkSurfaceCard, // card, chips
        surfaceContainerHighest: darkSurfaceContainer, // input, sheet
        error: AppColors.danger,
      ),

      textTheme: _buildTextTheme(
        darkOnSurface,
        darkOnSurfaceVariant,
        AppColors.primary,
      ),

      cardTheme: _buildCardTheme(darkSurfaceCard, darkOnSurface),

      inputDecorationTheme: _buildInputTheme(
        darkSurfaceContainer,
        darkOutline,
        AppColors.primary,
        AppColors.danger,
        darkOnSurfaceVariant,
      ),
    );
  }

  // ─── Shared builders ───────────────────────────────────────────────────────

  static TextTheme _buildTextTheme(
    Color onSurface,
    Color onSurfaceVariant,
    Color primaryDark,
  ) {
    return TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 57.sp,
        fontWeight: FontWeight.bold,
        color: primaryDark,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45.sp,
        fontWeight: FontWeight.bold,
        color: primaryDark,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        color: primaryDark,
      ),

      headlineLarge: GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),

      titleLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color: onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),

      bodyLarge: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: onSurface,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariant,
      ),

      labelLarge: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: onSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: onSurfaceVariant,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: onSurfaceVariant,
      ),
    );
  }

  static CardThemeData _buildCardTheme(Color cardColor, Color onSurface) {
    return CardThemeData(
      color: cardColor,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shadowColor: Colors.black.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: onSurface.withValues(alpha: 0.08), width: 1),
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme(
    Color fillColor,
    Color outline,
    Color primary,
    Color error,
    Color onSurfaceVariant,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      hintStyle: GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: onSurfaceVariant,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: outline.withValues(alpha: 0.3),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: error, width: 1.5),
      ),
    );
  }
}
