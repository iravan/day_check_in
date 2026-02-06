import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'models/task.dart';
import 'services/storage_service.dart';
import 'services/date_service.dart';
import 'services/theme_service.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/task_list_widget.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/statistics_dialog.dart';
import 'widgets/history_dialog.dart';
import 'widgets/debug_date_controls.dart';
import 'widgets/celebration_dialog.dart';
import 'widgets/color_theme_picker.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeService _themeService = ThemeService();

  @override
  void initState() {
    super.initState();
    _themeService.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _themeService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Day Check In',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', 'CN'), // Simplified Chinese
        Locale('zh', 'TW'), // Traditional Chinese (Taiwan)
        Locale('zh', 'HK'), // Traditional Chinese (Hong Kong)
        Locale('ja', ''), // Japanese
        Locale('ko', ''), // Korean
        Locale('th', ''), // Thai
      ],
      theme: ThemeData(
        // iOS color scheme with dynamic primary color
        primaryColor: _themeService.primaryColor,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: _themeService.primaryColor,
          secondary: AppColors.green,
          surface: AppColors.white,
          background: AppColors.background,
          error: AppColors.red,
          onPrimary: AppColors.white,
          onSecondary: AppColors.white,
          onSurface: AppColors.black,
          onBackground: AppColors.black,
          onError: AppColors.white,
        ),
        useMaterial3: false, // Use Material 2 for iOS look
        fontFamily: '.SF Pro Text', // iOS system font
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: AppColors.black,
            fontSize: 34,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.37,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _themeService.primaryColor,
            foregroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 0.5,
          space: 0,
        ),
      ),
      home: HomePage(themeService: _themeService),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  final ThemeService themeService;
  
  const HomePage({super.key, required this.themeService});

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndLoadData();
    });
  }

  Future<void> _initializeAndLoadData() async {
    if (!mounted) return;
    
    // Initialize default tasks first, then load data
    final localizations = AppLocalizations.of(context)!;
    final defaultTaskNames = [
      localizations.defaultTaskExercise,
      localizations.defaultTaskStudy,
      localizations.defaultTaskMeditation,
      localizations.defaultTaskHousework,
    ];
    
    await StorageService.initializeDefaultTasks(defaultTaskNames);
    
    // Now load tasks and completed days
    if (mounted) {
      await _loadTasks();
      await _loadCompletedDays();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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

  Future<void> _editTask(Task task, String newTitle) async {
    final updatedTask = task.copyWith(title: newTitle);
    await StorageService.updateTask(updatedTask);
    
    // Reload tasks for current date
    await _loadTasks();
    await _loadCompletedDays();
  }

  Future<void> _createTask(String title) async {
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

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.palette,
              color: widget.themeService.primaryColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ColorThemePicker(
                  themeService: widget.themeService,
                ),
              );
            },
            tooltip: 'Color Theme',
          ),
          IconButton(
            icon: Icon(
              Icons.history,
              color: widget.themeService.primaryColor,
            ),
            onPressed: _showHistory,
            tooltip: AppLocalizations.of(context)!.viewHistory,
          ),
          IconButton(
            icon: Icon(
              Icons.bar_chart,
              color: widget.themeService.primaryColor,
            ),
            onPressed: _showStatistics,
            tooltip: AppLocalizations.of(context)!.statisticsTooltip,
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  DebugDateControls(
                    onDateChanged: _onDateSimulated,
                  ),
                  Flexible(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: CalendarWidget(
                        currentMonth: currentMonth,
                        onDateSelected: _onDateSelected,
                        completedDays: _completedDays,
                      ),
                    ),
                  ),
                  Container(
                    height: 0.5,
                    color: theme.dividerTheme.color,
                  ),
                  Flexible(
                    flex: 3,
                    child: TaskListWidget(
                      tasks: _tasks,
                      onTaskToggle: _toggleTask,
                      onTaskDelete: _deleteTask,
                      onTaskEdit: _editTask,
                      onCreateTask: _createTask,
                      selectedDate: _selectedDate,
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: AppLocalizations.of(context)!.addTask,
        backgroundColor: widget.themeService.primaryColor,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
