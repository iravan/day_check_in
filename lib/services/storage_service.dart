import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String _globalTasksKey = 'global_tasks';
  static const String _completionsKey = 'task_completions';
  static const String _completedDaysKey = 'completed_days';

  // Get all global tasks
  static Future<List<Task>> getAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_globalTasksKey);
    
    if (tasksJson == null) return [];
    
    final List<dynamic> tasksList = json.decode(tasksJson);
    return tasksList.map((task) => Task.fromJson(task)).toList();
  }

  // Save all global tasks
  static Future<void> saveAllTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = json.encode(tasks.map((task) => task.toJson()).toList());
    await prefs.setString(_globalTasksKey, tasksJson);
  }

  // Get tasks for a specific date (with completion status for that date)
  static Future<List<Task>> getTasksForDate(DateTime date) async {
    final allTasks = await getAllTasks();
    final completions = await getCompletionsForDate(date);
    
    // Return tasks with completion status for this date
    return allTasks.map((task) {
      final isCompleted = completions.contains(task.id);
      return task.copyWith(isCompleted: isCompleted);
    }).toList();
  }

  // Get completion status for a specific date
  static Future<Set<String>> getCompletionsForDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = _getDateKey(date);
    final completionsJson = prefs.getString('$_completionsKey$dateKey');
    
    if (completionsJson == null) return {};
    
    final List<dynamic> completionsList = json.decode(completionsJson);
    return completionsList.map((id) => id.toString()).toSet();
  }

  // Toggle completion status for a task on a specific date
  static Future<void> toggleTaskCompletion(DateTime date, String taskId, bool isCompleted) async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = _getDateKey(date);
    final completions = await getCompletionsForDate(date);
    
    if (isCompleted) {
      completions.add(taskId);
    } else {
      completions.remove(taskId);
    }
    
    final completionsJson = json.encode(completions.toList());
    await prefs.setString('$_completionsKey$dateKey', completionsJson);
    
    // Update completed days tracking
    await _updateCompletedDays(date);
  }

  // Add a new global task
  static Future<void> addTask(Task task) async {
    final tasks = await getAllTasks();
    tasks.add(task);
    await saveAllTasks(tasks);
  }

  // Update a global task
  static Future<void> updateTask(Task updatedTask) async {
    final tasks = await getAllTasks();
    final index = tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      tasks[index] = updatedTask;
      await saveAllTasks(tasks);
    }
  }

  // Delete a global task
  static Future<void> deleteTask(String taskId) async {
    final tasks = await getAllTasks();
    tasks.removeWhere((task) => task.id == taskId);
    await saveAllTasks(tasks);
    
    // Also remove from all completion records
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith(_completionsKey)) {
        final completionsJson = prefs.getString(key);
        if (completionsJson != null) {
          final List<dynamic> completionsList = json.decode(completionsJson);
          final completions = completionsList.map((id) => id.toString()).toSet();
          completions.remove(taskId);
          await prefs.setString(key, json.encode(completions.toList()));
        }
      }
    }
  }

  // Update completed days tracking
  static Future<void> _updateCompletedDays(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final dateKey = _getDateKey(date);
    final allTasks = await getAllTasks();
    final completions = await getCompletionsForDate(date);
    
    // Check if all tasks are completed for this date
    final allCompleted = allTasks.isNotEmpty && 
        allTasks.every((task) => completions.contains(task.id));
    
    final completedDays = await getCompletedDays();
    
    if (allCompleted) {
      completedDays.add(dateKey);
    } else {
      completedDays.remove(dateKey);
    }
    
    await prefs.setString(_completedDaysKey, json.encode(completedDays.toList()));
  }

  // Get all completed days
  static Future<Set<String>> getCompletedDays() async {
    final prefs = await SharedPreferences.getInstance();
    final completedDaysJson = prefs.getString(_completedDaysKey);
    
    if (completedDaysJson == null) return {};
    
    final List<dynamic> daysList = json.decode(completedDaysJson);
    return daysList.map((day) => day.toString()).toSet();
  }

  // Get count of completed days
  static Future<int> getCompletedDaysCount() async {
    final completedDays = await getCompletedDays();
    return completedDays.length;
  }

  // Get completed days for a specific month
  static Future<List<String>> getCompletedDaysForMonth(DateTime month) async {
    final completedDays = await getCompletedDays();
    final monthKey = '${month.year}-${month.month.toString().padLeft(2, '0')}';
    
    return completedDays.where((day) => day.startsWith(monthKey)).toList();
  }

  // Initialize default tasks if this is the first launch
  static Future<void> initializeDefaultTasks(List<String> defaultTaskNames) async {
    final existingTasks = await getAllTasks();
    
    // Only initialize if no tasks exist
    if (existingTasks.isEmpty) {
      final now = DateTime.now();
      final defaultTasks = defaultTaskNames.map((name) {
        return Task(
          id: 'default_${name}_${now.millisecondsSinceEpoch}_${defaultTaskNames.indexOf(name)}',
          title: name,
          createdAt: now,
        );
      }).toList();
      
      await saveAllTasks(defaultTasks);
    }
  }

  // Helper to get date key in format YYYY-MM-DD
  static String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
