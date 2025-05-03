import '../models/day_info.dart';

// Dữ liệu mẫu cho các ngày trong tháng 5/2025
final Map<String, DayInfo> sampleDayInfos = {
  '2025-05-01': DayInfo(
    solarDate: '01/05/2025',
    lunarDate: '04/04/2025 (Âm lịch)',
    goodFor: ['Khai trương', 'Xây dựng', 'Cưới hỏi'],
    badFor: ['Di chuyển', 'Khởi công'],
    luckyDirections: ['Đông', 'Nam'],
    luckyColors: ['Đỏ', 'Vàng'],
    dayRating: 4,
  ),
  '2025-05-02': DayInfo(
    solarDate: '02/05/2025',
    lunarDate: '05/04/2025 (Âm lịch)',
    goodFor: ['Mua bán', 'Ký kết hợp đồng', 'Gặp đối tác'],
    badFor: ['Động thổ', 'Chuyển nhà'],
    luckyDirections: ['Tây', 'Nam'],
    luckyColors: ['Xanh lá', 'Vàng'],
    dayRating: 3,
  ),
  '2025-05-03': DayInfo(
    solarDate: '03/05/2025',
    lunarDate: '06/04/2025 (Âm lịch)',
    goodFor: ['Khai trương', 'Mua xe', 'Làm việc thiện'],
    badFor: ['Xuất hành', 'Cưới hỏi'],
    luckyDirections: ['Bắc', 'Đông Bắc'],
    luckyColors: ['Xanh dương', 'Trắng'],
    dayRating: 5,
  ),
  '2025-05-04': DayInfo(
    solarDate: '04/05/2025',
    lunarDate: '07/04/2025 (Âm lịch)',
    goodFor: ['Xuất hành', 'Giải quyết tranh chấp'],
    badFor: ['Khai trương', 'Cưới hỏi', 'Mua đất'],
    luckyDirections: ['Tây Bắc', 'Tây Nam'],
    luckyColors: ['Nâu', 'Cam'],
    dayRating: 2,
  ),
  '2025-05-05': DayInfo(
    solarDate: '05/05/2025',
    lunarDate: '08/04/2025 (Âm lịch)',
    goodFor: ['Cầu tài lộc', 'Mua nhà', 'Khai trương'],
    badFor: ['Xuất hành', 'Chọn ngày giờ'],
    luckyDirections: ['Đông Nam', 'Nam'],
    luckyColors: ['Vàng', 'Cam'],
    dayRating: 4,
  ),
  '2025-05-06': DayInfo(
    solarDate: '06/05/2025',
    lunarDate: '09/04/2025 (Âm lịch)',
    goodFor: ['Cưới hỏi', 'Mua xe', 'Kí kết'],
    badFor: ['Khởi công', 'Chuyển nhà', 'Đổ trần'],
    luckyDirections: ['Nam', 'Đông Nam'],
    luckyColors: ['Đỏ', 'Hồng'],
    dayRating: 3,
  ),
  '2025-05-07': DayInfo(
    solarDate: '07/05/2025',
    lunarDate: '10/04/2025 (Âm lịch)',
    goodFor: ['Khai trương', 'Nhập trạch', 'Mua vàng'],
    badFor: ['Mua xe', 'Đi xa'],
    luckyDirections: ['Đông', 'Bắc'],
    luckyColors: ['Xanh lá', 'Đen'],
    dayRating: 5,
  ),
  '2025-05-08': DayInfo(
    solarDate: '08/05/2025',
    lunarDate: '11/04/2025 (Âm lịch)',
    goodFor: ['Xây dựng', 'Sửa nhà', 'Mua đất'],
    badFor: ['Cưới hỏi', 'Ma chay'],
    luckyDirections: ['Tây', 'Bắc'],
    luckyColors: ['Trắng', 'Vàng'],
    dayRating: 4,
  ),
  '2025-05-09': DayInfo(
    solarDate: '09/05/2025',
    lunarDate: '12/04/2025 (Âm lịch)',
    goodFor: ['An táng', 'Cưới hỏi', 'Mua nhà'],
    badFor: ['Động thổ', 'Khai trương'],
    luckyDirections: ['Nam', 'Đông'],
    luckyColors: ['Đỏ', 'Cam'],
    dayRating: 3,
  ),
  '2025-05-10': DayInfo(
    solarDate: '10/05/2025',
    lunarDate: '13/04/2025 (Âm lịch)',
    goodFor: ['Khởi công', 'Khai trương'],
    badFor: ['Xây dựng', 'Chuyển nhà', 'Mua xe'],
    luckyDirections: ['Tây Nam', 'Đông Bắc'],
    luckyColors: ['Nâu', 'Đen'],
    dayRating: 1,
  ),
  '2025-05-11': DayInfo(
    solarDate: '11/05/2025',
    lunarDate: '14/04/2025 (Âm lịch)',
    goodFor: ['Gặp đối tác', 'Ký kết'],
    badFor: ['Xuất hành', 'Mua bán', 'Cưới hỏi'],
    luckyDirections: ['Đông', 'Nam'],
    luckyColors: ['Xanh lá', 'Vàng'],
    dayRating: 2,
  ),
  '2025-05-12': DayInfo(
    solarDate: '12/05/2025',
    lunarDate: '15/04/2025 (Âm lịch)',
    goodFor: ['Cưới hỏi', 'Mua nhà', 'Khai trương'],
    badFor: ['Động thổ', 'Xuất hành xa'],
    luckyDirections: ['Nam', 'Đông Nam'],
    luckyColors: ['Đỏ', 'Hồng'],
    dayRating: 5,
  ),
};

// Hàm lấy thông tin ngày từ DateTime
DayInfo? getDayInfo(DateTime date) {
  final String key = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  return sampleDayInfos[key];
}

// Hàm kiểm tra xem ngày có tốt không (rating từ 4-5)
bool isGoodDay(DateTime date) {
  final DayInfo? info = getDayInfo(date);
  return info != null && info.dayRating >= 4;
}

// Hàm kiểm tra xem ngày có xấu không (rating từ 1-2)
bool isBadDay(DateTime date) {
  final DayInfo? info = getDayInfo(date);
  return info != null && info.dayRating <= 2;
}
