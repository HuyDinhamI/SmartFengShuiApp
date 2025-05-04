# Tài liệu dự án SmartFengShui

## Tổng quan
SmartFengShui là ứng dụng di động Flutter tập trung vào phong thủy với nhiều tính năng toàn diện như xác thực người dùng, xem ngày âm lịch, chatbot, sinh ảnh, AR/VR, vật phẩm phong thủy, khóa học và tin tức. Ứng dụng hướng đến việc cung cấp trải nghiệm phong thủy đa chiều với giao diện hiện đại theo tông màu tối, chuyên nghiệp.

## Mục tiêu
1. Xây dựng ứng dụng phong thủy toàn diện, trực quan và dễ sử dụng
2. Cung cấp thông tin chính xác về ngày tốt/xấu theo phong thủy
3. Tạo nền tảng bán và quản lý khóa học phong thủy
4. Tích hợp công nghệ hiện đại (chatbot, sinh ảnh, AR/VR) vào lĩnh vực phong thủy
5. Phát hành ứng dụng trên Google Play Store

## Yêu cầu chức năng

### Hệ thống xác thực người dùng
- Đăng nhập bằng email/số điện thoại và mật khẩu
- Đăng ký tài khoản mới với thông tin cá nhân
- Quên mật khẩu và đặt lại mật khẩu
- Đăng nhập bằng Google/Facebook
- Tích hợp Firebase Authentication

### Màn hình chính và điều hướng
- Bottom navigation bar với 5 tab chính (Trang chủ, Xem ngày, Nút logo, Chatbot, Tài khoản)
- Trang chủ hiển thị tin tức (carousel) và các tiện ích (grid)
- Giao diện tông màu tối với điểm nhấn màu xanh lá

### Chức năng xem ngày
- Hiển thị lịch với thông tin âm lịch và dương lịch
- Đánh dấu và phân biệt ngày tốt/xấu
- Hiển thị thông tin chi tiết về phong thủy của ngày (việc nên làm/tránh, hướng tốt, giờ hoàng đạo/hắc đạo, màu may mắn)

### Chatbot phong thủy
- Giao diện chat với lịch sử tin nhắn
- Hỏi đáp về các vấn đề phong thủy
- Tích hợp API Python (mock data trong giai đoạn phát triển)

### Tính năng sinh ảnh
- Nhập prompt và negative prompt
- Chọn số lượng ảnh muốn sinh
- Hiển thị kết quả sinh ảnh
- Tích hợp API Python (mock data trong giai đoạn phát triển)

### Tính năng AR/VR (phiên bản phát triển)
- Tải lên ảnh căn phòng
- Lựa chọn vật phẩm phong thủy để thử nghiệm đặt trong phòng
- Giao diện "đang phát triển"

### Vật phẩm phong thủy
- Danh sách vật phẩm phong thủy với thông tin và liên kết
- Tìm kiếm vật phẩm

### Chức năng bán khóa học
- Danh sách khóa học phong thủy với thông tin cơ bản
- Xem chi tiết khóa học (mô tả, nội dung, giá)
- Chức năng đăng ký khóa học (demo)

### Hồ sơ người dùng
- Hiển thị thông tin cá nhân người dùng
- Quản lý thông tin tài khoản
- Chức năng đăng xuất

### Thông báo
- Danh sách thông báo trong ứng dụng
- Đánh dấu đã đọc/chưa đọc
- Badge hiển thị thông báo mới

## Đối tượng người dùng
- Người quan tâm đến phong thủy
- Người muốn tra cứu ngày tốt/xấu cho các hoạt động
- Người muốn học thêm về phong thủy
- Người muốn tư vấn phong thủy qua chatbot
- Những người quan tâm đến thiết kế nội thất theo phong thủy

## Phạm vi dự án
Phiên bản mới sẽ tập trung vào việc phát triển đầy đủ các tính năng với ưu tiên:
1. Đăng nhập và hệ thống xác thực
2. Hồ sơ người dùng
3. Xem ngày (nâng cấp từ tính năng hiện có)
4. Chatbot
5. Sinh ảnh
6. Khóa học (nâng cấp từ tính năng hiện có)
7. Tin tức
8. Các tính năng còn lại

Ứng dụng sẽ sử dụng Firebase làm hệ thống backend chính để quản lý xác thực và dữ liệu người dùng, hướng tới việc phát hành trên Google Play Store.
