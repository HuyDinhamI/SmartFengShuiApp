# SmartFengShui

```
******************************************************************************
*                                                                            *
*                            SMART FENG SHUI                                 *
*                                                                            *
*                         Ứng dụng phong thủy                      *
*                                                                            *
******************************************************************************
```

Ứng dụng phong thủy toàn diện được phát triển bằng Flutter với background đẹp mắt, cung cấp nhiều tính năng hữu ích như xem ngày tốt xấu, khóa học phong thủy và các tính năng khác.


## 📑 Mục lục
- [Tổng quan ứng dụng](#tổng-quan-ứng-dụng)
- [Tính năng](#tính-năng)
- [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
- [Hướng dẫn cài đặt](#hướng-dẫn-cài-đặt)
  - [Cài đặt trên Windows](#cài-đặt-trên-windows)
  - [Cài đặt trên Linux](#cài-đặt-trên-linux)
  - [Cài đặt trên macOS](#cài-đặt-trên-macos)
- [Chạy ứng dụng](#chạy-ứng-dụng)
- [Cấu hình VSCode cho Flutter](#cấu-hình-vscode-cho-flutter)
- [Cấu trúc dự án](#cấu-trúc-dự-án)
- [Khắc phục sự cố](#khắc-phục-sự-cố)
- [Công nghệ sử dụng](#công-nghệ-sử-dụng)

## 📱 Tổng quan ứng dụng

SmartFengShui là ứng dụng di động cung cấp thông tin phong thủy và kiến thức về các nguyên tắc phong thủy. Ứng dụng có giao diện đẹp mắt với background thống nhất, giúp người dùng dễ dàng tra cứu ngày tốt/xấu, xem các việc nên làm/tránh theo ngày và tiếp cận các khóa học phong thủy.

Ứng dụng được phát triển bằng Flutter, hoạt động trên đa nền tảng:
- Android
- iOS
- Web
- Desktop (Windows, macOS, Linux)

## ✨ Tính năng

- **Giao diện người dùng hiện đại**
  - Background trang nhã, thống nhất trên toàn bộ ứng dụng
  - Thiết kế thân thiện và trực quan
  - Hỗ trợ dark mode

- **Xem ngày tốt xấu**
  - Lịch âm - dương chi tiết
  - Đánh dấu ngày tốt/xấu bằng màu sắc
  - Thông tin về việc nên làm/nên tránh theo ngày
  - Hướng tốt và màu sắc may mắn
  - Xem chi tiết thông tin từng ngày

- **Khóa học phong thủy**
  - Danh sách khóa học với tìm kiếm
  - Thông tin chi tiết từng khóa học
  - Mô phỏng đăng ký và thanh toán
  
- **Đang phát triển thêm**
  - Hệ thống đăng nhập/đăng ký
  - Chatbot phong thủy
  - Tính năng sinh ảnh phong thủy
  - AR/VR cho bài trí nội thất theo phong thủy

## 🖥️ Yêu cầu hệ thống

### Yêu cầu thiết bị dùng ứng dụng
- **Android**: Android 5.0 (API level 21) trở lên, 2GB RAM
- **iOS**: iOS 11.0 trở lên
- **Web**: Chrome, Firefox, Safari hoặc Edge
- **Desktop**: Windows 10+, macOS 10.15+, hoặc Linux với GTK+ 3

### Yêu cầu phát triển ứng dụng
- **Flutter SDK**: 3.0.0 trở lên
- **Dart**: 2.17.0 trở lên
- **IDE**: Android Studio hoặc Visual Studio Code
- **Git**: Bất kỳ phiên bản gần đây nào
- **Android SDK**: API level 33 (Android 13) trở lên cho phát triển Android
- **Xcode**: 13.0 trở lên cho phát triển iOS (chỉ trên macOS)

## 🔧 Hướng dẫn cài đặt

### Cài đặt trên Windows

#### 1. Cài đặt Flutter SDK
1. Tải [Flutter SDK cho Windows](https://docs.flutter.dev/get-started/install/windows)
2. Giải nén vào thư mục không có khoảng trắng (ví dụ: `C:\dev\flutter`)
3. Thêm đường dẫn Flutter vào biến môi trường PATH:
   - Tìm kiếm "Biến môi trường" trong Start menu
   - Trong System Properties, chọn "Environment Variables"
   - Tìm Path trong biến người dùng, chọn Edit
   - Thêm đường dẫn đến thư mục `flutter\bin` (ví dụ: `C:\dev\flutter\bin`)

#### 2. Cài đặt Android Studio
1. Tải và cài đặt [Android Studio](https://developer.android.com/studio)
2. Mở Android Studio, hoàn tất setup wizard
3. Cài đặt Android SDK thông qua Android Studio:
   - Tools > SDK Manager
   - Chọn Android SDK, Android SDK Platform-Tools và ít nhất một Android SDK Platform
4. Cài đặt Android Emulator:
   - Tools > AVD Manager
   - Create Virtual Device
   - Chọn cấu hình thiết bị và image system (API level 30 hoặc cao hơn được khuyến nghị)

#### 3. Kiểm tra cài đặt
Mở Command Prompt và chạy:
```bat
flutter doctor
```
Giải quyết các vấn đề được báo cáo nếu có.

#### 4. Đường dẫn Emulator cho VSCode
Nếu bạn dùng VSCode với extension Android iOS Emulator, cần thiết lập đường dẫn đến emulator:
1. Tìm vị trí emulator.exe trong thư mục Android SDK:
   - Thường sẽ là: `C:\Users\<username>\AppData\Local\Android\Sdk\emulator\emulator.exe`
2. Trong VSCode:
   - Mở Settings (File > Preferences > Settings)
   - Tìm "android-ios-emulator.android"
   - Điền đường dẫn vào trường "Emulator Path"

### Cài đặt trên Linux

#### 1. Cài đặt Flutter SDK
```bash
# Tải Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Thêm Flutter vào PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

#### 2. Cài đặt các gói phụ thuộc
```bash
sudo apt-get update
sudo apt-get install curl file git unzip xz-utils zip libglu1-mesa

# Cho phép chạy ứng dụng Linux
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

#### 3. Cài đặt Android Studio
1. Tải [Android Studio](https://developer.android.com/studio)
2. Giải nén và chạy script cài đặt:
```bash
cd ~/Downloads
tar -xvf android-studio-*.tar.gz
cd android-studio/bin
./studio.sh
```
3. Cài đặt Android SDK và emulator qua Android Studio

#### 4. Kiểm tra cài đặt
```bash
flutter doctor
```

### Cài đặt trên macOS

#### 1. Cài đặt Flutter SDK
```bash
# Tải Flutter SDK
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable

# Thêm Flutter vào PATH
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

#### 2. Cài đặt Xcode
1. Tải Xcode từ App Store
2. Cài đặt command-line tools:
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

#### 3. Cài đặt Android Studio
Tương tự như trên Windows và Linux, tải từ [trang chủ](https://developer.android.com/studio)

#### 4. Kiểm tra cài đặt
```bash
flutter doctor
```

## ▶️ Chạy ứng dụng

### Clone repository
```bash
git clone <url_to_your_repo>
cd SmartFengShui
```

### Cài đặt dependencies
```bash
flutter pub get
```

### Chạy ứng dụng trên Android
```bash
# Kết nối thiết bị Android thực hoặc chạy emulator trước

# Liệt kê thiết bị kết nối
flutter devices

# Chạy ứng dụng
flutter run
```

### Chạy trên emulator thông qua CLI
```bash
# Windows (CMD)
cd %ANDROID_HOME%\emulator
emulator -list-avds
emulator -avd <tên_thiết_bị>

# Linux/macOS
cd $ANDROID_HOME/emulator
./emulator -list-avds
./emulator -avd <tên_thiết_bị>
```

### Chạy trên các nền tảng khác
```bash
# iOS (chỉ trên macOS)
open -a Simulator
flutter run

# Web
flutter run -d chrome

# Windows
flutter run -d windows

# macOS
flutter run -d macos

# Linux
flutter run -d linux
```

## 🔌 Cấu hình VSCode cho Flutter

### Extensions khuyến nghị
- Flutter
- Dart
- Android iOS Emulator
- Flutter Widget Snippets
- Awesome Flutter Snippets

### Thiết lập Android Emulator trong VSCode
1. Cài đặt extension "Android iOS Emulator"
2. Thiết lập đường dẫn emulator:
   - Mở Settings (Ctrl+,)
   - Tìm "android-ios-emulator.android"
   - Thêm đường dẫn đến emulator.exe:
     - Windows: `C:\Users\<username>\AppData\Local\Android\Sdk\emulator\emulator.exe`
     - Linux: `/home/<username>/Android/Sdk/emulator/emulator`
     - macOS: `/Users/<username>/Library/Android/sdk/emulator/emulator`

3. Sử dụng emulator:
   - Mở Command Palette (Ctrl+Shift+P)
   - Gõ "Android Emulator: Start"
   - Chọn emulator muốn khởi động

## 📁 Cấu trúc dự án

```
smartfengshui/
├── assets/               # Hình ảnh, fonts
│   ├── images/           # Các hình ảnh, bao gồm background.jpg
│   └── fonts/            # Font chữ
├── lib/                  # Mã nguồn
│   ├── config/           # Cấu hình, theme, constants
│   ├── data/             # Dữ liệu mẫu
│   ├── models/           # Các model dữ liệu
│   ├── providers/        # State management
│   ├── repositories/     # Truy xuất dữ liệu
│   ├── screens/          # Màn hình UI
│   ├── utils/            # Tiện ích
│   ├── widgets/          # Widget tái sử dụng
│   │   └── background_container.dart  # Widget cho background
│   └── main.dart         # Điểm khởi đầu ứng dụng
├── test/                 # Unit và widget tests
└── memory-bank/          # Tài liệu dự án
```

## ⚠️ Khắc phục sự cố

### Android SDK không tìm thấy
- **Windows**: Kiểm tra biến môi trường `ANDROID_HOME` hoặc `ANDROID_SDK_ROOT`
- **Linux/macOS**: Chạy `flutter config --android-sdk <đường_dẫn_đến_android_sdk>`

### Lỗi Gradle
```bash
# Làm sạch project
flutter clean
# Xóa file .gradle
cd android
./gradlew clean
cd ..
```

### Thư viện không tương thích
```bash
flutter pub upgrade
```

### VSCode không nhận diện Flutter
- Kiểm tra đã cài Flutter extension chưa
- Chạy `Flutter: Change SDK` trong Command Palette
- Đặt đường dẫn đến thư mục Flutter SDK

### Emulator không khởi động
- Kiểm tra HAXM (Hardware Accelerated Execution Manager) đã cài đặt
- Kích hoạt Virtualization trong BIOS (Windows/Linux)

## 🛠️ Công nghệ sử dụng

- **Framework**: Flutter 3.0+
- **Ngôn ngữ**: Dart 2.17+
- **State Management**: Provider
- **UI Components**:
  - table_calendar: Hiển thị và tương tác với lịch
  - shared_preferences: Lưu trữ dữ liệu cục bộ
  - intl: Định dạng ngày tháng, số

## 📄 Giấy phép

© 2025 SmartFengShui - Được phát triển như một ứng dụng mẫu.

---

Nếu có bất kỳ câu hỏi hoặc phản hồi về ứng dụng, vui lòng tạo issue trên repository này.
