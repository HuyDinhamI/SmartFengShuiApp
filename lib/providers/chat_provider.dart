import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message.dart';

/// Provider quản lý các tin nhắn chatbot và tương tác với API chatbot
class ChatProvider with ChangeNotifier {
  List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isGenerating = false;  // Thêm biến này để theo dõi việc đang sinh tin nhắn
  String? _errorMessage;
  
  // Getters
  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  bool get isGenerating => _isGenerating;  // Thêm getter cho biến isGenerating
  String? get errorMessage => _errorMessage;
  bool get hasMessages => _messages.isNotEmpty;
  
  // Constructor
  ChatProvider() {
    // Tải tin nhắn từ local storage khi khởi tạo
    loadMessages();
  }
  
  // Tải tin nhắn từ local storage
  Future<void> loadMessages() async {
    _setLoading(true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Kiểm tra xem có tin nhắn lưu trữ không
      final messagesJson = prefs.getString('chat_messages');
      
      if (messagesJson != null) {
        final List<dynamic> decoded = jsonDecode(messagesJson);
        
        // Trong phiên bản thực, parse JSON thành ChatMessage
        // _messages = decoded.map((item) => ChatMessage.fromJson(item)).toList();
        
        // Mock version: Tạo một số tin nhắn mẫu
        _messages = _generateSampleMessages();
      } else {
        // Nếu không có tin nhắn nào, tạo tin nhắn chào mừng từ bot
        _messages = [
          ChatMessage(
            id: const Uuid().v4(),
            content: 'Xin chào! Tôi là chatbot phong thủy, tôi có thể giúp gì cho bạn?',
            isBot: true,
            timestamp: DateTime.now(),
          ),
        ];
      }
      
      // Sắp xếp tin nhắn theo thời gian
      _messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Không thể tải tin nhắn: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Gửi tin nhắn mới
  Future<void> sendMessage(String content) async {
    if (content.trim().isEmpty) return;
    
    _setLoading(true);
    _setGenerating(true);  // Cập nhật trạng thái đang sinh tin nhắn
    
    try {
      // Tạo ID cho tin nhắn mới
      final String messageId = const Uuid().v4();
      
      // Thêm tin nhắn người dùng vào danh sách
      final userMessage = ChatMessage(
        id: messageId,
        content: content,
        isBot: false,
        timestamp: DateTime.now(),
      );
      
      _messages.add(userMessage);
      notifyListeners();
      
      // Lưu tin nhắn vào local storage
      _saveMessages();
      
      // Trong phiên bản thật:
      // final response = await _chatService.sendMessage(content);
      
      // Mock version:
      await Future.delayed(const Duration(seconds: 1));
      
      // Generate bot response
      final botMessage = await _generateBotResponse(content);
      
      _messages.add(botMessage);
      notifyListeners();
      
      // Lưu tin nhắn vào local storage
      _saveMessages();
      
      _clearError();
    } catch (e) {
      // Thêm tin nhắn lỗi vào danh sách
      final errorMessage = ChatMessage(
        id: const Uuid().v4(),
        content: 'Xin lỗi, tôi không thể xử lý tin nhắn của bạn lúc này. Vui lòng thử lại sau.',
        isBot: true,
        timestamp: DateTime.now(),
        error: true,
      );
      
      _messages.add(errorMessage);
      _setError('Lỗi khi gửi tin nhắn: ${e.toString()}');
    } finally {
      _setLoading(false);
      _setGenerating(false);  // Cập nhật trạng thái khi kết thúc sinh tin nhắn
    }
  }
  
  // Xóa toàn bộ lịch sử chat
  Future<void> clearChatHistory() async {
    _setLoading(true);
    
    try {
      // Giữ lại tin nhắn chào mừng
      _messages = [
        ChatMessage(
          id: const Uuid().v4(),
          content: 'Xin chào! Tôi là chatbot phong thủy, tôi có thể giúp gì cho bạn?',
          isBot: true,
          timestamp: DateTime.now(),
        ),
      ];
      
      // Lưu tin nhắn vào local storage
      _saveMessages();
      
      _clearError();
      notifyListeners();
    } catch (e) {
      _setError('Không thể xóa lịch sử chat: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }
  
  // Lưu tin nhắn vào local storage
  Future<void> _saveMessages() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Trong phiên bản thực, lưu JSON representation của tin nhắn
      // final encodedMessages = jsonEncode(_messages.map((m) => m.toJson()).toList());
      // await prefs.setString('chat_messages', encodedMessages);
      
      // Mock version: Chỉ đơn giản lưu số lượng tin nhắn
      await prefs.setInt('chat_message_count', _messages.length);
    } catch (e) {
      debugPrint('Lỗi khi lưu tin nhắn vào local storage: $e');
    }
  }
  
  // Mock function để tạo tin nhắn mẫu
  List<ChatMessage> _generateSampleMessages() {
    return [
      ChatMessage(
        id: '1',
        content: 'Xin chào! Tôi là chatbot phong thủy, tôi có thể giúp gì cho bạn?',
        isBot: true,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
      ),
      ChatMessage(
        id: '2',
        content: 'Tôi muốn biết về phong thủy phòng ngủ',
        isBot: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 23)),
      ),
      ChatMessage(
        id: '3',
        content: 'Phòng ngủ nên được thiết kế với một số nguyên tắc phong thủy quan trọng: 1. Giường ngủ nên đặt ở vị trí vững chãi, tránh đặt dưới cửa sổ hoặc đối diện thẳng với cửa. 2. Nên có đầu giường áp vào tường để tạo cảm giác an toàn. 3. Tránh đặt gương đối diện với giường. Bạn muốn biết thêm chi tiết về điểm nào?',
        isBot: true,
        timestamp: DateTime.now().subtract(const Duration(hours: 22, minutes: 55)),
      ),
    ];
  }
  
  // Mock function để sinh phản hồi từ bot
  Future<ChatMessage> _generateBotResponse(String userMessage) async {
    String response = '';
    
    final lowerCaseMsg = userMessage.toLowerCase();
    
    if (lowerCaseMsg.contains('xin chào') || 
        lowerCaseMsg.contains('chào') || 
        lowerCaseMsg.contains('hi') || 
        lowerCaseMsg.contains('hello')) {
      response = 'Xin chào! Rất vui được gặp bạn. Tôi có thể tư vấn cho bạn về phong thủy nhà cửa, ngày tốt xấu, hoặc các vật phẩm phong thủy. Bạn muốn hỏi về chủ đề nào?';
    } 
    else if (lowerCaseMsg.contains('phòng ngủ')) {
      response = 'Phòng ngủ là nơi nghỉ ngơi quan trọng và cần đặc biệt chú ý đến phong thủy:\n\n1. Vị trí giường: Nên đặt giường ở vị trí vững chãi, tránh đối diện thẳng với cửa\n2. Màu sắc: Nên chọn màu nhẹ nhàng như xanh nhạt, hồng pastel, trắng ngà\n3. Gương: Không nên đặt gương đối diện giường ngủ\n4. Ánh sáng: Nên có rèm cửa để điều chỉnh ánh sáng phù hợp\n\nBạn muốn biết thêm về phòng ngủ hoặc các không gian khác không?';
    }
    else if (lowerCaseMsg.contains('phòng khách')) {
      response = 'Phòng khách là nơi đón tiếp khách và tụ họp gia đình, cần lưu ý:\n\n1. Vị trí: Nên ở phía trước nhà, có sự kết nối tốt với cửa chính\n2. Ánh sáng: Nên có nhiều ánh sáng tự nhiên và đèn chiếu sáng tốt\n3. Kích thước: Phòng khách nên rộng rãi, thông thoáng\n4. Sofa: Nên đặt sofa tựa lưng vào tường hoặc có điểm tựa vững chắc\n5. Cây xanh: Nên có vài cây xanh để tăng sinh khí\n\nBạn quan tâm đến yếu tố nào nhất trong phòng khách?';
    }
    else if (lowerCaseMsg.contains('bếp') || lowerCaseMsg.contains('nấu ăn')) {
      response = 'Phong thủy nhà bếp rất quan trọng vì ảnh hưởng đến sức khỏe và tài lộc:\n\n1. Vị trí: Nên ở khu vực đông nam của ngôi nhà\n2. Bếp và nước: Tránh đặt bếp đối diện với vòi nước (lửa-nước xung khắc)\n3. Tủ lạnh: Không nên đặt tủ lạnh gần bếp\n4. Màu sắc: Màu trắng, vàng nhạt, xanh lá là lựa chọn tốt\n5. Sạch sẽ: Bếp luôn phải sạch sẽ, gọn gàng\n\nBạn đang gặp khó khăn với phong thủy nhà bếp?';
    }
    else if (lowerCaseMsg.contains('ngày') && (lowerCaseMsg.contains('tốt') || lowerCaseMsg.contains('xấu'))) {
      response = 'Để xác định ngày tốt xấu, cần dựa vào nhiều yếu tố như âm lịch, tuổi, mục đích công việc. Bạn có thể xem chi tiết ngày tốt xấu trong tính năng Xem ngày của ứng dụng.\n\nBạn muốn biết ngày tốt cho việc gì? (Khai trương, động thổ, cưới hỏi, v.v...)';
    }
    else if (lowerCaseMsg.contains('cây') || lowerCaseMsg.contains('trồng')) {
      response = 'Cây xanh trong phong thủy có thể cải thiện năng lượng và không khí. Một số lựa chọn tốt:\n\n1. Cây kim tiền: Thu hút tài lộc, dễ chăm sóc\n2. Trúc phú quý: Mang lại may mắn, phù hợp nhiều không gian\n3. Cây ngọc bích: Thanh lọc không khí, tăng năng lượng\n4. Sen đá: Phù hợp với những người ít thời gian chăm sóc\n\nNhững cây nên tránh: Cây có gai, xương rồng đặt trong phòng ngủ hoặc phòng làm việc.\n\nBạn đang tìm cây cho không gian nào?';
    }
    else if (lowerCaseMsg.contains('màu') || lowerCaseMsg.contains('sắc')) {
      response = 'Màu sắc trong phong thủy có ý nghĩa riêng:\n\n- Đỏ: Năng lượng, may mắn, hạnh phúc\n- Vàng: Sức khỏe, thịnh vượng\n- Xanh lá: Tăng trưởng, hòa hợp\n- Xanh dương: Bình an, khôn ngoan\n- Tím: Cao quý, tinh thần\n- Trắng: Thuần khiết, rõ ràng\n- Đen: Bảo vệ, quyền lực\n\nViệc chọn màu nên dựa vào mệnh của người ở và mục đích sử dụng không gian.';
    }
    else if (lowerCaseMsg.contains('nguyên tắc') || lowerCaseMsg.contains('cơ bản')) {
      response = 'Các nguyên tắc phong thủy cơ bản bao gồm:\n\n1. Khí: Đảm bảo luồng khí lưu thông tốt, không bị tù đọng hoặc quá mạnh\n2. Cân bằng âm dương: Tạo sự hài hòa giữa các yếu tố đối lập\n3. Ngũ hành: Tạo sự cân bằng giữa Kim, Mộc, Thủy, Hỏa, Thổ\n4. Bát quái: Mỗi hướng có ý nghĩa và năng lượng riêng\n5. Vị trí: Đặt đồ vật ở vị trí đúng để thu hút năng lượng tốt\n6. Màu sắc: Sử dụng màu sắc phù hợp với mệnh và mục đích sử dụng\n\nBạn muốn tìm hiểu sâu hơn về nguyên tắc nào?';
    }
    else {
      response = 'Cảm ơn bạn đã hỏi. Tôi là chatbot phong thủy và có thể tư vấn về nhiều chủ đề:\n\n- Phong thủy nhà ở (phòng khách, phòng ngủ, bếp...)\n- Ngày tốt xấu cho các sự kiện\n- Cây cảnh và vật phẩm phong thủy\n- Màu sắc hợp mệnh\n- Cách khắc phục các vấn đề phong thủy\n\nBạn hãy hỏi cụ thể hơn về chủ đề bạn quan tâm nhé.';
    }
    
    return ChatMessage(
      id: const Uuid().v4(),
      content: response,
      isBot: true,
      timestamp: DateTime.now(),
    );
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
