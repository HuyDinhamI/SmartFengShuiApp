class DayInfo {
  final String solarDate; // Ngày dương lịch
  final String lunarDate; // Ngày âm lịch
  final List<String> goodFor; // Việc nên làm
  final List<String> badFor; // Việc nên tránh
  final List<String> luckyDirections; // Hướng tốt
  final List<String> luckyColors; // Màu sắc may mắn
  final int dayRating; // Đánh giá ngày (1-5)

  DayInfo({
    required this.solarDate,
    required this.lunarDate,
    required this.goodFor,
    required this.badFor,
    required this.luckyDirections,
    required this.luckyColors,
    required this.dayRating,
  });

  // Chuyển đổi từ Map để phục vụ cho việc lưu trữ và restore
  factory DayInfo.fromMap(Map<String, dynamic> map) {
    return DayInfo(
      solarDate: map['solarDate'],
      lunarDate: map['lunarDate'],
      goodFor: List<String>.from(map['goodFor']),
      badFor: List<String>.from(map['badFor']),
      luckyDirections: List<String>.from(map['luckyDirections']),
      luckyColors: List<String>.from(map['luckyColors']),
      dayRating: map['dayRating'],
    );
  }

  // Chuyển đổi thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'solarDate': solarDate,
      'lunarDate': lunarDate,
      'goodFor': goodFor,
      'badFor': badFor,
      'luckyDirections': luckyDirections,
      'luckyColors': luckyColors,
      'dayRating': dayRating,
    };
  }

  @override
  String toString() {
    return 'DayInfo{solarDate: $solarDate, lunarDate: $lunarDate, dayRating: $dayRating}';
  }
}
