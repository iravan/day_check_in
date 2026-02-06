import 'package:flutter/material.dart';
import '../services/date_service.dart';

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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Text(
            '${monthNames[currentMonth.month - 1]} ${currentMonth.year}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _DayLabel('Mon'),
            _DayLabel('Tue'),
            _DayLabel('Wed'),
            _DayLabel('Thu'),
            _DayLabel('Fri'),
            _DayLabel('Sat'),
            _DayLabel('Sun'),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(
          ((daysInMonth + firstWeekday - 1) / 7).ceil(),
          (weekIndex) {
            return Row(
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
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: isFuture ? null : () {
                            setState(() {
                              _selectedDate = date;
                            });
                            widget.onDateSelected(date);
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: isCompleted
                                  ? LinearGradient(
                                      colors: [
                                        Colors.green.shade400.withOpacity(0.3),
                                        Colors.green.shade500.withOpacity(0.2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: isCompleted
                                  ? null
                                  : isSelected
                                      ? Theme.of(context).colorScheme.primaryContainer
                                      : isToday
                                          ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                                          : Colors.transparent,
                              border: Border.all(
                                color: isToday
                                    ? Theme.of(context).colorScheme.primary
                                    : isSelected
                                        ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                                        : Colors.grey.withOpacity(0.2),
                                width: isToday ? 2.5 : isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isCompleted
                                  ? [
                                      BoxShadow(
                                        color: Colors.green.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 0,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$dayNumber',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: isToday || isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isCompleted
                                        ? Colors.green.shade700
                                        : isFuture
                                            ? Colors.grey.withOpacity(0.4)
                                            : isToday || isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : null,
                                  ),
                                ),
                                if (isCompleted)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.check_circle,
                                      size: 14,
                                      color: Colors.green.shade600,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ],
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
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
