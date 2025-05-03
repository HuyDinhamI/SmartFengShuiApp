import 'package:flutter/foundation.dart';
import '../models/course.dart';
import '../data/sample_courses.dart';

class CourseProvider with ChangeNotifier {
  // Danh sách tất cả khóa học
  List<Course> _courses = [];
  
  // Khóa học được chọn hiện tại
  Course? _selectedCourse;
  
  // Danh sách khóa học trong giỏ hàng
  List<Course> _cartCourses = [];
  
  // Getters
  List<Course> get courses => _courses;
  Course? get selectedCourse => _selectedCourse;
  List<Course> get cartCourses => _cartCourses;
  
  // Constructor
  CourseProvider() {
    // Khởi tạo dữ liệu từ dữ liệu mẫu
    loadCourses();
  }
  
  // Phương thức để tải dữ liệu khóa học
  void loadCourses() {
    try {
      // Trong phiên bản thực tế, có thể gọi API ở đây
      // Hiện tại chúng ta sử dụng dữ liệu mẫu
      _courses = sampleCourses;
      notifyListeners();
    } catch (e) {
      // Xử lý lỗi nếu có
      debugPrint('Lỗi khi tải danh sách khóa học: $e');
    }
  }
  
  // Phương thức để chọn khóa học
  void selectCourse(String courseId) {
    _selectedCourse = _courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Không tìm thấy khóa học với ID: $courseId'),
    );
    notifyListeners();
  }
  
  // Phương thức để thêm khóa học vào giỏ hàng
  void addToCart(String courseId) {
    // Tìm khóa học với ID tương ứng
    final Course course = _courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Không tìm thấy khóa học với ID: $courseId'),
    );
    
    // Kiểm tra xem khóa học đã có trong giỏ hàng chưa
    if (!_cartCourses.any((item) => item.id == courseId)) {
      _cartCourses.add(course);
      notifyListeners();
    }
  }
  
  // Phương thức để xóa khóa học khỏi giỏ hàng
  void removeFromCart(String courseId) {
    _cartCourses.removeWhere((course) => course.id == courseId);
    notifyListeners();
  }
  
  // Phương thức để tính tổng giá tiền trong giỏ hàng
  double get cartTotal {
    return _cartCourses.fold(0, (sum, course) => sum + course.price);
  }
  
  // Phương thức để mô phỏng thanh toán (trong phiên bản demo)
  Future<bool> checkout() async {
    try {
      // Mô phỏng API gọi thanh toán
      await Future.delayed(const Duration(seconds: 2));
      
      // Xóa giỏ hàng sau khi thanh toán thành công
      _cartCourses.clear();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Lỗi khi thanh toán: $e');
      return false;
    }
  }
  
  // Phương thức để lọc khóa học theo khoảng giá
  List<Course> filterByPriceRange(double min, double max) {
    return _courses.where((course) => course.price >= min && course.price <= max).toList();
  }
  
  // Phương thức để tìm kiếm khóa học theo từ khóa
  List<Course> searchCourses(String keyword) {
    if (keyword.isEmpty) {
      return _courses;
    }
    
    final String lowercaseKeyword = keyword.toLowerCase();
    return _courses.where((course) {
      return course.title.toLowerCase().contains(lowercaseKeyword) || 
             course.description.toLowerCase().contains(lowercaseKeyword);
    }).toList();
  }
}
