import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/constants.dart';
import '../config/theme.dart';
import '../providers/calendar_provider.dart';
import '../models/day_info.dart';

class DateDetailScreen extends StatelessWidget {
  const DateDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(context);
    final selectedDate = calendarProvider.selectedDate;
    final dayInfo = calendarProvider.getDayInfo(selectedDate);

    // Nếu không có thông tin ngày, hiển thị thông báo
    if (dayInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(AppConstants.dayDetailsTitle),
          centerTitle: true,
        ),
        body: Center(
          child: Text(AppConstants.noDayInfoAvailable),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.dayDetailsTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thông tin cơ bản
            _buildBasicInfo(context, dayInfo, selectedDate),
            
            const SizedBox(height: AppTheme.spacingMedium),
            
            // Đánh giá ngày
            _buildRatingSection(context, dayInfo),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Việc nên làm
            _buildInfoSection(
              context,
              AppConstants.goodForLabel,
              dayInfo.suitableActivities,
              Icons.check_circle,
              AppTheme.goodDayColor,
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Việc nên tránh
            _buildInfoSection(
              context,
              AppConstants.badForLabel,
              dayInfo.unsuitableActivities,
              Icons.cancel,
              AppTheme.badDayColor,
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Hướng tốt
            _buildInfoSection(
              context,
              AppConstants.luckyDirectionsLabel,
              dayInfo.luckyDirections,
              Icons.explore,
              AppTheme.primaryColor,
            ),
            
            const SizedBox(height: AppTheme.spacingLarge),
            
            // Màu may mắn
            _buildInfoSection(
              context,
              AppConstants.luckyColorsLabel,
              dayInfo.luckyColors,
              Icons.palette,
              AppTheme.secondaryColor,
            ),
            
            const SizedBox(height: AppTheme.spacingXLarge),
          ],
        ),
      ),
    );
  }

  // Hiển thị thông tin cơ bản của ngày
  Widget _buildBasicInfo(BuildContext context, DayInfo dayInfo, DateTime selectedDate) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ngày dương lịch
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayInfo.solarDate,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    Text(
                      'Dương lịch',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
            
            const Divider(height: 32),
            
            // Ngày âm lịch
            Row(
              children: [
                const Icon(
                  Icons.brightness_2,
                  color: AppTheme.secondaryColor,
                  size: 32,
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayInfo.lunarDate,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      'Âm lịch',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hiển thị đánh giá ngày
  Widget _buildRatingSection(BuildContext context, DayInfo dayInfo) {
    final Color ratingColor = _getRatingColor(dayInfo.dayRating);
    final String ratingText = _getRatingText(dayInfo.dayRating);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Đánh giá ngày',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppTheme.spacingSmall),
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: ratingColor,
                  size: 32,
                ),
                const SizedBox(width: AppTheme.spacingMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < dayInfo.dayRating ? Icons.star : Icons.star_border,
                          color: index < dayInfo.dayRating
                              ? AppTheme.secondaryColor
                              : AppTheme.mediumGray,
                          size: 24,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ratingText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ratingColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Hiển thị các mục thông tin (việc nên làm, việc nên tránh, hướng tốt, màu may mắn)
  Widget _buildInfoSection(
    BuildContext context,
    String title,
    List<String> items,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const Divider(height: 24),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.chevron_right, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  // Lấy màu tương ứng với rating
  Color _getRatingColor(int rating) {
    if (rating >= 4) {
      return AppTheme.goodDayColor;
    } else if (rating <= 2) {
      return AppTheme.badDayColor;
    } else {
      return AppTheme.neutralDayColor;
    }
  }

  // Lấy text tương ứng với rating
  String _getRatingText(int rating) {
    if (rating >= 4) {
      return rating == 5 ? 'Rất tốt' : 'Tốt';
    } else if (rating <= 2) {
      return rating == 1 ? 'Rất xấu' : 'Xấu';
    } else {
      return 'Trung bình';
    }
  }
}
