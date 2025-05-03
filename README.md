# SmartFengShui

Ứng dụng phong thủy đa nền tảng được phát triển bằng Flutter, cung cấp các chức năng xem ngày tốt/xấu và khóa học phong thủy.

```
******************************************************************************
*                                                                            *
*                            SMART FENG SHUI                                 *
*                                                                            *
*                   Ứng dụng xem ngày và học phong thủy                      *
*                                                                            *
******************************************************************************
```

## Mục lục
- [Giới thiệu](#giới-thiệu)
- [Chức năng](#chức-năng)
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Cài đặt](#cài-đặt)
- [Chạy ứng dụng](#chạy-ứng-dụng)
- [Cấu trúc dự án](#cấu-trúc-dự-án)
- [Công nghệ và thư viện](#công-nghệ-và-thư-viện)

## Giới thiệu

SmartFengShui là ứng dụng di động giúp người dùng tra cứu thông tin phong thủy hàng ngày và học các khóa học phong thủy. Ứng dụng được phát triển bằng Flutter, cho phép chạy trên nhiều nền tảng khác nhau từ cùng một codebase.

## Chức năng

### Giao diện chính
- Màn hình chủ với hai nút điều hướng lớn, trực quan
- Điều hướng đơn giản giữa các chức năng chính
- Thiết kế thân thiện với người dùng mới

### Xem ngày
- Lịch âm dương tích hợp
- Đánh dấu ngày tốt/xấu bằng màu sắc trực quan
- Thông tin chi tiết về các việc nên làm/tránh trong ngày
- Hướng tốt và màu may mắn theo ngày

### Khóa học phong thủy
- Danh sách khóa học phong thủy với tìm kiếm
- Thông tin chi tiết của từng khóa học và nội dung học
- Mô phỏng chức năng đăng ký khóa học

## Yêu cầu hệ thống

### Để phát triển
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (phiên bản 3.0.0 trở lên)
- [Android Studio](https://developer.android.com/studio) (để phát triển cho Android)
- [Xcode](https://developer.apple.com/xcode/) (để phát triển cho iOS, chỉ khả dụng trên macOS)
- [Git](https://git-scm.com/)

### Để chạy ứng dụng
- **Android**: Android 5.0 (API level 21) trở lên
- **iOS**: iOS 11.0 trở lên
- **Web**: Bất kỳ trình duyệt web hiện đại nào
- **Desktop**: Windows 10+, macOS 10.15+, hoặc Linux với Gtk+ 3

## Cài đặt

### Bước 1: Cài đặt Flutter SDK
Làm theo hướng dẫn tại [trang chủ Flutter](https://flutter.dev/docs/get-started/install) để cài đặt Flutter SDK cho hệ điều hành của bạn.

### Bước 2: Kiểm tra cài đặt Flutter
```bash
flutter doctor
```

Đảm bảo không có lỗi nghiêm trọng nào được báo cáo.

### Bước 3: Clone repository
```bash
git clone https://github.com/yourusername/smart_feng_shui.git
cd smart_feng_shui
```

### Bước 4: Cài đặt dependencies
```bash
flutter pub get
```

## Chạy ứng dụng

### Chạy trên thiết bị Android
```bash
# Kết nối thiết bị Android thực hoặc chạy Android Emulator trước
flutter run
```

Để chạy Android Emulator:
```bash
# Liệt kê các máy ảo có sẵn
emulator -list-avds

# Chạy một máy ảo cụ thể
emulator -avd <tên_máy_ảo>
# Ví dụ: emulator -avd Medium_Phone_API_36
```

### Chạy trên iOS Simulator (chỉ khả dụng trên macOS)
```bash
open -a Simulator
flutter run
```

### Chạy trên Web
```bash
flutter run -d chrome
```

### Chạy trên Desktop (Windows/macOS/Linux)
```bash
# Trên Windows
flutter run -d windows

# Trên macOS
flutter run -d macos

# Trên Linux
flutter run -d linux
```

### Xây dựng phiên bản phát hành

#### Android APK
```bash
flutter build apk --release
```
File APK sẽ được tạo tại `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle
```bash
flutter build appbundle
```

#### iOS (chỉ khả dụng trên macOS)
```bash
flutter build ios --release
```

#### Web
```bash
flutter build web
```

#### Desktop (Windows/macOS/Linux)
```bash
# Trên Windows
flutter build windows

# Trên macOS
flutter build macos

# Trên Linux
flutter build linux
```

## Cấu trúc dự án

```
smartfengshui/
├── assets/               # Hình ảnh, fonts và tài nguyên khác
├── lib/                  # Mã nguồn chính
│   ├── config/           # Cấu hình, theme, và constants
│   ├── data/             # Dữ liệu mẫu
│   ├── models/           # Lớp model cho dữ liệu
│   ├── providers/        # Quản lý state (Provider)
│   ├── repositories/     # Truy xuất dữ liệu
│   ├── screens/          # Các màn hình UI
│   ├── utils/            # Tiện ích
│   ├── widgets/          # Widget tái sử dụng
│   └── main.dart         # Điểm khởi đầu ứng dụng
└── test/                 # Unit và widget tests
```

## Công nghệ và thư viện

- **Flutter**: Framework UI đa nền tảng
- **Dart**: Ngôn ngữ lập trình
- **Provider**: Quản lý state
- **table_calendar**: Widget lịch
- **intl**: Định dạng ngày tháng, số
- **shared_preferences**: Lưu trữ cục bộ

## Lưu ý
- Ứng dụng hiện sử dụng dữ liệu mẫu tĩnh
- Chức năng thanh toán và đăng ký khóa học hiện chỉ ở dạng mô phỏng

---

Phát triển bởi [Tên của bạn] © 2025
