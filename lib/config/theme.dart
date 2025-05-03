import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Màu sắc theo quy ước trong .clinerules
  static const Color primaryColor = Color(0xFF4CAF50); // Green
  static const Color secondaryColor = Color(0xFFFFC107); // Amber
  static const Color backgroundColor = Color(0xFFFFFFFF); // White
  static const Color textColor = Color(0xFF212121); // Dark Grey
  static const Color errorColor = Color(0xFFF44336); // Red
  
  // Màu sắc bổ sung
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

  // Thiết lập theme cho ứng dụng
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        error: errorColor,
        background: backgroundColor,
        onBackground: textColor,
      ),
      textTheme: TextTheme(
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
          color: textColor,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
        ),
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: mediumGray,
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
