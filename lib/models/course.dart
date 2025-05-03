class Course {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final String duration;
  final List<String> lessons;

  Course({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.duration,
    required this.lessons,
  });

  // Chuyển đổi từ Map để phục vụ cho việc lưu trữ và restore
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      price: map['price'].toDouble(),
      rating: map['rating'].toDouble(),
      duration: map['duration'],
      lessons: List<String>.from(map['lessons']),
    );
  }

  // Chuyển đổi thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'duration': duration,
      'lessons': lessons,
    };
  }

  @override
  String toString() {
    return 'Course{id: $id, title: $title, price: $price, rating: $rating}';
  }

  // Định dạng giá thành VND
  String get formattedPrice {
    return '${price.toInt().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} VNĐ';
  }
}
