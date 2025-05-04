// File này sẽ được thay thế bởi file được tạo tự động sau khi chạy lệnh `flutterfire configure`
// Hiện tại là file placeholder

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] cho việc sử dụng với các ứng dụng Firebase.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'MacOS chưa được cấu hình cho Firebase.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'Windows chưa được cấu hình cho Firebase.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'Linux chưa được cấu hình cho Firebase.',
        );
      default:
        throw UnsupportedError(
          'Nền tảng mặc định không được cấu hình cho Firebase: ${defaultTargetPlatform}',
        );
    }
  }

  // Thay thế các giá trị dưới đây bằng giá trị từ tệp cấu hình Firebase của bạn
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'FIREBASE_API_KEY',
    appId: 'FIREBASE_APP_ID',
    messagingSenderId: 'FIREBASE_MESSAGING_SENDER_ID',
    projectId: 'FIREBASE_PROJECT_ID',
    authDomain: 'FIREBASE_AUTH_DOMAIN',
    storageBucket: 'FIREBASE_STORAGE_BUCKET',
    measurementId: 'FIREBASE_MEASUREMENT_ID',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'FIREBASE_API_KEY',
    appId: 'FIREBASE_APP_ID',
    messagingSenderId: 'FIREBASE_MESSAGING_SENDER_ID',
    projectId: 'FIREBASE_PROJECT_ID',
    storageBucket: 'FIREBASE_STORAGE_BUCKET',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'FIREBASE_API_KEY',
    appId: 'FIREBASE_APP_ID',
    messagingSenderId: 'FIREBASE_MESSAGING_SENDER_ID',
    projectId: 'FIREBASE_PROJECT_ID',
    storageBucket: 'FIREBASE_STORAGE_BUCKET',
    iosClientId: 'FIREBASE_IOS_CLIENT_ID',
    iosBundleId: 'FIREBASE_IOS_BUNDLE_ID',
  );
}
