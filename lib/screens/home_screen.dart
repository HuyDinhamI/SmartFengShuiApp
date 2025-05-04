import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../config/theme.dart';
import '../widgets/background_container.dart';
import 'calendar_screen.dart';
import 'course_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      opacity: 0.9,
      useOverlay: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppConstants.appName),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.85),
        ),
        body: Column(
          children: [
            // Phần chào mừng
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingLarge),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Icon(
                    Icons.spa,
                    size: 72,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    AppConstants.welcomeText,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    'Vận trình phong thủy mỗi ngày',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.mediumGray,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingLarge),
                ],
              ),
            ),
            
            // Hai nút chức năng chính
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLarge,
                  vertical: AppTheme.spacingMedium,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Nút Xem Ngày
                    _buildFeatureCard(
                      context,
                      title: AppConstants.calendarTabTitle,
                      icon: Icons.calendar_today,
                      description: 'Tra cứu ngày tốt xấu, việc nên làm và nên tránh',
                      color: AppTheme.goodDayColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalendarScreen(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: AppTheme.spacingLarge),
                    
                    // Nút Khóa Học
                    _buildFeatureCard(
                      context,
                      title: AppConstants.coursesTabTitle,
                      icon: Icons.school,
                      description: 'Khám phá các khóa học phong thủy cho bạn',
                      color: AppTheme.secondaryColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CourseListScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Footer
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Text(
                '© 2025 SmartFengShui',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      color: Theme.of(context).cardTheme.color?.withOpacity(0.85),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          height: 120,
          child: Row(
            children: [
              // Icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusLarge),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              
              const SizedBox(width: AppTheme.spacingMedium),
              
              // Text và mô tả
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
