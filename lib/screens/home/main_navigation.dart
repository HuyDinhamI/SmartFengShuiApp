import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/theme.dart';
import '../../providers/theme_provider.dart';
import 'home_screen.dart';
import '../calendar/calendar_screen.dart';
import '../chat/chat_screen.dart';
import '../profile/profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  // Danh sách các màn hình ứng với mỗi tab
  final List<Widget> _screens = [
    const HomeScreen(),      // Trang chủ
    const CalendarScreen(),  // Xem ngày
    const SizedBox(),        // Placeholder cho nút chính giữa
    const ChatScreen(),      // Chatbot
    const ProfileScreen(),   // Hồ sơ
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex == 2 ? 0 : _currentIndex, // Khi chọn tab giữa, vẫn hiển thị trang Home
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex == 2 ? 0 : _currentIndex, // Đánh dấu là Home nếu chọn tab giữa
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Xem ngày',
          ),
          BottomNavigationBarItem(
            icon: _buildCenterIcon(),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Tài khoản',
          ),
        ],
        onTap: (index) {
          if (index == 2) {
            // Khi nhấn vào nút giữa, hiển thị bottom sheet với các tiện ích
            _showUtilitiesBottomSheet(context);
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
      ),
    );
  }
  
  // Widget tạo nút chính giữa nổi bật
  Widget _buildCenterIcon() {
    return Container(
      height: 56,
      width: 56,
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Icon(
        Icons.apps,
        color: Colors.white,
        size: 28,
      ),
    );
  }
  
  // Hiển thị bottom sheet khi nhấn vào nút chính giữa
  void _showUtilitiesBottomSheet(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = themeProvider.isDarkMode;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        decoration: BoxDecoration(
          color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppTheme.borderRadiusLarge),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.mediumGray,
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
              ),
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
            ),
            const Text(
              'Tiện ích',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingLarge),
            Wrap(
              spacing: AppTheme.spacingMedium,
              runSpacing: AppTheme.spacingMedium,
              alignment: WrapAlignment.center,
              children: [
                _buildUtilityItem(
                  context,
                  'Sinh ảnh',
                  Icons.image,
                  AppTheme.secondaryColor,
                  onTap: () => _navigateToScreen(context, 'image_generation'),
                ),
                _buildUtilityItem(
                  context,
                  'AR/VR',
                  Icons.view_in_ar,
                  Colors.purpleAccent,
                  onTap: () => _navigateToScreen(context, 'ar_vr'),
                ),
                _buildUtilityItem(
                  context,
                  'Vật phẩm',
                  Icons.shopping_bag,
                  Colors.orangeAccent,
                  onTap: () => _navigateToScreen(context, 'products'),
                ),
                _buildUtilityItem(
                  context,
                  'Khóa học',
                  Icons.school,
                  Colors.blueAccent,
                  onTap: () => _navigateToScreen(context, 'courses'),
                ),
                _buildUtilityItem(
                  context,
                  'Tin tức',
                  Icons.article,
                  Colors.greenAccent,
                  onTap: () => _navigateToScreen(context, 'news'),
                ),
                _buildUtilityItem(
                  context,
                  'Thông báo',
                  Icons.notifications,
                  Colors.redAccent,
                  onTap: () => _navigateToScreen(context, 'notifications'),
                ),
                _buildUtilityItem(
                  context,
                  'Cài đặt',
                  Icons.settings,
                  AppTheme.mediumGray,
                  onTap: () => _navigateToScreen(context, 'settings'),
                ),
                _buildUtilityItem(
                  context,
                  'Chế độ ${isDarkMode ? "Sáng" : "Tối"}',
                  isDarkMode ? Icons.light_mode : Icons.dark_mode,
                  Colors.amber,
                  onTap: () {
                    themeProvider.toggleThemeMode();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingLarge),
          ],
        ),
      ),
    );
  }
  
  // Widget tạo item tiện ích trong bottom sheet
  Widget _buildUtilityItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color, {
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(AppTheme.spacingSmall),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingSmall),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? color.withOpacity(0.2)
                    : color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  // Điều hướng đến màn hình tương ứng với tiện ích được chọn
  void _navigateToScreen(BuildContext context, String screenName) {
    Navigator.pop(context); // Đóng bottom sheet
    
    // Sau đó điều hướng đến màn hình tương ứng
    switch (screenName) {
      case 'image_generation':
        _showFeatureInDevelopment(context, 'Sinh ảnh', 'Tính năng sinh ảnh phong thủy đang được phát triển');
        break;
      case 'ar_vr':
        _showFeatureInDevelopment(context, 'AR/VR', 'Tính năng AR/VR đang được phát triển');
        break;
      case 'products':
        _showFeatureInDevelopment(context, 'Vật phẩm', 'Danh mục vật phẩm phong thủy đang được cập nhật');
        break;
      case 'courses':
        // Điều hướng đến màn hình khóa học
        Navigator.pushNamed(context, '/courses');
        break;
      case 'news':
        _showFeatureInDevelopment(context, 'Tin tức', 'Tính năng tin tức phong thủy đang được phát triển');
        break;
      case 'notifications':
        _showFeatureInDevelopment(context, 'Thông báo', 'Tính năng thông báo đang được phát triển');
        break;
      case 'settings':
        _showFeatureInDevelopment(context, 'Cài đặt', 'Tính năng cài đặt đang được phát triển');
        break;
      default:
        break;
    }
  }
  
  // Hiển thị thông báo tính năng đang phát triển
  void _showFeatureInDevelopment(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title đang phát triển'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
}
