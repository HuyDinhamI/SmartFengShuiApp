import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../config/theme.dart';
import '../providers/course_provider.dart';
import '../models/course.dart';
import '../widgets/background_container.dart';
import 'course_detail_screen.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Tải dữ liệu khóa học
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CourseProvider>(context, listen: false).loadCourses();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    final courses = _searchQuery.isEmpty
        ? courseProvider.courses
        : courseProvider.searchCourses(_searchQuery);

    return BackgroundContainer(
      opacity: 0.9,
      useOverlay: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(AppConstants.coursesTabTitle),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.85),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            // Thanh tìm kiếm
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm khóa học...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

            // Danh sách khóa học
            Expanded(
              child: courses.isEmpty
                  ? const Center(
                      child: Text('Không tìm thấy khóa học nào'),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppTheme.spacingMedium),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        return _buildCourseCard(context, courses[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course course) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMedium),
      color: Theme.of(context).cardTheme.color?.withOpacity(0.85),
      child: InkWell(
        onTap: () {
          // Lưu khóa học đã chọn vào provider
          Provider.of<CourseProvider>(context, listen: false).selectCourse(course.id);
          
          // Chuyển đến màn hình chi tiết khóa học
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(courseId: course.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
        child: SizedBox(
          height: AppConstants.courseCardHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hình ảnh khóa học
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.borderRadiusMedium),
                  bottomLeft: Radius.circular(AppTheme.borderRadiusMedium),
                ),
                child: Container(
                  width: AppConstants.courseImageWidth,
                  height: double.infinity,
                  color: AppTheme.lightGray,
                  child: const Icon(
                    Icons.photo,
                    size: 48,
                    color: AppTheme.mediumGray,
                  ),
                ),
              ),
              
              // Thông tin khóa học
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingMedium),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Tên khóa học
                          Text(
                            course.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Thời lượng khóa học
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16, color: AppTheme.mediumGray),
                              const SizedBox(width: 4),
                              Text(
                                course.duration,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 8),
                          
                          // Đánh giá
                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < course.rating.floor() ? Icons.star : Icons.star_border,
                                  color: AppTheme.secondaryColor,
                                  size: 16,
                                );
                              }),
                              const SizedBox(width: 4),
                              Text(
                                course.rating.toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          
                          const Spacer(),
                          
                          // Giá
                          Text(
                            course.formattedPrice,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
