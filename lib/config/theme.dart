import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Màu sắc cơ bản
  static const Color primaryColor = Color(0xFF4CAF50); // Green
  static const Color primaryColorDark = Color(0xFF388E3C); // Dark Green
  static const Color primaryColorLight = Color(0xFFA5D6A7); // Light Green
  static const Color secondaryColor = Color(0xFFFFC107); // Amber
  static const Color accentColor = Color(0xFF00BFA5); // Teal
  
  // Text colors
  static const Color lightTextColor = Color(0xFFFFFFFF); // White for dark theme
  static const Color darkTextColor = Color(0xFF212121); // Dark Grey for light theme
  static const Color secondaryTextColor = Color(0xFFB3B3B3); // Light grey
  
  // Background colors
  static const Color lightBackgroundColor = Color(0xFFFFFFFF); // White
  static const Color darkBackgroundColor = Color(0xFF121212); // Dark
  static const Color darkCardColor = Color(0xFF1E1E1E); // Slightly lighter dark
  static const Color darkElevatedColor = Color(0xFF2C2C2C); // Elevated surfaces in dark theme
  
  // Common colors
  static const Color errorColor = Color(0xFFF44336); // Red
  static const Color lightGray = Color(0xFFEEEEEE);
  static const Color mediumGray = Color(0xFF9E9E9E);
  static const Color goodDayColor = Color(0xFF66BB6A); // Xanh lá nhạt
  static const Color badDayColor = Color(0xFFEF5350); // Đỏ nhạt
  static const Color neutralDayColor = Color(0xFFFFCA28); // Vàng nhạt
  
  // Các kích thước khoảng cách theo quy ước
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;
  
  // Độ bo tròn
  static const double borderRadiusSmall = 4.0;
  static const double borderRadiusMedium = 8.0;
  static const double borderRadiusLarge = 16.0;
  static const double borderRadiusXLarge = 24.0;

  // Text Styles
  static TextTheme _createTextTheme(TextTheme base, Color textColor) {
    return base.copyWith(
      // Heading
      displayLarge: GoogleFonts.roboto(
        fontSize: 24, 
        fontWeight: FontWeight.bold, 
        color: textColor,
      ),
      // Subheading
      titleLarge: GoogleFonts.roboto(
        fontSize: 18, 
        fontWeight: FontWeight.w500, 
        color: textColor,
      ),
      // Medium titles
      titleMedium: GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      // Body
      bodyMedium: GoogleFonts.roboto(
        fontSize: 14, 
        fontWeight: FontWeight.normal, 
        color: textColor,
      ),
      // Caption
      bodySmall: GoogleFonts.roboto(
        fontSize: 12, 
        fontWeight: FontWeight.w300, 
        color: textColor.withOpacity(0.87),
      ),
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightBackgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        background: lightBackgroundColor,
        onBackground: darkTextColor,
        surface: lightBackgroundColor,
        onSurface: darkTextColor,
      ),
      textTheme: _createTextTheme(base.textTheme, darkTextColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: lightTextColor,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: lightTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          elevation: 1,
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightBackgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: mediumGray,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightGray,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 1.0),
        ),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkBackgroundColor,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        background: darkBackgroundColor,
        onBackground: lightTextColor,
        surface: darkCardColor,
        onSurface: lightTextColor,
      ),
      textTheme: _createTextTheme(base.textTheme, lightTextColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCardColor,
        foregroundColor: lightTextColor,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: lightTextColor,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          elevation: 2,
        ),
      ),
      cardTheme: CardTheme(
        color: darkCardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkCardColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: mediumGray,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkElevatedColor,
        hintStyle: const TextStyle(color: mediumGray),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
          borderSide: const BorderSide(color: primaryColor, width: 1.0),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
    );
  }
  
  // Phương thức tiện ích để lấy màu cho ngày dựa trên đánh giá
  static Color getDayColor(int rating) {
    if (rating >= 4) {
      return goodDayColor;
    } else if (rating <= 2) {
      return badDayColor;
    } else {
      return neutralDayColor;
    }
  }
}
