import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/firebase_options.dart';
import 'config/theme.dart';
import 'config/constants.dart';
import 'providers/auth_provider.dart';
import 'providers/calendar_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/course_provider.dart';
import 'providers/image_provider.dart' as img;
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/auth/forgot_password_screen.dart';
import 'screens/calendar/calendar_screen.dart';
import 'screens/chat/chat_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/profile/edit_profile_screen.dart';
import 'screens/home/main_navigation.dart';
import 'screens/home/home_screen.dart';

void main() async {
  // Đảm bảo Flutter đã được khởi tạo
  WidgetsFlutterBinding.ensureInitialized();

  // Cấu hình orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Khởi tạo SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  
  // Chỉ dành cho phát triển: kiểm tra cài đặt bỏ qua đăng nhập
  final skipLogin = prefs.getBool('skip_login') ?? false;
  
  // Khởi tạo Firebase - Tạm bỏ comment sau khi đã cài đặt Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(MyApp(prefs: prefs, skipLogin: skipLogin));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final bool skipLogin;
  
  const MyApp({super.key, required this.prefs, required this.skipLogin});

  @override
  Widget build(BuildContext context) {
    // Khởi tạo multi provider cho ứng dụng
    return MultiProvider(
      providers: [
        // Providers chính
        ChangeNotifierProvider(create: (_) => ThemeProvider(prefs)),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        
        // Providers cho từng tính năng
        ChangeNotifierProvider(create: (_) => CalendarProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => img.ImageProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: AppConstants.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('vi', 'VN'), // Tiếng Việt
              Locale('en', 'US'), // English
            ],
            locale: const Locale('vi', 'VN'),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => AuthWrapper(skipLogin: skipLogin),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
              '/forgot_password': (context) => const ForgotPasswordScreen(),
              '/main': (context) => const MainNavigation(),
              '/home': (context) => const HomeScreen(),
              '/calendar': (context) => const CalendarScreen(),
              '/chat': (context) => const ChatScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/edit_profile': (context) => const EditProfileScreen(),
              '/courses': (context) => const Scaffold(body: Center(child: Text('Màn hình Khóa học đang phát triển'))),
            },
          );
        }
      ),
    );
  }
}

// Widget Wrapper để kiểm tra trạng thái đăng nhập
class AuthWrapper extends StatelessWidget {
  final bool skipLogin;
  
  const AuthWrapper({super.key, required this.skipLogin});

  @override
  Widget build(BuildContext context) {
    // Trong phiên bản phát triển, cho phép bỏ qua đăng nhập dựa trên tham số
    if (skipLogin) {
      return const MainNavigation();
    }
    
    // Tạm thời không sử dụng xác thực Firebase, sẽ chuyển đến màn hình đăng nhập
    // Uncomment khi đã cài đặt Firebase hoàn chỉnh
    // final authProvider = Provider.of<AuthProvider>(context);
    // return authProvider.isAuthenticated
    //   ? const MainNavigation()
    //   : const LoginScreen();
    
    // Trong quá trình phát triển, tạm sử dụng LoginScreen
    return const LoginScreen();
    
    // Nếu muốn bỏ qua màn hình đăng nhập, comment dòng trên và uncomment dòng dưới
    // return const MainNavigation();
  }
}
