import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/date_service.dart';
import '../constants/app_colors.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime currentMonth;
  final Function(DateTime) onDateSelected;
  final Set<String> completedDays;

  const CalendarWidget({
    super.key,
    required this.currentMonth,
    required this.onDateSelected,
    required this.completedDays,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final now = DateService.now;
    final currentMonth = widget.currentMonth;
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    // Convert weekday: Dart uses 1=Monday, 7=Sunday
    // For calendar starting with Sunday: Sunday=0, Monday=1, Tuesday=2, etc.
    // So: weekday 7 (Sunday) -> 0, weekday 1 (Monday) -> 1, weekday 2 (Tuesday) -> 2
    final firstWeekday = firstDayOfMonth.weekday % 7; // Sunday (7) becomes 0, Monday (1) stays 1
    final daysInMonth = lastDayOfMonth.day;

    // Get localized month name - format as "Month Year"
    final locale = Localizations.localeOf(context);
    final monthFormat = DateFormat('MMMM', locale.toString());
    final monthName = monthFormat.format(currentMonth);
    final year = currentMonth.year.toString();

    // Get localized day labels starting from Sunday
    final dayLabels = _getLocalizedDayLabels(context);

    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        children: [
          // iOS Calendar style header
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$monthName $year',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    letterSpacing: 0.37,
                  ),
                ),
              ],
            ),
          ),
          // Day labels - iOS style
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: dayLabels.map((label) => _DayLabel(label)).toList(),
            ),
          ),
          ...List.generate(
            ((daysInMonth + firstWeekday - 1) / 7).ceil(),
            (weekIndex) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(7, (dayIndex) {
                  // Calculate day number: weekIndex * 7 + dayIndex gives position in grid
                  // Subtract firstWeekday to align with actual month start
                  // Add 1 because dayIndex is 0-based but days start at 1
                  final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 1;
                  
                  if (dayNumber < 1 || dayNumber > daysInMonth) {
                    return const Expanded(child: SizedBox());
                  }

                  final date = DateTime(currentMonth.year, currentMonth.month, dayNumber);
                  final dateKey = _getDateKey(date);
                  final isCompleted = widget.completedDays.contains(dateKey);
                  final isToday = _isSameDay(date, now);
                  final isSelected = _selectedDate != null && _isSameDay(date, _selectedDate!);
                  final isFuture = date.isAfter(now) && !isToday;

                  return Expanded(
                    child: GestureDetector(
                      onTap: isFuture ? null : () {
                        setState(() {
                          _selectedDate = date;
                        });
                        widget.onDateSelected(date);
                      },
                      child: Container(
                        height: 44,
                        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        decoration: BoxDecoration(
                          color: isCompleted
                              ? Theme.of(context).colorScheme.primary
                              : isToday
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$dayNumber',
                                style: TextStyle(
                                  fontSize: isToday ? 19 : 17,
                                  fontWeight: isToday || isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                color: isCompleted
                                    ? AppColors.white
                                    : isToday
                                        ? AppColors.white
                                        : isFuture
                                            ? AppColors.lightGray
                                            : isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : AppColors.black,
                                ),
                              ),
                              if (isCompleted && !isToday)
                                const SizedBox(height: 2),
                              if (isCompleted && !isToday)
                                Container(
                                  width: 4,
                                  height: 4,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
            },
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  List<String> _getLocalizedDayLabels(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final dateFormat = DateFormat('E', locale.toString());
    
    // Get day labels starting from Sunday
    // In Dart: weekday 7 = Sunday, 1 = Monday, 2 = Tuesday, etc.
    // We want: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
    final labels = <String>[];
    
    // Create dates for each day of the week starting from Sunday
    // Jan 7, 2024 is Sunday (weekday 7)
    final baseDate = DateTime(2024, 1, 7); // Sunday
    
    for (int i = 0; i < 7; i++) {
      // Add i days to get: Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
      final date = baseDate.add(Duration(days: i));
      final dayLabel = dateFormat.format(date);
      
      // For Asian languages, use the appropriate character; for others, use first letter uppercase
      if (locale.languageCode == 'zh') {
        // For Chinese, DateFormat('E') returns "星期日", "星期一", etc.
        // We need the last character: "日", "一", "二", etc.
        labels.add(dayLabel.length > 1 ? dayLabel.substring(dayLabel.length - 1) : dayLabel);
      } else if (locale.languageCode == 'ja' || locale.languageCode == 'ko' || locale.languageCode == 'th') {
        // For other Asian languages, typically use first character
        labels.add(dayLabel.length > 1 ? dayLabel.substring(0, 1) : dayLabel);
      } else {
        labels.add(dayLabel.substring(0, 1).toUpperCase());
      }
    }
    return labels;
  }
}

class _DayLabel extends StatelessWidget {
  final String label;

  const _DayLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.gray,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}
