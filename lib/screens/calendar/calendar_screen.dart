import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../config/theme.dart';
import '../../models/day_info.dart';
import '../../providers/calendar_provider.dart';
import '../../providers/theme_provider.dart';
import 'day_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    
    // Tải thông tin ngày tốt xấu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final calendarProvider = Provider.of<CalendarProvider>(context, listen: false);
      calendarProvider.fetchDayInfos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final calendarProvider = Provider.of<CalendarProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xem Ngày Tốt Xấu'),
        centerTitle: true,
        actions: [
          // Toggle dark mode
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: () {
              themeProvider.toggleThemeMode();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar widget
          _buildCalendar(context, calendarProvider),
          
          // Current day info
          Expanded(
            child: calendarProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : _selectedDay == null
                    ? _buildEmptyDayInfo()
                    : _buildDayInfo(context, calendarProvider),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        onPressed: () {
          _showDateSearchDialog(context);
        },
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }
  
  // Widget hiển thị lịch
  Widget _buildCalendar(BuildContext context, CalendarProvider calendarProvider) {
    return Card(
      margin: const EdgeInsets.all(AppTheme.spacingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingSmall),
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
              color: AppTheme.primaryColorLight,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              shape: BoxShape.circle,
            ),
          ),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          headerStyle: const HeaderStyle(
            formatButtonVisible: true,
            titleCentered: true,
            formatButtonShowsNext: false,
          ),
          // Hiển thị marker cho ngày tốt và xấu
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              final dayInfo = calendarProvider.getDayInfo(date);
              
              if (dayInfo != null) {
                return Positioned(
                  bottom: 1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: dayInfo.isGoodDay
                          ? AppTheme.goodDayColor
                          : AppTheme.badDayColor,
                    ),
                  ),
                );
              }
              return null;
            },
            // Tùy chỉnh style cho các ngày trong tháng
            defaultBuilder: (context, date, events) {
              final dayInfo = calendarProvider.getDayInfo(date);
              
              return Container(
                alignment: Alignment.center,
                decoration: dayInfo != null
                    ? BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: dayInfo.isGoodDay
                              ? AppTheme.goodDayColor
                              : AppTheme.badDayColor,
                          width: 1,
                        ),
                      )
                    : null,
                child: Text(
                  '${date.day}',
                  style: dayInfo != null
                      ? TextStyle(
                          color: dayInfo.isGoodDay
                              ? AppTheme.goodDayColor
                              : AppTheme.badDayColor,
                          fontWeight: FontWeight.bold,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  
  // Widget hiển thị khi không có ngày nào được chọn
  Widget _buildEmptyDayInfo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today,
            size: 80,
            color: AppTheme.primaryColor.withOpacity(0.5),
          ),
          const SizedBox(height: AppTheme.spacingMedium),
          const Text(
            'Chọn một ngày để xem thông tin phong thủy',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  
  // Widget hiển thị thông tin ngày đã chọn
  Widget _buildDayInfo(BuildContext context, CalendarProvider calendarProvider) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final dayInfo = calendarProvider.getDayInfo(_selectedDay!);
    
    if (dayInfo == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              size: 60,
              color: AppTheme.mediumGray,
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            Text(
              'Chưa có thông tin cho ngày ${_dateFormat.format(_selectedDay!)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppTheme.spacingMedium),
            const Text(
              'Ngày này sẽ được cập nhật sớm',
              style: TextStyle(
                color: AppTheme.mediumGray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Thông tin chung về ngày
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                children: [
                  // Title với ngày và trạng thái
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _dateFormat.format(dayInfo.date),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMedium,
                          vertical: AppTheme.spacingSmall / 2,
                        ),
                        decoration: BoxDecoration(
                          color: dayInfo.isGoodDay
                              ? AppTheme.goodDayColor
                              : AppTheme.badDayColor,
                          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                        ),
                        child: Text(
                          dayInfo.isGoodDay ? 'Ngày Tốt' : 'Ngày Xấu',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // Thông tin âm lịch
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: AppTheme.secondaryColor,
                      ),
                      const SizedBox(width: AppTheme.spacingSmall),
                      Text(
                        'Âm lịch: ${dayInfo.lunarDate}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSmall),
                  
                  // Thông tin can chi
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: AppTheme.secondaryColor,
                      ),
                      const SizedBox(width: AppTheme.spacingSmall),
                      Text(
                        'Can chi: ${dayInfo.canChi}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingSmall),
                  
                  // Thông tin ngũ hành
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: AppTheme.secondaryColor,
                      ),
                      const SizedBox(width: AppTheme.spacingSmall),
                      Text(
                        'Ngũ hành: ${dayInfo.nguHanh}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingMedium),
                  
                  // Xem chi tiết
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DayDetailScreen(dayInfo: dayInfo),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dayInfo.isGoodDay
                          ? AppTheme.goodDayColor
                          : AppTheme.badDayColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Xem chi tiết'),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingMedium),
          
          // Các việc nên làm
          if (dayInfo.isGoodDay) 
            _buildSuggestionCard(
              context,
              'Các việc nên làm',
              dayInfo.suitableActivities,
              Icons.check_circle,
              AppTheme.goodDayColor,
              isDarkMode ? AppTheme.goodDayColor.withOpacity(0.15) : AppTheme.goodDayColor.withOpacity(0.1),
            ),
          
          // Các việc nên tránh
          const SizedBox(height: AppTheme.spacingMedium),
          _buildSuggestionCard(
            context,
            'Các việc nên tránh',
            dayInfo.unsuitableActivities,
            Icons.cancel,
            AppTheme.badDayColor,
            isDarkMode ? AppTheme.badDayColor.withOpacity(0.15) : AppTheme.badDayColor.withOpacity(0.1),
          ),
          
          const SizedBox(height: AppTheme.spacingMedium),
          
          // Ghi chú phong thủy
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMedium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.lightbulb,
                        color: AppTheme.secondaryColor,
                      ),
                      SizedBox(width: AppTheme.spacingSmall),
                      Text(
                        'Ghi chú phong thủy',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingMedium),
                  Text(
                    dayInfo.note,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Widget hiển thị card gợi ý việc nên/không nên làm
  Widget _buildSuggestionCard(
    BuildContext context,
    String title,
    List<String> activities,
    IconData icon,
    Color color,
    Color backgroundColor,
  ) {
    return Card(
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
                  icon,
                  color: color,
                ),
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
            const SizedBox(height: AppTheme.spacingMedium),
            ...activities.map((activity) => _buildActivityItem(
              context,
              activity,
              color,
              backgroundColor,
            )).toList(),
          ],
        ),
      ),
    );
  }
  
  // Widget hiển thị từng hoạt động
  Widget _buildActivityItem(
    BuildContext context,
    String activity,
    Color color,
    Color backgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.circle,
              color: color,
              size: 8,
            ),
          ),
          const SizedBox(width: AppTheme.spacingSmall),
          Expanded(
            child: Text(
              activity,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
  
  // Hiển thị dialog tìm kiếm ngày
  void _showDateSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tìm kiếm ngày'),
          content: const Text('Chọn ngày bạn muốn xem:'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDay ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                
                if (date != null) {
                  setState(() {
                    _selectedDay = date;
                    _focusedDay = date;
                  });
                }
              },
              child: const Text('Chọn ngày'),
            ),
          ],
        );
      },
    );
  }
}
