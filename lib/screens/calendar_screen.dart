import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../config/constants.dart';
import '../config/theme.dart';
import '../providers/calendar_provider.dart';
import '../models/day_info.dart';
import 'date_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Tải dữ liệu ngày nếu cần
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CalendarProvider>(context, listen: false).loadDayInfos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final calendarProvider = Provider.of<CalendarProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.calendarTabTitle),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      // Bọc trong SingleChildScrollView để tránh lỗi overflow
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Widget lịch
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                
                // Cập nhật ngày đã chọn trong provider
                calendarProvider.selectDate(selectedDay);
                
                // Chuyển đến màn hình chi tiết ngày nếu có thông tin
                if (calendarProvider.hasDayInfo(selectedDay)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DateDetailScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(AppConstants.noDayInfoAvailable),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                // Tùy chỉnh màu sắc cho các ngày tốt, xấu
                markersMaxCount: 3,
                markersAlignment: Alignment.bottomCenter,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  // Tô màu các ngày tốt, xấu
                  if (calendarProvider.isGoodDay(date)) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.goodDayColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  } else if (calendarProvider.isBadDay(date)) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.badDayColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  } else if (calendarProvider.isNeutralDay(date)) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.neutralDayColor,
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Hiển thị thông tin ngày hôm nay - đã loại bỏ Expanded để tránh lỗi overflow
            _buildTodayInfoCard(calendarProvider),
            
            const SizedBox(height: 16), // Thêm khoảng cách phía dưới
          ],
        ),
      ),
    );
  }

  Widget _buildTodayInfoCard(CalendarProvider provider) {
    final todayInfo = provider.getDayInfo(DateTime.now());
    
    if (todayInfo == null) {
      return const Center(
        child: Text('Không có thông tin cho ngày hôm nay'),
      );
    }
    
    // Bọc trong Container với constraints để đảm bảo chiều cao tối thiểu
    return Container(
      constraints: const BoxConstraints(minHeight: 250),
      child: Card(
        margin: const EdgeInsets.all(AppTheme.spacingMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppConstants.todayLabel}: ${todayInfo.solarDate}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                'Âm lịch: ${todayInfo.lunarDate}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: AppTheme.primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    '${AppConstants.dayRatingLabel} ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  _buildRatingStars(todayInfo.dayRating),
                ],
              ),
              const SizedBox(height: 16),
              _buildListSection(
                AppConstants.goodForLabel,
                todayInfo.goodFor,
                Icons.check_circle,
                AppTheme.goodDayColor,
              ),
              const SizedBox(height: 8),
              _buildListSection(
                AppConstants.badForLabel,
                todayInfo.badFor,
                Icons.cancel,
                AppTheme.badDayColor,
              ),
              // Thay thế Spacer bằng khoảng cách có kích thước cố định
              const SizedBox(height: 16), 
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DateDetailScreen(),
                      ),
                    );
                  },
                  child: const Text('Xem chi tiết'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? AppTheme.secondaryColor : AppTheme.mediumGray,
          size: 20,
        );
      }),
    );
  }

  Widget _buildListSection(
    String title,
    List<String> items,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        ...items.take(2).map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(item, style: Theme.of(context).textTheme.bodyMedium),
              ),
            ],
          ),
        )),
        if (items.length > 2)
          Text(
            '...và ${items.length - 2} việc khác',
            style: Theme.of(context).textTheme.bodySmall,
          ),
      ],
    );
  }
}
