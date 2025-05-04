import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/constants.dart';
import '../config/theme.dart';
import '../providers/course_provider.dart';
import '../models/course.dart';
import '../widgets/background_container.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final course = courseProvider.courses.firstWhere(
      (course) => course.id == courseId,
      orElse: () => throw Exception('Không tìm thấy khóa học với ID: $courseId'),
    );

    return BackgroundContainer(
      opacity: 0.9,
      useOverlay: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppConstants.courseDetailsTitle),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.85),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh khóa học
              Container(
                width: double.infinity,
                height: 200,
                color: AppTheme.lightGray,
                child: const Center(
                  child: Icon(
                    Icons.photo,
                    size: 64,
                    color: AppTheme.mediumGray,
                  ),
                ),
                // Trong ứng dụng thực tế, bạn sẽ sử dụng hình ảnh thực
                // Image.asset(
                //   course.imageUrl,
                //   width: double.infinity,
                //   height: 200,
                //   fit: BoxFit.cover,
                // ),
              ),

              // Thông tin khóa học
              Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tên khóa học
                    Text(
                      course.title,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),

                    const SizedBox(height: 8),

                    // Đánh giá và thời lượng
                    Row(
                      children: [
                        // Đánh giá
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < course.rating.floor()
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppTheme.secondaryColor,
                                size: 20,
                              );
                            }),
                            const SizedBox(width: 4),
                            Text(
                              course.rating.toString(),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),

                        const SizedBox(width: 16),

                        // Thời lượng
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 20,
                              color: AppTheme.mediumGray,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              course.duration,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Giá
                    Text(
                      course.formattedPrice,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    const Divider(height: 32),

                    // Mô tả khóa học
                    Text(
                      AppConstants.courseInfoLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      course.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const Divider(height: 32),

                    // Danh sách bài học
                    Text(
                      AppConstants.courseLessonsLabel,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 16),

                    // Danh sách bài học
                    ...course.lessons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final lesson = entry.value;
                      return _buildLessonItem(context, index, lesson);
                    }),

                    const SizedBox(height: 32),

                    // Nút đăng ký khóa học
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          // Thêm khóa học vào giỏ hàng
                          courseProvider.addToCart(courseId);
                          
                          // Hiển thị thông báo
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Đã thêm "${course.title}" vào giỏ hàng'),
                              duration: const Duration(seconds: 2),
                              action: SnackBarAction(
                                label: 'Xem',
                                onPressed: () {
                                  // Trong phiên bản hoàn chỉnh, sẽ chuyển đến màn hình giỏ hàng
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Chức năng này sẽ được phát triển sau'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: Text(
                          AppConstants.registerCourseLabel,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLessonItem(BuildContext context, int index, String lesson) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: Theme.of(context).cardTheme.color?.withOpacity(0.85),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor,
          child: Text(
            '${index + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(lesson),
        trailing: index < 2 // 2 bài đầu miễn phí (demo)
            ? const Chip(
                label: Text('Miễn phí'),
                backgroundColor: AppTheme.goodDayColor,
                labelStyle: TextStyle(color: Colors.white),
              )
            : null,
        onTap: () {
          if (index < 2) {
            // Xem bài học miễn phí (demo)
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Xem bài học (chức năng này sẽ được phát triển sau)'),
              ),
            );
          } else {
            // Yêu cầu mua khóa học
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Hãy mua khóa học để xem bài này'),
              ),
            );
          }
        },
      ),
    );
  }
}
