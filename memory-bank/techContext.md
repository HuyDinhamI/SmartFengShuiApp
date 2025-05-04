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
  - Hỗ trợ tốt cho dark mode và giao diện hiện đại

### Firebase
- **Firebase Authentication**: Xác thực người dùng
- **Cloud Firestore**: Cơ sở dữ liệu NoSQL thời gian thực
- **Cloud Storage**: Lưu trữ hình ảnh và file
- **Cloud Messaging**: Gửi thông báo đẩy
- **Crashlytics**: Theo dõi và báo cáo lỗi
- **Analytics**: Phân tích hành vi người dùng
- **Lý do lựa chọn**:
  - Giải pháp backend-as-a-service đầy đủ tính năng
  - Dễ tích hợp với Flutter
  - Khả năng mở rộng tốt
  - Gói miễn phí rộng rãi phù hợp cho giai đoạn đầu
  - Phù hợp để phát hành trên CH Play

## Thư viện và Dependencies

### Xác thực và Firebase
- **firebase_core**: ^2.15.0
  - Khởi tạo và cấu hình Firebase
  - Cốt lõi cho mọi dịch vụ Firebase khác

- **firebase_auth**: ^4.7.2
  - Xác thực người dùng (email/password, phone, Google, Facebook)
  - Quản lý trạng thái đăng nhập/đăng xuất

- **cloud_firestore**: ^4.8.4
  - Cơ sở dữ liệu NoSQL
  - Lưu trữ và đồng bộ dữ liệu người dùng

- **firebase_storage**: ^11.2.5
  - Lưu trữ file và hình ảnh
  - Upload/download tài nguyên

- **firebase_messaging**: ^14.6.5
  - Gửi và nhận thông báo đẩy
  - Quản lý token thông báo

- **google_sign_in**: ^6.1.4
  - Đăng nhập bằng tài khoản Google
  - Tích hợp với Firebase Auth

- **flutter_facebook_auth**: ^5.0.11
  - Đăng nhập bằng tài khoản Facebook
  - Tích hợp với Firebase Auth

### Quản lý State
- **provider**: ^6.0.5
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

- **flutter_chat_ui**: ^1.6.9
  - UI cho màn hình chat
  - Hỗ trợ hiển thị tin nhắn, bubble chat, input field

- **image_picker**: ^1.0.2
  - Chọn ảnh từ thư viện và camera
  - Sử dụng cho tính năng AR/VR và upload ảnh phòng

- **carousel_slider**: ^4.2.1
  - Hiển thị tin tức dạng carousel
  - Hỗ trợ tự động chuyển slide

- **flutter_staggered_grid_view**: ^0.7.0
  - Layout grid linh hoạt
  - Hiển thị các tiện ích trên màn hình chính

### Storage và Cache
- **shared_preferences**: ^2.2.0
  - Lưu trữ dữ liệu đơn giản dạng key-value
  - Lưu trữ cài đặt người dùng và dữ liệu nhỏ

- **flutter_secure_storage**: ^8.0.0
  - Lưu trữ dữ liệu nhạy cảm một cách an toàn
  - Mã hóa token và thông tin đăng nhập

- **hive**: ^2.2.3
  - Cơ sở dữ liệu NoSQL local
  - Lưu trữ dữ liệu có cấu trúc khi offline
  - Hiệu suất cao và đơn giản để sử dụng

### Utilities
- **intl**: ^0.18.0
  - Định dạng ngày tháng, số, tiền tệ
  - Hỗ trợ đa ngôn ngữ và khu vực

- **http**: ^1.1.0
  - Thực hiện HTTP request
  - Gọi API cho chatbot và sinh ảnh

- **path_provider**: ^2.1.1
  - Truy cập thư mục của ứng dụng
  - Lưu trữ file cục bộ

- **permission_handler**: ^11.0.0
  - Quản lý và yêu cầu quyền hạn
  - Cần thiết cho các tính năng camera, gallery, notification

- **connectivity_plus**: ^4.0.2
  - Kiểm tra trạng thái kết nối mạng
  - Xử lý chế độ offline

- **uuid**: ^3.0.7
  - Tạo ID duy nhất
  - Sử dụng cho các entity mới

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

- **shimmer**: ^3.0.0
  - Hiệu ứng loading skeleton
  - Cải thiện UX khi đợi dữ liệu tải

- **lottie**: ^2.6.0
  - Hiển thị animation Adobe After Effects
  - Sử dụng cho splash screen và các hiệu ứng đặc biệt

- **flutter_native_splash**: ^2.3.2
  - Cấu hình splash screen native
  - Cải thiện trải nghiệm khởi động ứng dụng

- **fluttertoast**: ^8.2.2
  - Hiển thị thông báo toast
  - Phản hồi nhanh cho người dùng

## Cấu trúc dự án mở rộng

