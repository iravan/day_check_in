import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/task.dart';
import 'services/storage_service.dart';
import 'services/date_service.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/task_list_widget.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/statistics_dialog.dart';
import 'widgets/history_dialog.dart';
import 'widgets/debug_date_controls.dart';
import 'widgets/celebration_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day Check In',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Indigo
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateService.now;
  List<Task> _tasks = [];
  Set<String> _completedDays = {};
  bool _isLoading = true;
  String? _lastCelebratedDate;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadTasks();
    await _loadCompletedDays();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadTasks() async {
    final tasks = await StorageService.getTasksForDate(_selectedDate);
    setState(() {
      _tasks = tasks;
    });
  }

  Future<void> _loadCompletedDays() async {
    final completedDays = await StorageService.getCompletedDays();
    setState(() {
      _completedDays = completedDays;
    });
  }

  Future<void> _onDateSelected(DateTime date) async {
    setState(() {
      _selectedDate = date;
    });
    await _loadTasks();
  }

  Future<void> _addTask() async {
    final now = DateService.now;
    final isToday = _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;

    if (!isToday) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.white),
              SizedBox(width: 12),
              Text('You can only add tasks for today!'),
            ],
          ),
          backgroundColor: Colors.orange.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    final title = await showDialog<String>(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );

    if (title != null && title.isNotEmpty) {
      final now = DateService.now;
      final newTask = Task(
        id: now.millisecondsSinceEpoch.toString(),
        title: title,
        createdAt: now,
      );

      // Add to global tasks
      await StorageService.addTask(newTask);
      
      // Reload tasks for current date to show the new task
      await _loadTasks();
      await _loadCompletedDays();
    }
  }

  Future<void> _toggleTask(Task task) async {
    final newCompletionStatus = !task.isCompleted;
    final now = DateService.now;
    final isToday = _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
    
    // Update local state immediately for better UX
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task.copyWith(isCompleted: newCompletionStatus);
      }
    });

    // Save completion status for this date
    await StorageService.toggleTaskCompletion(_selectedDate, task.id, newCompletionStatus);
    await _loadCompletedDays();
    
    // Check if all tasks are completed for today
    if (isToday && newCompletionStatus) {
      final allCompleted = _tasks.isNotEmpty && 
          _tasks.every((t) => t.isCompleted);
      final todayKey = _getDateKey(now);
      
      // Show celebration if all tasks completed and we haven't shown it today
      if (allCompleted && _lastCelebratedDate != todayKey) {
        _lastCelebratedDate = todayKey;
        // Haptic feedback for celebration
        HapticFeedback.heavyImpact();
        // Small delay to let the UI update first
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const CelebrationDialog(),
            );
          }
        });
      }
    }
  }
  
  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _deleteTask(Task task) async {
    // Delete from global tasks
    await StorageService.deleteTask(task.id);
    
    // Reload tasks for current date
    await _loadTasks();
    await _loadCompletedDays();
  }

  void _showStatistics() {
    showDialog(
      context: context,
      builder: (context) => const StatisticsDialog(),
    );
  }

  void _showHistory() {
    showDialog(
      context: context,
      builder: (context) => const HistoryDialog(),
    );
  }

  void _onDateSimulated() {
    setState(() {
      _selectedDate = DateService.now;
    });
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateService.now;
    final currentMonth = DateTime(now.year, now.month);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Day Check In',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _showHistory,
            tooltip: 'View History',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: _showStatistics,
            tooltip: 'Statistics',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                DebugDateControls(
                  onDateChanged: _onDateSimulated,
                ),
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: CalendarWidget(
                      currentMonth: currentMonth,
                      onDateSelected: _onDateSelected,
                      completedDays: _completedDays,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  flex: 3,
                  child: TaskListWidget(
                    tasks: _tasks,
                    onTaskToggle: _toggleTask,
                    onTaskDelete: _deleteTask,
                    selectedDate: _selectedDate,
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addTask,
        tooltip: 'Add Task',
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
        elevation: 2,
      ),
    );
  }
}
