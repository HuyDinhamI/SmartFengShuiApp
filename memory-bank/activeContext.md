# Bối cảnh hiện tại SmartFengShui

## Trọng tâm hiện tại

Dự án SmartFengShui đang chuyển sang giai đoạn phát triển mở rộng với trọng tâm:

1. **Thiết kế lại theo dark theme**: Chuyển đổi giao diện sang tông màu tối với điểm nhấn màu xanh lá
2. **Mở rộng chức năng**: Từ 2 tính năng cơ bản mở rộng thành hệ sinh thái đầy đủ với 9+ tính năng
3. **Tích hợp Firebase**: Bổ sung xác thực người dùng và lưu trữ dữ liệu trên cloud
4. **Hướng tới phát hành**: Chuẩn bị cho việc đưa ứng dụng lên Google Play Store

## Thay đổi gần đây

Dự án đang được cập nhật với kế hoạch mở rộng:

1. Cập nhật Memory Bank để phản ánh phạm vi mới của dự án
2. Xác định kiến trúc tích hợp Firebase và API bên ngoài
3. Lên kế hoạch phát triển các tính năng mới (Chatbot, Sinh ảnh, AR/VR, etc.)
4. Thay đổi sang tông màu tối cho giao diện người dùng
5. Sửa lỗi tham chiếu thuộc tính không tồn tại trong CalendarScreen (thay đổi từ goodFor/badFor sang suitableActivities/unsuitableActivities)

## Quyết định đang thực hiện

1. **Sử dụng Firebase**: Chọn Firebase làm backend chính cho xác thực và lưu trữ dữ liệu
2. **Approach kết hợp online-offline**: Kết hợp Firestore với Local Storage để đảm bảo hoạt động tốt cả khi offline
3. **Thiết kế modular**: Tổ chức code theo module chức năng rõ ràng để dễ bảo trì và mở rộng
4. **Mock API**: Trong giai đoạn phát triển, sử dụng mock data cho các tính năng cần API bên ngoài
5. **Dark theme**: Chuyển đổi toàn bộ giao diện sang dark theme cho trải nghiệm người dùng hiện đại
6. **Nhất quán trong đặt tên thuộc tính**: Đảm bảo sự nhất quán giữa model định nghĩa và cách gọi trong UI

## Các bước tiếp theo

### Ngay lập tức (1-3 ngày)
1. Thiết lập Firebase project và tích hợp Firebase Authentication
2. Tạo các màn hình xác thực (đăng nhập, đăng ký, quên mật khẩu)
3. Chuyển đổi theme sang tông màu tối
4. Tạo các model mới (User, ChatMessage, Notification, etc.)
5. Kiểm tra các màn hình khác về vấn đề tương thích với model dữ liệu

### Ngắn hạn (1 tuần)
1. Xây dựng Bottom Navigation Bar với 5 tab chính
2. Phát triển màn hình Hồ sơ người dùng
3. Thiết kế lại màn hình Trang chủ với tin tức và các tiện ích
4. Cập nhật màn hình Xem ngày với thông tin chi tiết hơn
5. Xây dựng màn hình Chatbot với mock data

### Trung hạn (2-3 tuần)
1. Phát triển tính năng Sinh ảnh với mock API response
2. Tạo màn hình Vật phẩm phong thủy
3. Thiết kế giao diện "đang phát triển" cho AR/VR
4. Xây dựng màn hình Thông báo
5. Cập nhật màn hình Khóa học để sử dụng dữ liệu từ Firestore

### Dài hạn (1+ tháng)
1. Tích hợp thực tế với API Python cho Chatbot và Sinh ảnh
2. Phát triển tính năng AR/VR thực tế
3. Tối ưu hóa hiệu suất và UX
4. Chuẩn bị phát hành trên Google Play Store

## Các vấn đề cần giải quyết

1. **Quản lý state phức tạp**: Với nhiều tính năng hơn, cần đảm bảo quản lý state hiệu quả
2. **Tương tác API**: Thiết kế các service tương tác với API một cách linh hoạt và robust
3. **Caching và offline-first**: Triển khai chiến lược caching để hoạt động tốt cả khi offline
4. **Tối ưu hiệu suất**: Đảm bảo ứng dụng hoạt động mượt mà trên nhiều thiết bị
5. **Bảo mật dữ liệu**: Áp dụng các biện pháp bảo mật cho authentication và dữ liệu người dùng
6. **Tính nhất quán trong mô hình dữ liệu**: Đảm bảo các model dữ liệu được thiết kế tốt và sử dụng nhất quán trong toàn bộ ứng dụng

## Rủi ro và thách thức

1. **Firebase quota**: Lưu ý về giới hạn của Firebase trong gói miễn phí
2. **Tích hợp API bên ngoài**: Có thể gặp khó khăn khi tích hợp với API Python trong tương lai
3. **Testing đa nền tảng**: Đảm bảo ứng dụng hoạt động tốt trên nhiều thiết bị Android khác nhau
4. **UX phức tạp**: Thiết kế trải nghiệm người dùng trực quan khi số lượng tính năng tăng lên
5. **Dữ liệu phong thủy**: Đảm bảo cung cấp thông tin phong thủy chính xác và hữu ích
6. **Refactoring code**: Cần thận trọng khi thay đổi cấu trúc model để không gây ra lỗi tham chiếu

## Ưu tiên phát triển

Theo yêu cầu của khách hàng, thứ tự ưu tiên phát triển là:
1. Đăng nhập và hệ thống xác thực
2. Hồ sơ người dùng
3. Xem ngày (nâng cấp từ tính năng hiện có)
4. Chatbot
5. Sinh ảnh
6. Khóa học (nâng cấp từ tính năng hiện có)
7. Tin tức
8. Các tính năng còn lại (AR/VR, Vật phẩm, Thông báo)

## Tiếp cận tích hợp Firebase

1. **Bắt đầu với Authentication**: Thiết lập Firebase Authentication trước để quản lý người dùng
2. **Firestore cho dữ liệu động**: Dữ liệu người dùng, chat, sinh ảnh sẽ lưu trên Firestore
3. **Storage cho tài nguyên media**: Hình ảnh và file sẽ lưu trên Firebase Storage
4. **Caching thông minh**: Kết hợp SharedPreferences và Hive để cache dữ liệu offline
5. **Tiếp cận offline-first**: Ưu tiên dữ liệu local trước, sau đó đồng bộ với cloud

## Câu hỏi tại thời điểm hiện tại

1. Cần những tài nguyên hình ảnh nào cho interfave mới? (logo, icons, splash screen)
2. Tìm và sử dụng các API nào cho ChatBot phong thủy?
3. Khả năng mock API nào cho tính năng sinh ảnh trong giai đoạn phát triển?
4. Có giới hạn về dung lượng ứng dụng khi phát hành không?
5. Chiến lược phân phối ứng dụng trên Google Play (miễn phí, freemium hay có phí)?
