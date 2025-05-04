import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart' as carousel_widget ;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../../config/constants.dart';
import '../../config/theme.dart';
import '../../providers/theme_provider.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentCarouselIndex = 0;
  final carousel_widget.CarouselController _carouselController = carousel_widget.CarouselController();
  
  // Mock news items cho carousel
  final List<Map<String, dynamic>> _newsItems = [
    {
      'title': 'Phong Thủy Nhà Ở 2025: Những Điều Cần Lưu Ý',
      'image': 'https://via.placeholder.com/800x400?text=Phong+Thuy+Nha+O',
      'description': 'Năm 2025 cần chú ý đến các yếu tố phong thủy quan trọng cho nhà ở...'
    },
    {
      'title': 'Cách Bố Trí Bàn Làm Việc Hợp Phong Thủy',
      'image': 'https://via.placeholder.com/800x400?text=Ban+Lam+Viec',
      'description': 'Bố trí bàn làm việc đúng phong thủy sẽ giúp tăng cường hiệu suất...'
    },
    {
      'title': 'Top 5 Vật Phẩm Phong Thủy Cho Tài Lộc',
      'image': 'https://via.placeholder.com/800x400?text=Vat+Pham+Phong+Thuy',
      'description': 'Những vật phẩm phong thủy giúp thu hút tài lộc và may mắn...'
    },
    {
      'title': 'Màu Sắc Hợp Mệnh Trong Năm 2025',
      'image': 'https://via.placeholder.com/800x400?text=Mau+Sac+Hop+Menh',
      'description': 'Các màu sắc hợp mệnh giúp tăng cường năng lượng tích cực...'
    },
  ];
  
  // Mock utility items cho grid
  final List<Map<String, dynamic>> _utilityItems = [
    {
      'title': 'Xem Ngày',
      'icon': Icons.calendar_today,
      'color': AppTheme.goodDayColor,
      'route': '/calendar',
    },
    {
      'title': 'Chatbot',
      'icon': Icons.chat,
      'color': Colors.blueAccent,
      'route': '/chat',
    },
    {
      'title': 'Sinh Ảnh',
      'icon': Icons.image,
      'color': AppTheme.secondaryColor,
      'route': '/image_generation',
    },
    {
      'title': 'Khóa Học',
      'icon': Icons.school,
      'color': Colors.purpleAccent,
      'route': '/courses',
    },
    {
      'title': 'Vật Phẩm',
      'icon': Icons.shopping_bag,
      'color': Colors.orangeAccent,
      'route': '/products',
    },
    {
      'title': 'AR/VR',
      'icon': Icons.view_in_ar,
      'color': Colors.greenAccent,
      'route': '/ar_vr',
    },
    {
      'title': 'Tin Tức',
      'icon': Icons.article,
      'color': Colors.redAccent,
      'route': '/news',
    },
    {
      'title': 'Cài Đặt',
      'icon': Icons.settings,
      'color': AppTheme.mediumGray,
      'route': '/settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Lấy state theme để kiểm tra dark mode
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    // Lấy state auth để hiển thị tên người dùng
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              pinned: true,
              expandedHeight: 120,
              backgroundColor: isDarkMode 
                  ? AppTheme.darkCardColor 
                  : AppTheme.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: isDarkMode 
                        ? AppTheme.lightTextColor 
                        : Colors.white,
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
                      Icons.spa,
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
            
            // Greeting
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Xin chào${user != null ? ", ${user.name}" : ""}!',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Chào mừng bạn đến với ứng dụng phong thủy',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isDarkMode 
                            ? AppTheme.secondaryTextColor 
                            : AppTheme.mediumGray,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // News Carousel
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tin tức phong thủy',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _showFeatureInDevelopment(
                              context, 
                              'Tin tức', 
                              'Danh sách tin tức đầy đủ đang được phát triển'
                            );
                          },
                          child: const Text('Xem tất cả'),
                        ),
                      ],
                    ),
                  ),
                  
                  carousel_widget.FlutterCarousel(
                    options: carousel_widget.CarouselOptions(
                      height: 200,
                      aspectRatio: 16/9,
                      viewportFraction: 0.9,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      controller: _carouselController,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarouselIndex = index;
                        });
                      },
                      slideIndicator: carousel_widget.CircularSlideIndicator(),
                    ),
                    items: _newsItems.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return _buildNewsCard(context, item);
                        },
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSmall),
                  
                  // Carousel indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _newsItems.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _carouselController.nextPage(),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0, 
                            horizontal: 4.0
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness == Brightness.dark
                                    ? AppTheme.primaryColor
                                    : AppTheme.primaryColor)
                                .withOpacity(
                                  _currentCarouselIndex == entry.key ? 0.9 : 0.3,
                                ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                ],
              ),
            ),
            
            // Utilities Grid
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    child: Text(
                      'Tiện ích',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMedium),
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: _utilityItems.map((item) {
                        return _buildUtilityCard(
                          context, 
                          item['title'], 
                          item['icon'], 
                          item['color'],
                          item['route'],
                        );
                      }).toList(),
                    ),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingLarge),
                ],
              ),
            ),
            
            // Daily Feng Shui Tip
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.spacingMedium),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb,
                              color: AppTheme.secondaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: AppTheme.spacingSmall),
                            Text(
                              'Phong thủy hôm nay',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacingSmall),
                        const Text(
                          'Đặt một bát nước gần cửa sổ phía Đông Nam của nhà để thu hút năng lượng tích cực. Hôm nay là ngày tốt cho các hoạt động sáng tạo và giao tiếp.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: AppTheme.spacingSmall),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/calendar');
                            },
                            child: const Text('Xem chi tiết'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Footer
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  children: [
                    const Divider(),
                    const SizedBox(height: AppTheme.spacingMedium),
                    Text(
                      '© 2025 ${AppConstants.appName}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.mediumGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget hiển thị card tin tức trong carousel
  Widget _buildNewsCard(BuildContext context, Map<String, dynamic> newsItem) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return GestureDetector(
      onTap: () => _showFeatureInDevelopment(
        context, 
        'Tin tức', 
        'Chi tiết tin tức đang được phát triển'
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background image
              Image.network(
                newsItem['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: isDarkMode 
                        ? AppTheme.darkElevatedColor 
                        : AppTheme.lightGray,
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 48),
                    ),
                  );
                },
              ),
              
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              
              // Text content
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsItem['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      newsItem['description'],
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Widget hiển thị tiện ích trong grid
  Widget _buildUtilityCard(
    BuildContext context, 
    String title, 
    IconData icon, 
    Color color,
    String route,
  ) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return GestureDetector(
      onTap: () {
        if (route == '/calendar' || route == '/chat' || route == '/courses') {
          // Sử dụng navigationIndex cho các tab có sẵn
          final int tabIndex = route == '/calendar' 
              ? 1 
              : route == '/chat'
                  ? 3
                  : 0; // Courses sẽ được mở từ nút ở bottom sheet
                  
          if (route == '/courses') {
            Navigator.pushNamed(context, route);
          } else if (tabIndex != 0) {
            // Nếu là Calendar hoặc Chat, chuyển tab
            // Tuy nhiên trong HomeScreen không có cách trực tiếp để thay đổi tab
            // Thường sẽ cần một cách để thông báo cho MainNavigation
            // Ở đây tạm thời chỉ push route
            Navigator.pushNamed(context, route);
          }
        } else {
          // Với các tính năng đang phát triển
          _showFeatureInDevelopment(
            context, 
            title, 
            'Tính năng $title đang được phát triển'
          );
        }
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  size: 24,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
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
