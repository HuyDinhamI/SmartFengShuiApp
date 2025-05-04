class UserModel {
  final String id;
  final String name;
  String? email;
  String? phoneNumber;
  String? imageUrl;
  String? gender;
  DateTime? birthDate;
  bool isEmailVerified;
  DateTime createdAt;
  DateTime? lastLoginAt;
  Map<String, dynamic>? customData;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.phoneNumber,
    this.imageUrl,
    this.gender,
    this.birthDate,
    this.isEmailVerified = false,
    DateTime? createdAt,
    this.lastLoginAt,
    this.customData,
  }) : createdAt = createdAt ?? DateTime.now();

  // Tạo từ map (Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      imageUrl: map['imageUrl'],
      gender: map['gender'],
      birthDate: map['birthDate'] != null 
        ? (map['birthDate'] as Timestamp).toDate()
        : null,
      isEmailVerified: map['isEmailVerified'] ?? false,
      createdAt: map['createdAt'] != null
        ? (map['createdAt'] as Timestamp).toDate()
        : DateTime.now(),
      lastLoginAt: map['lastLoginAt'] != null
        ? (map['lastLoginAt'] as Timestamp).toDate()
        : null,
      customData: map['customData'],
    );
  }

  // Chuyển thành map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'gender': gender,
      'birthDate': birthDate,
      'isEmailVerified': isEmailVerified,
      'createdAt': createdAt,
      'lastLoginAt': lastLoginAt,
      'customData': customData,
    };
  }

  // Copy with - tạo bản sao UserModel với các thuộc tính cập nhật
  UserModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? imageUrl,
    String? gender,
    DateTime? birthDate,
    bool? isEmailVerified,
    DateTime? lastLoginAt,
    Map<String, dynamic>? customData,
  }) {
    return UserModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      createdAt: this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      customData: customData ?? this.customData,
    );
  }

  // Tạo một UserModel từ FirebaseUser
  static UserModel fromFirebaseUser(
    dynamic firebaseUser, 
    {String? name, String? phoneNumber}
  ) {
    return UserModel(
      id: firebaseUser.uid,
      name: name ?? firebaseUser.displayName ?? 'Người dùng mới',
      email: firebaseUser.email,
      phoneNumber: phoneNumber ?? firebaseUser.phoneNumber,
      imageUrl: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified,
      lastLoginAt: DateTime.now(),
    );
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
