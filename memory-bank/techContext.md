# Bối cảnh kỹ thuật SmartFengShui

## Công nghệ sử dụng

### Flutter
- **Phiên bản**: ^3.10.0
- **Channel**: Stable
- **Ngôn ngữ**: Dart ^3.0.0
- **Mục đích sử dụng**: Framework chính để phát triển ứng dụng đa nền tảng (iOS & Android)
- **Lý do lựa chọn**: 
  - Phát triển tốc độ cao với cùng một codebase cho iOS và Android
  - Widget phong phú và dễ tùy chỉnh
  - Hot reload giúp phát triển nhanh chóng
  - Hiệu năng cao và gần bằng ứng dụng native

## Thư viện và Dependencies

### Quản lý State
- **Provider**: ^6.0.5
  - Giải pháp quản lý state đơn giản
  - Được Flutter team khuyến nghị
  - Dễ học và phù hợp với dự án vừa và nhỏ

### UI Components
- **table_calendar**: ^3.0.9
  - Widget calendar mạnh mẽ, có thể tùy chỉnh
  - Hỗ trợ nhiều loại định dạng và hiển thị calendar
  - Cung cấp các callback cho các sự kiện tương tác

- **flutter_localizations**:
  - Hỗ trợ đa ngôn ngữ
  - Định dạng ngày tháng theo locale Tiếng Việt

### Utilities
- **intl**: ^0.18.0
  - Định dạng ngày tháng, số, tiền tệ
  - Hỗ trợ đa ngôn ngữ và khu vực

- **shared_preferences**: ^2.1.1
  - Lưu trữ dữ liệu đơn giản dạng key-value
  - Lưu trữ cài đặt người dùng và dữ liệu nhỏ

### UI/UX
- **google_fonts**: ^4.0.4
  - Tích hợp Google Fonts vào ứng dụng
  - Cải thiện thẩm mỹ của ứng dụng

- **flutter_svg**: ^2.0.5
  - Hiển thị file SVG
  - Sử dụng cho các biểu tượng và hình ảnh vector

- **cached_network_image**: ^3.2.3
  - Tải và cache hình ảnh từ mạng
  - Tối ưu hiệu suất tải hình ảnh

## Cấu trúc dự án

```
smartfengshui/
├── android/          # Cấu hình Android native
├── ios/              # Cấu hình iOS native
├── assets/
│   ├── images/       # Hình ảnh, icons
│   └── fonts/        # Fonts custom (nếu có)
├── lib/
│   ├── main.dart     # Điểm khởi đầu của ứng dụng
│   ├── config/       # Cấu hình app (theme, routes, constants)
│   ├── models/       # Data models
│   ├── screens/      # Các màn hình chính
│   ├── widgets/      # Widgets tái sử dụng
│   ├── providers/    # State management
│   ├── repositories/ # Lớp truy xuất dữ liệu
│   ├── data/         # Dữ liệu mẫu
│   └── utils/        # Tiện ích, helpers
└── test/             # Unit và widget tests
```

## Yêu cầu phát triển

### Môi trường phát triển
- **Flutter SDK**: Cài đặt Flutter SDK mới nhất
- **IDE**: VS Code hoặc Android Studio với Flutter/Dart plugins
- **Emulators**: Android Emulator hoặc iOS Simulator
- **Git**: Quản lý phiên bản

### Yêu cầu thiết bị
- **Android**: SDK 21+ (Android 5.0 Lollipop)
- **iOS**: iOS 11.0+
- **RAM**: 2GB+ (khuyến nghị)
- **Dung lượng**: ~100MB cho ứng dụng cơ bản

## Chiến lược kiểm thử
- **Unit tests**: Kiểm thử logic nghiệp vụ và providers
- **Widget tests**: Kiểm thử UI components riêng lẻ
- **Integration tests**: Kiểm thử luồng chức năng hoàn chỉnh
- **Manual testing**: Kiểm thử UX và tương tác người dùng

## Giới hạn kỹ thuật
- Sử dụng dữ liệu mẫu tĩnh trong giai đoạn đầu, chưa kết nối API thực
- Demo chức năng thanh toán, chưa tích hợp thanh toán thật
- Tài khoản người dùng đơn giản, chưa có xác thực mạnh
- Chưa tối ưu hóa hoàn toàn cho tất cả thiết bị
