import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/day_info.dart';
import '../../providers/theme_provider.dart';

class DayDetailScreen extends StatelessWidget {
  final DayInfo dayInfo;
  
  const DayDetailScreen({super.key, required this.dayInfo});
  
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Scaffold(
      appBar: AppBar(
        title: Text(dateFormat.format(dayInfo.date)),
        centerTitle: true,
        backgroundColor: dayInfo.isGoodDay
            ? AppTheme.goodDayColor
            : AppTheme.badDayColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Day status banner
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              color: dayInfo.isGoodDay
                  ? AppTheme.goodDayColor
                  : AppTheme.badDayColor,
              child: Column(
                children: [
                  Text(
                    dayInfo.isGoodDay ? 'NGÀY TỐT' : 'NGÀY XẤU',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < dayInfo.dayRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Basic info card
            Card(
              margin: const EdgeInsets.all(AppTheme.spacingMedium),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Thông tin cơ bản',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    _buildInfoRow('Dương lịch:', dayInfo.solarDate),
                    _buildInfoRow('Âm lịch:', dayInfo.lunarDate),
                    _buildInfoRow('Can chi:', dayInfo.canChi),
                    _buildInfoRow('Ngũ hành:', dayInfo.nguHanh),
                  ],
                ),
              ),
            ),
            
            // Activities section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMedium,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActivityCard(
                      context,
                      'Nên làm',
                      dayInfo.suitableActivities,
                      Icons.check_circle,
                      AppTheme.goodDayColor,
                      isDarkMode,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMedium),
                  Expanded(
                    child: _buildActivityCard(
                      context,
                      'Nên tránh',
                      dayInfo.unsuitableActivities,
                      Icons.cancel,
                      AppTheme.badDayColor,
                      isDarkMode,
                    ),
                  ),
                ],
              ),
            ),
            
            // Lucky directions and colors
            Card(
              margin: const EdgeInsets.all(AppTheme.spacingMedium),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hướng và màu sắc may mắn',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    _buildInfoRow(
                      'Hướng tốt:',
                      dayInfo.luckyDirections.join(', '),
                    ),
                    _buildInfoRow(
                      'Màu sắc may mắn:',
                      dayInfo.luckyColors.join(', '),
                    ),
                  ],
                ),
              ),
            ),
            
            // Note section
            Card(
              margin: const EdgeInsets.all(AppTheme.spacingMedium),
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
                        ),
                        const SizedBox(width: AppTheme.spacingSmall),
                        const Text(
                          'Nhận xét phong thủy',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(dayInfo.note),
                  ],
                ),
              ),
            ),
            
            // Share and save button
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showFeatureInDevelopment(
                          context,
                          'Chia sẻ',
                          'Tính năng chia sẻ thông tin ngày đang được phát triển',
                        );
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Chia sẻ'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMedium),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showFeatureInDevelopment(
                          context,
                          'Lưu lịch',
                          'Tính năng lưu vào lịch đang được phát triển',
                        );
                      },
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Lưu lịch'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.secondaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Footer disclaimer
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              alignment: Alignment.center,
              child: const Text(
                'Thông tin phong thủy mang tính chất tham khảo',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: AppTheme.mediumGray,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Widget hiển thị thông tin dạng cặp key-value
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppTheme.mediumGray,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget hiển thị card hoạt động nên làm/nên tránh
  Widget _buildActivityCard(
    BuildContext context,
    String title,
    List<String> activities,
    IconData icon,
    Color color,
    bool isDarkMode,
  ) {
    return Card(
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
                Icon(icon, color: color),
                const SizedBox(width: AppTheme.spacingSmall),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const Divider(),
            ...activities.map((activity) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 8,
                      color: color,
                    ),
                    const SizedBox(width: AppTheme.spacingSmall),
                    Expanded(child: Text(activity)),
                  ],
                ),
              );
            }).toList(),
          ],
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
