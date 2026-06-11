import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Responsive breakpoint names
const String mobile = 'MOBILE';
const String tablet = 'TABLET';
const String desktop = 'DESKTOP';

/// App color palette.
///
/// Brand/accent and tag colors are constant across themes. The
/// surface / text / border tokens are exposed as dynamic getters that switch
/// between the dark and light palettes based on [isDark]. Widgets reference
/// these getters (e.g. `AppColors.background`) so a single flag flip repaints
/// the whole app.
class AppColors {
  /// Drives the dynamic tokens below. Toggled via AppState.toggleTheme().
  static bool isDark = true;

  // ── Brand / accent — restrained, intentional palette (same in both themes) ──
  // Indigo is the single hero color: primary actions, links, active states.
  // (Token kept named `amber` for backwards-compatibility across the codebase.)
  static const Color amber = Color(0xFF5E5CE6); // PRIMARY (indigo)
  static const Color amberLight = Color(0xFFC4C2FA);
  static const Color amberDark = Color(0xFF4A48C2);

  // Only two supporting accents + one quiet variant. Used sparingly and
  // semantically, never decoratively.
  static const Color teal = Color(0xFF15B187); // success · "Going" · opportunities
  static const Color purple = Color(0xFF8B7BF0); // workshops (quiet indigo sibling)
  static const Color coral = Color(0xFFE0A24E); // competitions (the one warm tone)
  static const Color blue = Color(0xFF5E5CE6); // events (= primary indigo)

  // Text / icons placed on top of an accent fill (e.g. primary buttons).
  static const Color onAccent = Color(0xFFFFFFFF);

  // Legacy tag fills — category badges now derive a soft tint from the type
  // color (see EventModel.typeBgColor), so these are kept only for compat.
  static const Color tagEvent = Color(0xFF142A4A);
  static const Color tagOpportunity = Color(0xFF143A35);
  static const Color tagWorkshop = Color(0xFF3C2A5A);
  static const Color tagCompetition = Color(0xFF5A2430);

  // --- Dark palette (neutral slate, low saturation) ---
  static const Color _dBackground = Color(0xFF0B0D12);
  static const Color _dSurface = Color(0xFF141720);
  static const Color _dSurfaceElevated = Color(0xFF1B1F2A);
  static const Color _dCard = Color(0xFF161A23);
  static const Color _dTextPrimary = Color(0xFFF3F5FA);
  static const Color _dTextSecondary = Color(0xFFA6ADBE);
  static const Color _dTextMuted = Color(0xFF6B7283);
  static const Color _dBorder = Color(0xFF252A36);
  static const Color _dBorderLight = Color(0xFF333A48);

  // --- Light palette (clean neutral grays) ---
  static const Color _lBackground = Color(0xFFF7F8FA);
  static const Color _lSurface = Color(0xFFFFFFFF);
  static const Color _lSurfaceElevated = Color(0xFFF0F2F6);
  static const Color _lCard = Color(0xFFFFFFFF);
  static const Color _lTextPrimary = Color(0xFF161A23);
  static const Color _lTextSecondary = Color(0xFF5A6172);
  static const Color _lTextMuted = Color(0xFF8B91A1);
  static const Color _lBorder = Color(0xFFE7E9EF);
  static const Color _lBorderLight = Color(0xFFD7DBE3);

  // --- Dynamic tokens (theme-aware) ---
  static Color get background => isDark ? _dBackground : _lBackground;
  static Color get surface => isDark ? _dSurface : _lSurface;
  static Color get surfaceElevated =>
      isDark ? _dSurfaceElevated : _lSurfaceElevated;
  static Color get card => isDark ? _dCard : _lCard;
  static Color get textPrimary => isDark ? _dTextPrimary : _lTextPrimary;
  static Color get textSecondary => isDark ? _dTextSecondary : _lTextSecondary;
  static Color get textMuted => isDark ? _dTextMuted : _lTextMuted;
  static Color get border => isDark ? _dBorder : _lBorder;
  static Color get borderLight => isDark ? _dBorderLight : _lBorderLight;
}

class AppTheme {
  /// Backwards-compatible alias.
  static ThemeData get dark => theme;

  /// Builds the active [ThemeData] from the current [AppColors] palette.
  static ThemeData get theme {
    final isDark = AppColors.isDark;

    final baseTextTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.8,
      ),
      displayMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
      ),
    );

    final colorScheme = isDark
        ? const ColorScheme.dark(
            primary: AppColors.amber,
            onPrimary: AppColors.onAccent,
            secondary: AppColors.teal,
            onSecondary: AppColors.onAccent,
            surface: AppColors._dSurface,
            onSurface: AppColors._dTextPrimary,
          )
        : const ColorScheme.light(
            primary: AppColors.amber,
            onPrimary: AppColors.onAccent,
            secondary: AppColors.teal,
            onSecondary: AppColors.onAccent,
            surface: AppColors._lSurface,
            onSurface: AppColors._lTextPrimary,
          );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      cardColor: AppColors.surfaceElevated,
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceElevated,
      ),
      shadowColor: isDark ? const Color(0xFF020A1F) : const Color(0x1A1E2741),
      splashColor: AppColors.amber.withAlpha(40),
      highlightColor: AppColors.teal.withAlpha(30),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(baseTextTheme),
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
        ),
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 22),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceElevated,
        elevation: 0,
        shadowColor: const Color(0xFF081026),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.amber,
          foregroundColor: AppColors.onAccent,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          elevation: 0,
          shadowColor: const Color(0x44000000),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.amber,
          side: BorderSide(color: AppColors.amber.withAlpha(180), width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.amber,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border.withAlpha(220)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border.withAlpha(220)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.amber, width: 1.5),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.textMuted, fontSize: 15),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceElevated,
        labelStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
        side: BorderSide(color: AppColors.border.withAlpha(120)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.surfaceElevated,
        textStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevated,
        contentTextStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textPrimary,
          fontSize: 14,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.amber.withAlpha(180),
        height: 68,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? AppColors.amber
                : AppColors.textMuted,
            size: 22,
          ),
        ),
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: states.contains(WidgetState.selected)
                ? AppColors.textPrimary
                : AppColors.textMuted,
          ),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