```
smartfengshui/
├── android/          # Cấu hình Android native
├── ios/              # Cấu hình iOS native
├── assets/
│   ├── images/       # Hình ảnh, icons
│   ├── lottie/       # Animation files
│   └── fonts/        # Fonts custom (nếu có)
├── lib/
│   ├── main.dart     # Điểm khởi đầu của ứng dụng
│   ├── config/       # Cấu hình app
│   │   ├── theme.dart        # Theme (dark mode)
│   │   ├── routes.dart       # App routes
│   │   ├── constants.dart    # App constants
│   │   └── firebase_options.dart # Firebase options
│   ├── models/       # Data models
│   │   ├── user.dart        # User model
│   │   ├── day_info.dart    # DayInfo model
│   │   ├── course.dart      # Course model
│   │   ├── chat_message.dart # ChatMessage model
│   │   ├── notification.dart # Notification model
│   │   └── generated_image.dart # GeneratedImage model
│   ├── screens/      # Các màn hình chính
│   │   ├── auth/             # Màn hình xác thực
│   │   ├── home/             # Màn hình chính và điều hướng
│   │   ├── calendar/         # Xem ngày
│   │   ├── chat/             # Chatbot
│   │   ├── image_generation/ # Sinh ảnh
│   │   ├── products/         # Vật phẩm phong thủy
│   │   ├── profile/          # Hồ sơ người dùng
│   │   └── ar_vr/            # Tính năng AR/VR
│   ├── widgets/      # Widgets tái sử dụng
│   │   ├── common/           # Widget dùng chung
│   │   ├── auth/             # Widget cho auth
│   │   ├── chat/             # Widget cho chat
│   │   └── calendar/         # Widget cho calendar
│   ├── providers/    # State management
│   │   ├── auth_provider.dart     # Quản lý xác thực
│   │   ├── calendar_provider.dart # Quản lý dữ liệu ngày
│   │   ├── chat_provider.dart     # Quản lý chat
│   │   └── ...
│   ├── services/     # Services & API clients
│   │   ├── firebase_service.dart  # Firebase service
│   │   ├── chat_service.dart      # Chat API service
│   │   ├── image_service.dart     # Image API service
│   │   └── ...
│   ├── repositories/ # Lớp truy xuất dữ liệu
│   │   ├── user_repository.dart
│   │   ├── calendar_repository.dart
│   │   ├── chat_repository.dart
│   │   └── ...
│   ├── data/         # Dữ liệu mẫu
│   └── utils/        # Tiện ích, helpers
│       ├── validators.dart   # Kiểm tra đầu vào
│       ├── date_util.dart    # Tiện ích ngày tháng
│       ├── storage_util.dart # Tiện ích lưu trữ
│       └── network_util.dart # Tiện ích network
├── test/            # Unit và widget tests
└── firebase.json    # Cấu hình Firebase
```

## Yêu cầu phát triển

### Môi trường phát triển
- **Flutter SDK**: Cài đặt Flutter SDK mới nhất
- **IDE**: VS Code hoặc Android Studio với Flutter/Dart plugins
- **Firebase CLI**: Cài đặt để quản lý Firebase
- **Emulators**: Android Emulator hoặc iOS Simulator
- **Git**: Quản lý phiên bản

### Yêu cầu thiết bị
- **Android**: SDK 21+ (Android 5.0 Lollipop)
- **iOS**: iOS 11.0+
- **RAM**: 2GB+ (khuyến nghị)
- **Dung lượng**: ~100MB cho ứng dụng cơ bản, ~150MB với tất cả tính năng

## Chiến lược kiểm thử
- **Unit tests**: Kiểm thử logic nghiệp vụ, services và repositories
- **Widget tests**: Kiểm thử UI components riêng lẻ
- **Integration tests**: Kiểm thử luồng chức năng hoàn chỉnh
- **Manual testing**: Kiểm thử UX và tương tác người dùng
- **Firebase Test Lab**: Kiểm thử trên nhiều thiết bị thực
- **Alpha/Beta testing**: Thông qua Google Play Console

## Chiến lược phát triển và triển khai
- **CI/CD**: Sử dụng GitHub Actions hoặc Codemagic
- **Feature Flags**: Triển khai tính năng mới dần dần
- **Semantic Versioning**: Quản lý phiên bản ứng dụng
- **Release Channels**: Alpha, Beta, Production
- **Crash Reporting**: Firebase Crashlytics
- **Analytics**: Firebase Analytics để theo dõi hành vi người dùng

## Giới hạn kỹ thuật
- Sử dụng mock data cho chatbot và sinh ảnh trong giai đoạn đầu phát triển
- Tính năng AR/VR sẽ được triển khai ở dạng UI, chức năng thực sẽ được phát triển sau
- Demo chức năng thanh toán trong app, chưa tích hợp thanh toán thật
- Firebase dự kiến sẽ sử dụng gói Spark (miễn phí) cho giai đoạn đầu
