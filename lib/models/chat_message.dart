class ChatMessage {
  final String id;
  final String content;
  final bool isBot;
  final DateTime timestamp;
  final bool error;
  final String? imageUrl;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isBot,
    required this.timestamp,
    this.error = false,
    this.imageUrl,
  });

  // Tạo từ map (Firestore)
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      isBot: map['isBot'] ?? false,
      timestamp: map['timestamp'] != null 
        ? (map['timestamp'] as Timestamp).toDate() 
        : DateTime.now(),
      error: map['error'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }

  // Chuyển thành map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isBot': isBot,
      'timestamp': timestamp,
      'error': error,
      'imageUrl': imageUrl,
    };
  }
}

// Định nghĩa một Timestamp mock đơn giản để không bị lỗi khi chưa có Firebase
class Timestamp {
  final int seconds;
  final int nanoseconds;
  
  Timestamp(this.seconds, this.nanoseconds);
  
  DateTime toDate() {
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
  
  static Timestamp fromDate(DateTime date) {
    return Timestamp(date.millisecondsSinceEpoch ~/ 1000, 0);
  }
}
