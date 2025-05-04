import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

/// Provider quản lý thông tin người dùng và các thao tác liên quan
class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getters
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasUser => _user != null;
  
  // Thiết lập thông tin người dùng sau khi đăng nhập thành công
  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
    
    // Lưu thông tin người dùng vào local storage
    _saveUserToLocalStorage(user);
  }
  
  // Cập nhật thông tin người dùng
  Future<void> updateUserInfo({
    String? name,
    String? phoneNumber,
    String? gender,
    DateTime? birthDate,
    Map<String, dynamic>? customData,
  }) async {
    if (_user == null) return;
    
    _setLoading(true);
    
    try {
      // Tạo bản sao với thông tin mới
      final updatedUser = _user!.copyWith(
        name: name,
        phoneNumber: phoneNumber,
        gender: gender,
        birthDate: birthDate,
        customData: customData,
      );
      
      // Trong phiên bản Firebase thật:
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(_user!.id)
      //     .update(updatedUser.toMap());
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 1));
      
      // Cập nhật user hiện tại
      _user = updatedUser;
      
      // Lưu vào local storage
      _saveUserToLocalStorage(updatedUser);
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Cập nhật ảnh đại diện
  Future<void> updateProfileImage(String imageUrl) async {
    if (_user == null) return;
    
    _setLoading(true);
    
    try {
      // Tạo bản sao với ảnh mới
      final updatedUser = _user!.copyWith(
        imageUrl: imageUrl,
      );
      
      // Trong phiên bản Firebase thật:
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(_user!.id)
      //     .update({'imageUrl': imageUrl});
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 1));
      
      // Cập nhật user hiện tại
      _user = updatedUser;
      
      // Lưu vào local storage
      _saveUserToLocalStorage(updatedUser);
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Xóa thông tin người dùng (khi đăng xuất)
  void clearUser() {
    _user = null;
    notifyListeners();
    
    // Xóa thông tin người dùng từ local storage
    _removeUserFromLocalStorage();
  }
  
  // Tải thông tin người dùng từ local storage khi khởi động app
  Future<void> loadUserFromLocalStorage() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_data');
      
      if (userJson != null) {
        // Trong phiên bản thực, parse JSON thành UserModel
        // _user = UserModel.fromJson(jsonDecode(userJson));
        
        // Mock version:
        // Hiện tại chỉ cần để trống vì cần thiết kế hàm fromJson trước
      }
      
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Lưu thông tin người dùng vào local storage
  Future<void> _saveUserToLocalStorage(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Trong phiên bản thực, lưu JSON representation của user
      // await prefs.setString('user_data', jsonEncode(user.toJson()));
      
      // Mock version:
      await prefs.setString('user_id', user.id);
      await prefs.setString('user_name', user.name);
    } catch (e) {
      debugPrint('Lỗi khi lưu user vào local storage: $e');
    }
  }
  
  // Xóa thông tin người dùng từ local storage
  Future<void> _removeUserFromLocalStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_data');
      await prefs.remove('user_id');
      await prefs.remove('user_name');
    } catch (e) {
      debugPrint('Lỗi khi xóa user từ local storage: $e');
    }
  }
  
  // Phương thức tiện ích
  
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
  
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }
  
  void _clearError() {
    _errorMessage = null;
  }
}
