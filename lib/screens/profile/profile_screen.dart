import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../config/theme.dart';
import '../../models/user.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    
    final user = authProvider.currentUser;
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              pinned: true,
              expandedHeight: 150,
              backgroundColor: isDarkMode 
                  ? AppTheme.darkCardColor 
                  : AppTheme.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Hồ sơ người dùng',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  color: isDarkMode 
                      ? AppTheme.darkCardColor 
                      : AppTheme.primaryColor,
                  child: Center(
                    child: Icon(
                      Icons.account_circle,
                      size: 42,
                      color: isDarkMode 
                          ? AppTheme.primaryColor 
                          : Colors.white,
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: isDarkMode ? AppTheme.lightTextColor : Colors.white,
                  ),
                  onPressed: () {
                    themeProvider.toggleThemeMode();
                  },
                ),
              ],
            ),
            
            if (user == null)
              // Not logged in
              SliverFillRemaining(
                child: _buildNotLoggedInView(context),
              )
            else
              // User profile
              SliverToBoxAdapter(
                child: _buildUserProfile(context, user),
              ),
          ],
        ),
      ),
    );
  }
  
  // Widget hiển thị khi người dùng chưa đăng nhập
  Widget _buildNotLoggedInView(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.login,
              size: 80,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: AppTheme.spacingLarge),
            Text(
              'Bạn chưa đăng nhập',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            const Text(
              'Đăng nhập để truy cập vào hồ sơ và các tính năng cá nhân khác',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingXLarge),
            ElevatedButton(
              onPressed: () {
                // Đưa người dùng đến màn hình đăng nhập
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLarge,
                  vertical: AppTheme.spacingMedium,
                ),
              ),
              child: const Text('Đăng nhập'),
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            TextButton(
              onPressed: () {
                // Đưa người dùng đến màn hình đăng ký
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Chưa có tài khoản? Đăng ký ngay'),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget hiển thị hồ sơ người dùng
  Widget _buildUserProfile(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          Card(
            margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              child: Column(
                children: [
                  // Avatar
                  _buildAvatar(context, user),
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // Name
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  if (user.email != null) ...[
                    const SizedBox(height: AppTheme.spacingSmall),
                    Text(
                      user.email!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // Edit profile button
                  OutlinedButton.icon(
                    onPressed: () {
                      // Điều hướng đến màn hình chỉnh sửa hồ sơ
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Chỉnh sửa hồ sơ'),
                  ),
                ],
              ),
            ),
          ),
          
          // Account section
          _buildSection(
            context, 
            'Tài khoản',
            [
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: 'Cài đặt tài khoản',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Cài đặt tài khoản',
                    'Tính năng cài đặt tài khoản đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.notifications,
                title: 'Thông báo',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Thông báo',
                    'Tính năng thông báo đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.security,
                title: 'Bảo mật',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Bảo mật',
                    'Tính năng bảo mật đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.language,
                title: 'Ngôn ngữ',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Ngôn ngữ',
                    'Tính năng chuyển đổi ngôn ngữ đang được phát triển',
                  );
                },
              ),
            ],
          ),
          
          // Content section
          _buildSection(
            context, 
            'Nội dung',
            [
              _buildMenuItem(
                context,
                icon: Icons.favorite,
                title: 'Nội dung đã lưu',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Nội dung đã lưu',
                    'Tính năng xem nội dung đã lưu đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.history,
                title: 'Lịch sử xem',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Lịch sử xem',
                    'Tính năng xem lịch sử đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.chat_bubble,
                title: 'Lịch sử chat',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Lịch sử chat',
                    'Tính năng xem lịch sử chat đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.image,
                title: 'Ảnh đã tạo',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Ảnh đã tạo',
                    'Tính năng xem ảnh đã tạo đang được phát triển',
                  );
                },
              ),
            ],
          ),
          
          // Support section
          _buildSection(
            context, 
            'Hỗ trợ',
            [
              _buildMenuItem(
                context,
                icon: Icons.help,
                title: 'Trợ giúp & Hỗ trợ',
                onTap: () {
                  _showFeatureInDevelopment(
                    context,
                    'Trợ giúp & Hỗ trợ',
                    'Tính năng trợ giúp đang được phát triển',
                  );
                },
              ),
              _buildMenuItem(
                context,
                icon: Icons.info,
                title: 'Về chúng tôi',
                onTap: () {
                  _showAboutDialog(context);
                },
              ),
            ],
          ),
          
          // Logout button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingLarge),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : () => _logout(context),
                icon: _isLoading 
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.logout),
                label: const Text('Đăng xuất'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMedium),
                ),
              ),
            ),
          ),
          
          // Version info
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingLarge),
              child: Text(
                '${AppConstants.appName} v1.0.0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Avatar widget với tùy chọn thay đổi
  Widget _buildAvatar(BuildContext context, UserModel user) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Avatar
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDarkMode
                ? AppTheme.darkElevatedColor
                : AppTheme.lightGray,
            border: Border.all(
              color: AppTheme.primaryColor,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: user.imageUrl != null
                ? Image.network(
                    user.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: 60,
                      color: isDarkMode
                          ? AppTheme.primaryColor
                          : AppTheme.primaryColorLight,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 60,
                    color: isDarkMode
                        ? AppTheme.primaryColor
                        : AppTheme.primaryColorLight,
                  ),
          ),
        ),
        
        // Edit button
        Positioned(
          right: -5,
          bottom: -5,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isDarkMode
                    ? AppTheme.darkBackgroundColor
                    : Colors.white,
                width: 2,
              ),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                _showFeatureInDevelopment(
                  context,
                  'Thay đổi ảnh đại diện',
                  'Tính năng thay đổi ảnh đại diện đang được phát triển',
                );
              },
              constraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
                maxWidth: 40,
                maxHeight: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // Widget tạo phần tiêu đề
  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMedium,
            vertical: AppTheme.spacingSmall,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
  
  // Widget tạo menu item
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return ListTile(
      leading: Icon(
        icon,
        color: AppTheme.primaryColor,
      ),
      title: Text(title),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
      ),
      onTap: onTap,
      tileColor: isDarkMode ? AppTheme.darkCardColor : null,
    );
  }
  
  // Hiển thị thông tin về ứng dụng
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AboutDialog(
        applicationName: AppConstants.appName,
        applicationVersion: '1.0.0',
        applicationIcon: Image.asset(
          'assets/images/app_icon.png',
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.spa,
            size: 50,
            color: AppTheme.primaryColor,
          ),
        ),
        children: [
          const SizedBox(height: AppTheme.spacingMedium),
          const Text(
            AppConstants.appName + ' là ứng dụng phong thủy toàn diện giúp người dùng tra cứu ngày tốt xấu, tư vấn phong thủy và nhiều tính năng hữu ích khác.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          const Text(
            '© 2025 ' + AppConstants.appName + ' - Mọi quyền được bảo lưu.',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
  
  // Đăng xuất
  Future<void> _logout(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      
      await authProvider.signOut();
      userProvider.clearUser();
      
      // Điều hướng về màn hình đăng nhập
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
