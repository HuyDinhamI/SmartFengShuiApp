import 'package:flutter/foundation.dart';
import '../models/user.dart';

// Mock của Firebase Auth User cho việc phát triển offline
class MockFirebaseUser {
  final String uid;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? photoURL;
  final bool emailVerified;

  MockFirebaseUser({
    required this.uid,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoURL,
    this.emailVerified = false,
  });
}

class AuthProvider with ChangeNotifier {
  // Khi đã cài đặt Firebase, sử dụng dòng này
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  
  bool _isInitialized = false;
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  
  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isInitialized => _isInitialized;
  
  AuthProvider() {
    // Khởi tạo và lắng nghe thay đổi auth
    _initAuth();
  }
  
  // Khởi tạo auth listener
  Future<void> _initAuth() async {
    // Trong phiên bản Firebase thật:
    // _auth.authStateChanges().listen((User? firebaseUser) {
    //   if (firebaseUser != null) {
    //     _currentUser = UserModel.fromFirebaseUser(firebaseUser);
    //   } else {
    //     _currentUser = null;
    //   }
    //   _isInitialized = true;
    //   notifyListeners();
    // });
    
    // Mock version (chưa có Firebase)
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
    _currentUser = null; // Bắt đầu với trạng thái chưa đăng nhập
    notifyListeners();
  }
  
  // Đăng nhập bằng email và mật khẩu
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _setLoading(true);
    
    try {
      // Phiên bản Firebase thật:
      // final userCredential = await _auth.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // _currentUser = UserModel.fromFirebaseUser(userCredential.user!);
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 2)); // Giả lập độ trễ network
      if (email == 'test@example.com' && password == 'password') {
        final mockUser = MockFirebaseUser(
          uid: '123456789',
          displayName: 'Người dùng demo',
          email: email,
          emailVerified: true,
          photoURL: null,
        );
        
        _currentUser = UserModel.fromFirebaseUser(mockUser);
      } else {
        throw Exception('Email hoặc mật khẩu không chính xác.');
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Đăng nhập bằng số điện thoại
  Future<void> signInWithPhone(String phone, String verificationCode) async {
    _setLoading(true);
    
    try {
      // Mock version:
      await Future.delayed(const Duration(seconds: 2));
      if (phone == '0123456789' && verificationCode == '123456') {
        final mockUser = MockFirebaseUser(
          uid: '987654321',
          displayName: null,
          phoneNumber: phone,
          emailVerified: false,
          photoURL: null,
        );
        
        _currentUser = UserModel.fromFirebaseUser(
          mockUser,
          name: 'Người dùng SĐT',
        );
      } else {
        throw Exception('Mã xác thực không chính xác');
      }
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Đăng ký tài khoản mới
  Future<void> signUp(String name, String email, String password) async {
    _setLoading(true);
    
    try {
      // Phiên bản Firebase thật:
      // final userCredential = await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // 
      // await userCredential.user?.updateDisplayName(name);
      // _currentUser = UserModel.fromFirebaseUser(userCredential.user!);
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 2));
      final mockUser = MockFirebaseUser(
        uid: '1234567890',
        displayName: name,
        email: email,
        emailVerified: false,
        photoURL: null,
      );
      
      _currentUser = UserModel.fromFirebaseUser(mockUser);
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Đăng xuất
  Future<void> signOut() async {
    _setLoading(true);
    
    try {
      // Phiên bản Firebase thật:
      // await _auth.signOut();
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 1));
      _currentUser = null;
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Gửi email đặt lại mật khẩu
  Future<void> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    
    try {
      // Phiên bản Firebase thật:
      // await _auth.sendPasswordResetEmail(email: email);
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 2));
      
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }
  
  // Lắng nghe SMS OTP để đăng nhập/đăng ký qua số điện thoại
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(UserModel) onVerified,
    Function(String) onError,
  ) async {
    _setLoading(true);
    
    try {
      // Phiên bản Firebase thật:
      // await _auth.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     final userCredential = await _auth.signInWithCredential(credential);
      //     _currentUser = UserModel.fromFirebaseUser(userCredential.user!);
      //     onVerified(_currentUser!);
      //   },
      //   verificationFailed: (FirebaseAuthException e) {
      //     onError(e.message ?? 'Verification failed');
      //   },
      //   codeSent: (String verificationId, int? resendToken) {
      //     onCodeSent(verificationId);
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {},
      // );
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 2));
      
      // Giả lập gửi mã OTP thành công
      onCodeSent('123456');
      
      _clearError();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
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
