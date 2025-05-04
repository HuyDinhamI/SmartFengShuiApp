import 'package:flutter/foundation.dart';
import '../models/day_info.dart';
import '../data/sample_day_infos.dart';

class CalendarProvider with ChangeNotifier {
  // Map lưu trữ thông tin ngày theo key là ngày
  Map<String, DayInfo> _dayInfos = {};
  
  // Ngày được chọn hiện tại
  DateTime _selectedDate = DateTime.now();
  
  // Trạng thái đang tải
  bool _isLoading = false;
  
  // Getters
  Map<String, DayInfo> get dayInfos => _dayInfos;
  DateTime get selectedDate => _selectedDate;
  bool get isLoading => _isLoading;
  
  // Constructor
  CalendarProvider() {
    // Khởi tạo dữ liệu từ dữ liệu mẫu
    loadDayInfos();
  }
  
  // Phương thức để tải dữ liệu ngày
  void loadDayInfos() {
    try {
      // Trong phiên bản thực tế, có thể gọi API ở đây
      // Hiện tại chúng ta sử dụng dữ liệu mẫu
      _dayInfos = sampleDayInfos;
      notifyListeners();
    } catch (e) {
      // Xử lý lỗi nếu có
      debugPrint('Lỗi khi tải thông tin ngày: $e');
    }
  }
  
  // Phương thức để tải dữ liệu ngày từ nguồn bên ngoài (API, Firestore, v.v.)
  Future<void> fetchDayInfos() async {
    _setLoading(true);
    
    try {
      // Trong phiên bản thực tế, gọi API hoặc Firestore ở đây
      await Future.delayed(const Duration(seconds: 1)); // Giả lập thời gian tải
      
      // Sử dụng dữ liệu mẫu cho phiên bản mock
      _dayInfos = sampleDayInfos;
      
      notifyListeners();
    } catch (e) {
      debugPrint('Lỗi khi tải thông tin ngày: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  // Phương thức để chọn ngày
  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
  
  // Phương thức để lấy thông tin của một ngày cụ thể
  DayInfo? getDayInfo(DateTime date) {
    final String key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _dayInfos[key];
  }
  
  // Phương thức để kiểm tra xem một ngày có thông tin không
  bool hasDayInfo(DateTime date) {
    return getDayInfo(date) != null;
  }
  
  // Phương thức để kiểm tra ngày tốt
  bool isGoodDay(DateTime date) {
    final DayInfo? info = getDayInfo(date);
    return info != null && (info.isGoodDay || info.dayRating >= 4);
  }
  
  // Phương thức để kiểm tra ngày xấu
  bool isBadDay(DateTime date) {
    final DayInfo? info = getDayInfo(date);
    return info != null && (!info.isGoodDay || info.dayRating <= 2);
  }
  
  // Phương thức để kiểm tra ngày trung bình
  bool isNeutralDay(DateTime date) {
    final DayInfo? info = getDayInfo(date);
    return info != null && info.dayRating == 3;
  }
  
  // Phương thức để lấy danh sách ngày tốt trong một tháng
  List<DateTime> getGoodDaysInMonth(int year, int month) {
    final List<DateTime> goodDays = [];
    
    _dayInfos.forEach((key, info) {
      if (info.date.year == year && info.date.month == month && info.isGoodDay) {
        goodDays.add(info.date);
      }
    });
    
    return goodDays;
  }
  
  // Phương thức để lấy danh sách ngày xấu trong một tháng
  List<DateTime> getBadDaysInMonth(int year, int month) {
    final List<DateTime> badDays = [];
    
    _dayInfos.forEach((key, info) {
      if (info.date.year == year && info.date.month == month && !info.isGoodDay) {
        badDays.add(info.date);
      }
    });
    
    return badDays;
  }
  
  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
