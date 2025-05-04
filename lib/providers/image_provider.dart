import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/generated_image.dart';

/// Provider quản lý việc sinh ảnh phong thủy và lịch sử sinh ảnh
class ImageProvider with ChangeNotifier {
  List<GeneratedImage> _generatedImages = [];
  bool _isLoading = false;
  bool _isGenerating = false;
  String? _errorMessage;
  
  // Getters
  List<GeneratedImage> get generatedImages => List.unmodifiable(_generatedImages);
  bool get isLoading => _isLoading;
  bool get isGenerating => _isGenerating;
  String? get errorMessage => _errorMessage;
  bool get hasImages => _generatedImages.isNotEmpty;
  List<GeneratedImage> get favoriteImages => 
    _generatedImages.where((img) => img.isFavorite).toList();
  
  // Constructor
  ImageProvider() {
    // Tải lịch sử sinh ảnh khi khởi tạo
    loadGeneratedImages();
  }
  
  // Tải lịch sử sinh ảnh từ local storage
  Future<void> loadGeneratedImages() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Kiểm tra xem có lịch sử sinh ảnh không
      final historyJson = prefs.getString('generated_images');
      
      if (historyJson != null) {
        final List<dynamic> decoded = jsonDecode(historyJson);
        
        // Trong phiên bản thực, parse JSON thành GeneratedImage
        // _generatedImages = decoded.map((item) => GeneratedImage.fromJson(item)).toList();
        
        // Mock version: Tạo một số mẫu sinh ảnh
        _generatedImages = _generateSampleImages();
      } else {
        // Nếu không có lịch sử, khởi tạo danh sách rỗng
        _generatedImages = [];
      }
      
      // Sắp xếp ảnh theo thời gian (mới nhất trước)
      _generatedImages.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Không thể tải lịch sử sinh ảnh: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Sinh ảnh mới
  Future<GeneratedImage?> generateImage({
    required String prompt,
    String? negativePrompt,
    int numberOfImages = 1,
  }) async {
    _setGenerating(true);
    
    try {
      // Tạo ID cho ảnh mới
      final String imageId = const Uuid().v4();
      
      // Trong phiên bản thật:
      // final response = await _imageService.generateImage(prompt, negativePrompt, numberOfImages);
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 3)); // Giả lập thời gian sinh ảnh
      
      // Tạo URLs giả cho mock
      final List<String> mockUrls = [];
      for (int i = 0; i < numberOfImages; i++) {
        // URL ảnh placeholder với thông tin về prompt
        final String encodedPrompt = Uri.encodeComponent(prompt.substring(0, prompt.length > 20 ? 20 : prompt.length));
        mockUrls.add('https://via.placeholder.com/512x512.png?text=AI_Image_$i-$encodedPrompt');
      }
      
      // Tạo đối tượng GeneratedImage mới
      final generatedImage = GeneratedImage(
        id: imageId,
        prompt: prompt,
        negativePrompt: negativePrompt,
        imageUrls: mockUrls,
        createdAt: DateTime.now(),
      );
      
      // Thêm vào danh sách
      _generatedImages.insert(0, generatedImage);
      
      // Lưu vào local storage
      _saveGeneratedImages();
      
      _clearError();
      notifyListeners();
      
      return generatedImage;
    } catch (e) {
      _setError('Lỗi khi sinh ảnh: ${e.toString()}');
      return null;
    } finally {
      _setGenerating(false);
    }
  }
  
  // Đánh dấu ảnh yêu thích/bỏ yêu thích
  Future<void> toggleFavorite(String imageId) async {
    final index = _generatedImages.indexWhere((img) => img.id == imageId);
    
    if (index == -1) return;
    
    try {
      // Tạo bản sao với trạng thái yêu thích ngược lại
      final updatedImage = _generatedImages[index].copyWith(
        isFavorite: !_generatedImages[index].isFavorite,
      );
      
      // Thay thế ảnh cũ bằng ảnh mới
      _generatedImages[index] = updatedImage;
      
      // Lưu thay đổi vào local storage
      _saveGeneratedImages();
      
      notifyListeners();
    } catch (e) {
      _setError('Lỗi khi cập nhật trạng thái yêu thích: ${e.toString()}');
    }
  }
  
  // Xóa một ảnh đã sinh
  Future<void> deleteImage(String imageId) async {
    try {
      // Xóa ảnh khỏi danh sách
      _generatedImages.removeWhere((img) => img.id == imageId);
      
      // Lưu thay đổi vào local storage
      _saveGeneratedImages();
      
      notifyListeners();
    } catch (e) {
      _setError('Lỗi khi xóa ảnh: ${e.toString()}');
    }
  }
  
  // Xóa toàn bộ lịch sử sinh ảnh
  Future<void> clearAllImages() async {
    _setLoading(true);
    
    try {
      // Xóa tất cả ảnh
      _generatedImages = [];
      
      // Lưu thay đổi vào local storage
      _saveGeneratedImages();
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Lỗi khi xóa lịch sử sinh ảnh: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Lưu lịch sử sinh ảnh vào local storage
  Future<void> _saveGeneratedImages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Trong phiên bản thực, lưu JSON representation của sinh ảnh
      // final encodedImages = jsonEncode(_generatedImages.map((img) => img.toJson()).toList());
      // await prefs.setString('generated_images', encodedImages);
      
      // Mock version: Chỉ đơn giản lưu số lượng ảnh
      await prefs.setInt('generated_images_count', _generatedImages.length);
    } catch (e) {
      debugPrint('Lỗi khi lưu lịch sử sinh ảnh: $e');
    }
  }
  
  // Mock function để tạo lịch sử sinh ảnh mẫu
  List<GeneratedImage> _generateSampleImages() {
    return [
      GeneratedImage(
        id: '1',
        prompt: 'Phòng khách phong thủy hợp mệnh Mộc',
        negativePrompt: 'tối tăm, lộn xộn, màu sắc chói',
        imageUrls: [
          'https://via.placeholder.com/512x512.png?text=Phong_khach_menh_Moc_1',
          'https://via.placeholder.com/512x512.png?text=Phong_khach_menh_Moc_2',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        isFavorite: true,
      ),
      GeneratedImage(
        id: '2',
        prompt: 'Phòng ngủ phong thủy màu xanh lá',
        negativePrompt: 'tối, lộn xộn, màu đỏ',
        imageUrls: [
          'https://via.placeholder.com/512x512.png?text=Phong_ngu_xanh_la',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        isFavorite: false,
      ),
      GeneratedImage(
        id: '3',
        prompt: 'Thiết kế nhà theo phong thủy hướng Nam',
        negativePrompt: 'tối tăm, màu sẫm, hỗn loạn',
        imageUrls: [
          'https://via.placeholder.com/512x512.png?text=Nha_huong_Nam_1',
          'https://via.placeholder.com/512x512.png?text=Nha_huong_Nam_2',
          'https://via.placeholder.com/512x512.png?text=Nha_huong_Nam_3',
        ],
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        isFavorite: true,
      ),
    ];
  }
  
  // Phương thức tiện ích
  void _setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
  
  void _setGenerating(bool isGenerating) {
    _isGenerating = isGenerating;
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
