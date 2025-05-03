# Bối cảnh hiện tại SmartFengShui

## Trọng tâm hiện tại

Dự án SmartFengShui đang ở giai đoạn khởi đầu với trọng tâm:

1. **Thiết lập nền tảng**: Tạo cấu trúc dự án Flutter cơ bản và các thành phần core
2. **Phát triển MVP**: Tập trung vào hai chức năng chính là xem ngày và hiển thị khóa học
3. **UI cơ bản**: Xây dựng giao diện người dùng đơn giản, trực quan

## Thay đổi gần đây

Dự án vừa được khởi tạo với các hoạt động:

1. Tạo cấu trúc Memory Bank để lưu trữ thông tin dự án
2. Lập kế hoạch và định nghĩa phạm vi dự án
3. Xác định kiến trúc và công nghệ sử dụng

## Quyết định đang thực hiện

1. **Sử dụng dữ liệu mẫu tĩnh**: Trong giai đoạn đầu, sử dụng dữ liệu mẫu tĩnh để đơn giản hóa việc phát triển
2. **Flutter Provider**: Chọn Provider làm giải pháp quản lý state vì tính đơn giản và hiệu quả
3. **Giao diện đơn giản**: Tập trung vào giao diện đơn giản, dễ sử dụng cho người dùng mới

## Các bước tiếp theo

### Ngay lập tức (1-3 ngày)
1. Khởi tạo dự án Flutter với cấu trúc cơ bản
2. Tạo các model dữ liệu cho DayInfo và Course
3. Cài đặt bộ dữ liệu mẫu

### Ngắn hạn (1 tuần)
1. Xây dựng màn hình chính với bottom navigation
2. Phát triển màn hình lịch với table_calendar
3. Hiển thị thông tin ngày khi chọn một ngày
4. Tạo danh sách khóa học đơn giản

### Trung hạn (2 tuần)
1. Hoàn thiện màn hình chi tiết ngày
2. Xây dựng màn hình chi tiết khóa học
3. Tích hợp navigation và routing
4. Thêm tính năng xem trước bài giảng (demo)

## Các vấn đề cần giải quyết

1. **Dữ liệu phong thủy**: Cần tổ chức và mở rộng dữ liệu mẫu đủ phong phú để demo
2. **Tính chính xác**: Đảm bảo thông tin phong thủy có cơ sở (ngay cả khi là dữ liệu mẫu)
3. **Trải nghiệm người dùng**: Đơn giản hóa việc tra cứu thông tin phong thủy

## Rủi ro và thách thức

1. **Kiến thức phong thủy**: Cần nghiên cứu để đảm bảo ứng dụng cung cấp thông tin có giá trị
2. **Hiệu năng Calendar**: Widget calendar có thể gặp vấn đề hiệu năng khi xử lý nhiều dữ liệu
3. **Testing đa nền tảng**: Đảm bảo ứng dụng hoạt động tốt trên cả iOS và Android

## Câu hỏi cần giải đáp

1. Cách tính toán và xác định ngày tốt/xấu theo phong thủy?
2. Có cần tích hợp thông tin chi tiết về lịch âm lịch?
3. Mức độ chi tiết nào cần thiết cho thông tin ngày?
4. Giá trị mẫu nào phù hợp cho các khóa học phong thủy?
5. Cần xem xét đa ngôn ngữ ngay từ đầu hay để phát triển sau?
