class DayInfo {
  final DateTime date;       // Ngày dương lịch (DateTime)
  final String solarDate;    // Ngày dương lịch (chuỗi định dạng)
  final String lunarDate;    // Ngày âm lịch
  final String canChi;       // Can chi của ngày
  final String nguHanh;      // Ngũ hành của ngày
  final bool isGoodDay;      // Ngày tốt hay xấu
  final List<String> suitableActivities;    // Việc nên làm
  final List<String> unsuitableActivities;  // Việc nên tránh
  final List<String> luckyDirections;       // Hướng tốt
  final List<String> luckyColors;           // Màu sắc may mắn
  final int dayRating;                      // Đánh giá ngày (1-5)
  final String note;                        // Ghi chú về ngày

  DayInfo({
    required this.date,
    required this.solarDate,
    required this.lunarDate,
    required this.canChi,
    required this.nguHanh,
    required this.isGoodDay,
    required this.suitableActivities,
    required this.unsuitableActivities,
    required this.luckyDirections,
    required this.luckyColors,
    required this.dayRating,
    required this.note,
  });

  // Chuyển đổi từ Map để phục vụ cho việc lưu trữ và restore
  factory DayInfo.fromMap(Map<String, dynamic> map) {
    return DayInfo(
      date: DateTime.parse(map['date']),
      solarDate: map['solarDate'],
      lunarDate: map['lunarDate'],
      canChi: map['canChi'] ?? '',
      nguHanh: map['nguHanh'] ?? '',
      isGoodDay: map['isGoodDay'] ?? (map['dayRating'] >= 3),
      suitableActivities: List<String>.from(map['goodFor'] ?? map['suitableActivities'] ?? []),
      unsuitableActivities: List<String>.from(map['badFor'] ?? map['unsuitableActivities'] ?? []),
      luckyDirections: List<String>.from(map['luckyDirections'] ?? []),
      luckyColors: List<String>.from(map['luckyColors'] ?? []),
      dayRating: map['dayRating'],
      note: map['note'] ?? '',
    );
  }

  // Chuyển đổi thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'solarDate': solarDate,
      'lunarDate': lunarDate,
      'canChi': canChi,
      'nguHanh': nguHanh,
      'isGoodDay': isGoodDay,
      'suitableActivities': suitableActivities,
      'unsuitableActivities': unsuitableActivities,
      'luckyDirections': luckyDirections,
      'luckyColors': luckyColors,
      'dayRating': dayRating,
      'note': note,
    };
  }

  @override
  String toString() {
    return 'DayInfo{date: $date, solarDate: $solarDate, lunarDate: $lunarDate, isGoodDay: $isGoodDay, dayRating: $dayRating}';
  }
}
