import 'package:flutter/foundation.dart';

class GeneratedImage {
  final String id;
  final String prompt;
  final String? negativePrompt;
  final List<String> imageUrls;
  final DateTime createdAt;
  final bool isFavorite;
  final Map<String, dynamic>? metadata;

  GeneratedImage({
    required this.id,
    required this.prompt,
    this.negativePrompt,
    required this.imageUrls,
    required this.createdAt,
    this.isFavorite = false,
    this.metadata,
  });

  // Tạo từ map (Firestore)
  factory GeneratedImage.fromMap(Map<String, dynamic> map) {
    return GeneratedImage(
      id: map['id'] ?? '',
      prompt: map['prompt'] ?? '',
      negativePrompt: map['negativePrompt'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
      createdAt: map['createdAt'] != null 
        ? (map['createdAt'] as Timestamp).toDate() 
        : DateTime.now(),
      isFavorite: map['isFavorite'] ?? false,
      metadata: map['metadata'],
    );
  }

  // Chuyển thành map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prompt': prompt,
      'negativePrompt': negativePrompt,
      'imageUrls': imageUrls,
      'createdAt': createdAt,
      'isFavorite': isFavorite,
      'metadata': metadata,
    };
  }

  // Copy with - tạo bản sao GeneratedImage với các thuộc tính cập nhật
  GeneratedImage copyWith({
    String? prompt,
    String? negativePrompt,
    List<String>? imageUrls,
    bool? isFavorite,
    Map<String, dynamic>? metadata,
  }) {
    return GeneratedImage(
      id: this.id,
      prompt: prompt ?? this.prompt,
      negativePrompt: negativePrompt ?? this.negativePrompt,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
      metadata: metadata ?? this.metadata,
    );
  }
  
  @override
  String toString() {
    return 'GeneratedImage{id: $id, prompt: $prompt, imageCount: ${imageUrls.length}}';
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
