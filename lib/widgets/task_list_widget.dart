import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/task.dart';
import '../services/date_service.dart';
import '../constants/app_colors.dart';
import 'edit_task_dialog.dart';
import 'task_edit_menu.dart';

class TaskListWidget extends StatefulWidget {
  final List<Task> tasks;
  final Function(Task) onTaskToggle;
  final Function(Task) onTaskDelete;
  final Function(Task, String) onTaskEdit;
  final Function(String) onCreateTask;
  final DateTime selectedDate;

  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onTaskDelete,
    required this.onTaskEdit,
    required this.onCreateTask,
    required this.selectedDate,
  });

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didUpdateWidget(TaskListWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tasks.length != oldWidget.tasks.length) {
      // Reset to first page if tasks changed
      _currentPage = 0;
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showEditMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskEditMenu(
        task: widget.tasks.isNotEmpty ? widget.tasks[_currentPage] : null,
        onEdit: widget.tasks.isNotEmpty
            ? (task) async {
                final newTitle = await showDialog<String>(
                  context: context,
                  builder: (context) => EditTaskDialog(task: task),
                );
                if (newTitle != null && newTitle.isNotEmpty) {
                  widget.onTaskEdit(task, newTitle);
                }
              }
            : null,
        onDelete: widget.tasks.isNotEmpty
            ? (task) {
                widget.onTaskDelete(task);
              }
            : null,
        onCreate: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (context) => const EditTaskDialog(),
          );
          if (title != null && title.isNotEmpty) {
            widget.onCreateTask(title);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateService.now;
    final isToday =
        widget.selectedDate.year == now.year &&
        widget.selectedDate.month == now.month &&
        widget.selectedDate.day == now.day;

    return Container(
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // iOS style section header with edit button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            color: AppColors.background,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isToday
                            ? AppLocalizations.of(context)!.today
                            : _formatDate(widget.selectedDate),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                          letterSpacing: -0.08,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppLocalizations.of(context)!.tasks,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                          letterSpacing: 0.35,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit button
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                    size: 22,
                  ),
                  onPressed: _showEditMenu,
                  tooltip: AppLocalizations.of(context)!.editTasks,
                ),
                if (widget.tasks.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: widget.tasks.every((t) => t.isCompleted)
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.gray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.tasks.where((t) => t.isCompleted).length}/${widget.tasks.length}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (widget.tasks.isEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 48,
                        color: AppColors.lightGray,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.noTasks,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        isToday
                            ? AppLocalizations.of(context)!.tapToAddTask
                            : AppLocalizations.of(context)!.addTasksOnToday,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.gray,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: widget.tasks.length,
                itemBuilder: (context, index) {
                  final task = widget.tasks[index];
                  return Center(
                    child: _buildTaskCard(task, index),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(Task task, int index) {
    return GestureDetector(
      onTap: () => widget.onTaskToggle(task),
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Circle indicator
              GestureDetector(
                onTap: () => widget.onTaskToggle(task),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task.isCompleted
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    border: Border.all(
                      color: task.isCompleted
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.gray,
                      width: task.isCompleted ? 0 : 3,
                    ),
                  ),
                  child: task.isCompleted
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 40,
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CustomPaint(painter: _CircleLinesPainter()),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // Task title
              Text(
                task.title,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: task.isCompleted ? AppColors.gray : AppColors.black,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationThickness: 2,
                  decorationColor: AppColors.gray,
                ),
              ),
              const SizedBox(height: 6),
              // Task status
              Text(
                task.isCompleted
                    ? AppLocalizations.of(context)!.completed
                    : AppLocalizations.of(context)!.incomplete,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: task.isCompleted
                      ? Theme.of(context).colorScheme.primary
                      : AppColors.gray,
                ),
              ),
              const SizedBox(height: 12),
              // Page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.tasks.length,
                  (i) => Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == index
                          ? Theme.of(context).colorScheme.primary
                          : AppColors.lightGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateService.now;
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return AppLocalizations.of(context)!.today;
    } else if (dateOnly == yesterday) {
      return AppLocalizations.of(context)!.yesterday;
    } else {
      // Use DateFormat for localized month names
      final locale = Localizations.localeOf(context).toString();
      final dateFormat = DateFormat('MMMM d', locale);
      return dateFormat.format(date);
    }
  }
}

// Custom painter for drawing lines in incomplete circle
class _CircleLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gray
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 6;

    // Draw horizontal line
    canvas.drawLine(
      Offset(center.dx - radius * 0.4, center.dy),
      Offset(center.dx + radius * 0.4, center.dy),
      paint,
    );

    // Draw vertical line
    canvas.drawLine(
      Offset(center.dx, center.dy - radius * 0.4),
      Offset(center.dx, center.dy + radius * 0.4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
