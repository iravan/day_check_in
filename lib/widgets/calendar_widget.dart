import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
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
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

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
                  '${monthNames[currentMonth.month - 1]} ${currentMonth.year}',
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DayLabel('S'),
                _DayLabel('M'),
                _DayLabel('T'),
                _DayLabel('W'),
                _DayLabel('T'),
                _DayLabel('F'),
                _DayLabel('S'),
              ],
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
                  final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 2;
                  
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
                              ? AppColors.blue
                              : isToday
                                  ? AppColors.blue
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
                                                ? AppColors.blue
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
