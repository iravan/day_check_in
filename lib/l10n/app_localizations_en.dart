// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Day Check In';

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tasks => 'Tasks';

  @override
  String get noTasks => 'No Tasks';

  @override
  String get tapToAddTask => 'Tap + to add a task';

  @override
  String get addTasksOnToday => 'Add tasks on today\'s date';

  @override
  String get newTask => 'New Task';

  @override
  String get editTask => 'Edit Task';

  @override
  String get taskName => 'Task name';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get save => 'Save';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get createNewTask => 'Create New Task';

  @override
  String get completed => 'Completed';

  @override
  String get incomplete => 'Incomplete';

  @override
  String get statistics => 'Statistics';

  @override
  String get daysCompleted => 'Days Completed';

  @override
  String get day => 'day';

  @override
  String get days => 'days';

  @override
  String get done => 'Done';

  @override
  String get history => 'History';

  @override
  String get noHistory => 'No History';

  @override
  String get viewHistory => 'View History';

  @override
  String get statisticsTooltip => 'Statistics';

  @override
  String get addTask => 'Add Task';

  @override
  String get editTasks => 'Edit Tasks';

  @override
  String get youCanOnlyAddTasksForToday => 'You can only add tasks for today!';

  @override
  String monthNames(String month) {
    return '$month';
  }

  @override
  String dayOfMonth(int day) {
    return '$day';
  }

  @override
  String dayLabel(String day) {
    return '$day';
  }

  @override
  String taskCount(int completed, int total) {
    return '$completed/$total';
  }

  @override
  String completedDaysCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return 'Day $day';
  }

  @override
  String get defaultTaskExercise => 'Exercise';

  @override
  String get defaultTaskStudy => 'Study';

  @override
  String get defaultTaskMeditation => 'Meditation';

  @override
  String get defaultTaskHousework => 'Housework';

  @override
  String get chooseColorTheme => 'Choose Color Theme';

  @override
  String get close => 'Close';

  @override
  String get congratulations => '🎉 Congratulations! 🎉';

  @override
  String get allTasksCompletedToday => 'All tasks completed for today!';

  @override
  String get keepUpGreatWork => 'Keep up the great work! 💪';
}
