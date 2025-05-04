import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themeModeKey = 'theme_mode';
  
  late ThemeMode _themeMode;
  final SharedPreferences _prefs;
  
  ThemeProvider(this._prefs) {
    // Đọc theme mode từ SharedPreferences khi khởi tạo
    _loadThemeMode();
  }
  
  ThemeMode get themeMode => _themeMode;
  
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  
  // Đọc theme mode đã lưu
  void _loadThemeMode() {
    final String? themeModeString = _prefs.getString(_themeModeKey);
    
    if (themeModeString == ThemeMode.light.toString()) {
      _themeMode = ThemeMode.light;
    } else if (themeModeString == ThemeMode.dark.toString()) {
      _themeMode = ThemeMode.dark;
    } else {
      // Mặc định sử dụng dark theme
      _themeMode = ThemeMode.dark;
    }
    
    notifyListeners();
  }
  
  // Cập nhật theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) {
      return;
    }
    
    _themeMode = mode;
    await _prefs.setString(_themeModeKey, mode.toString());
    notifyListeners();
  }
  
  // Toggle giữa light và dark theme
  Future<void> toggleThemeMode() async {
    final ThemeMode newMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    
    await setThemeMode(newMode);
  }
}
