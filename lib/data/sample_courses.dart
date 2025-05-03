import '../models/course.dart';

final List<Course> sampleCourses = [
  Course(
    id: '1',
    title: 'Nhập môn phong thủy',
    imageUrl: 'assets/images/course1.jpg',
    description: 'Khóa học cơ bản dành cho người mới bắt đầu tìm hiểu về phong thủy. Bạn sẽ học được các nguyên lý cơ bản về âm dương, ngũ hành và cách áp dụng vào cuộc sống hàng ngày.',
    price: 299000,
    rating: 4.5,
    duration: '4 tuần',
    lessons: [
      'Bài 1: Lịch sử và khái niệm cơ bản về phong thủy',
      'Bài 2: Nguyên lý âm dương trong phong thủy',
      'Bài 3: Học thuyết ngũ hành và các ứng dụng',
      'Bài 4: Bát quái và ý nghĩa',
      'Bài 5: Phong thủy nhà ở cơ bản',
      'Bài 6: Cách xác định hướng tốt xấu',
      'Bài 7: Phong thủy và sức khỏe',
      'Bài 8: Ứng dụng phong thủy trong cuộc sống hiện đại',
    ],
  ),
  Course(
    id: '2',
    title: 'Phong thủy nhà ở',
    imageUrl: 'assets/images/course2.jpg',
    description: 'Khóa học chuyên sâu về cách bố trí và thiết kế nhà ở theo phong thủy. Bạn sẽ học được cách xác định hướng tốt, cách bố trí các phòng và cách khắc phục các khuyết điểm trong nhà.',
    price: 399000,
    rating: 4.8,
    duration: '5 tuần',
    lessons: [
      'Bài 1: Các nguyên tắc phong thủy trong nhà ở',
      'Bài 2: Xác định hướng nhà và mệnh chủ nhà',
      'Bài 3: Phong thủy phòng khách',
      'Bài 4: Phong thủy phòng ngủ',
      'Bài 5: Phong thủy phòng bếp và nhà vệ sinh',
      'Bài 6: Phong thủy phòng làm việc tại nhà',
      'Bài 7: Cách khắc phục các khuyết điểm phong thủy',
      'Bài 8: Màu sắc và vật phẩm phong thủy',
      'Bài 9: Cây cối và phong thủy',
      'Bài 10: Thiết kế nhà ở hợp phong thủy',
    ],
  ),
  Course(
    id: '3',
    title: 'Phong thủy kinh doanh',
    imageUrl: 'assets/images/course3.jpg',
    description: 'Khóa học dành cho những người làm kinh doanh muốn ứng dụng phong thủy để thu hút tài lộc và phát triển sự nghiệp. Bạn sẽ học được cách chọn địa điểm, bố trí văn phòng và áp dụng các nguyên tắc phong thủy vào hoạt động kinh doanh.',
    price: 499000,
    rating: 4.7,
    duration: '6 tuần',
    lessons: [
      'Bài 1: Phong thủy và sự thành công trong kinh doanh',
      'Bài 2: Chọn địa điểm kinh doanh hợp phong thủy',
      'Bài 3: Thiết kế và bố trí văn phòng',
      'Bài 4: Vị trí ngồi và hướng bàn làm việc',
      'Bài 5: Màu sắc và vật phẩm phong thủy trong kinh doanh',
      'Bài 6: Phong thủy cho cửa hàng bán lẻ',
      'Bài 7: Phong thủy cho nhà hàng và dịch vụ',
      'Bài 8: Chọn logo và thương hiệu hợp phong thủy',
      'Bài 9: Thời điểm tốt để khai trương và ký hợp đồng',
      'Bài 10: Phong thủy và chiến lược phát triển doanh nghiệp',
      'Bài 11: Các trường hợp nghiên cứu thực tế',
      'Bài 12: Giải đáp và tư vấn',
    ],
  ),
  Course(
    id: '4',
    title: 'Tứ trụ mệnh lý',
    imageUrl: 'assets/images/course4.jpg',
    description: 'Khóa học chuyên sâu về Tứ trụ (Tứ Trụ Mệnh Lý) - một phương pháp phân tích vận mệnh dựa trên thời gian sinh. Bạn sẽ học được cách tính và phân tích tứ trụ để hiểu về các đặc điểm cá nhân, vận mệnh và cách cải thiện cuộc sống.',
    price: 599000,
    rating: 4.9,
    duration: '8 tuần',
    lessons: [
      'Bài 1: Giới thiệu về Tứ trụ mệnh lý',
      'Bài 2: Âm lịch và cách tính Can Chi',
      'Bài 3: Cách lập Tứ trụ',
      'Bài 4: Ngũ hành trong Tứ trụ',
      'Bài 5: Thiên can và Địa chi',
      'Bài 6: Mệnh, Thân và Quan hệ',
      'Bài 7: Phân tích Thần sát',
      'Bài 8: Đại vận và Lưu niên',
      'Bài 9: Phương pháp đoán mệnh',
      'Bài 10: Sự nghiệp và tài chính',
      'Bài 11: Tình duyên và hôn nhân',
      'Bài 12: Sức khỏe và tuổi thọ',
      'Bài 13: Cách hóa giải vận hạn',
      'Bài 14: Thực hành phân tích Tứ trụ',
      'Bài 15: Tư vấn và ứng dụng',
      'Bài 16: Tổng kết và nâng cao',
    ],
  ),
  Course(
    id: '5',
    title: 'La bàn phong thủy',
    imageUrl: 'assets/images/course5.jpg',
    description: 'Khóa học hướng dẫn cách sử dụng la bàn phong thủy (Lạp bàn) - công cụ quan trọng trong việc đo đạc và xác định hướng trong phong thủy. Bạn sẽ học được cách đọc và sử dụng la bàn một cách chính xác và hiệu quả.',
    price: 349000,
    rating: 4.6,
    duration: '3 tuần',
    lessons: [
      'Bài 1: Giới thiệu về La bàn phong thủy',
      'Bài 2: Cấu tạo và các thành phần của La bàn',
      'Bài 3: Cách đọc La bàn',
      'Bài 4: Phương pháp đo đạc hướng nhà',
      'Bài 5: Xác định sơn hướng và thủy khẩu',
      'Bài 6: Ứng dụng La bàn trong việc tìm huyệt đạo',
      'Bài 7: Thực hành sử dụng La bàn',
      'Bài 8: Các lỗi thường gặp và cách khắc phục',
      'Bài 9: Tích hợp La bàn với các phương pháp phong thủy khác',
    ],
  ),
];

// Hàm lấy khóa học theo ID
Course? getCourseById(String id) {
  try {
    return sampleCourses.firstWhere((course) => course.id == id);
  } catch (e) {
    return null;
  }
}

// Hàm lọc khóa học theo khoảng giá
List<Course> getCoursesByPriceRange(double minPrice, double maxPrice) {
  return sampleCourses
      .where((course) => course.price >= minPrice && course.price <= maxPrice)
      .toList();
}

// Hàm tìm kiếm khóa học theo từ khóa
List<Course> searchCourses(String keyword) {
  final String lowercaseKeyword = keyword.toLowerCase();
  return sampleCourses
      .where((course) =>
          course.title.toLowerCase().contains(lowercaseKeyword) ||
          course.description.toLowerCase().contains(lowercaseKeyword))
      .toList();
}
