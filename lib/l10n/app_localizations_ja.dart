// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '日次チェックイン';

  @override
  String get today => '今日';

  @override
  String get yesterday => '昨日';

  @override
  String get tasks => 'タスク';

  @override
  String get noTasks => 'タスクなし';

  @override
  String get tapToAddTask => '+ をタップしてタスクを追加';

  @override
  String get addTasksOnToday => '今日の日付にタスクを追加';

  @override
  String get newTask => '新しいタスク';

  @override
  String get editTask => 'タスクを編集';

  @override
  String get taskName => 'タスク名';

  @override
  String get cancel => 'キャンセル';

  @override
  String get add => '追加';

  @override
  String get save => '保存';

  @override
  String get edit => '編集';

  @override
  String get delete => '削除';

  @override
  String get createNewTask => '新しいタスクを作成';

  @override
  String get completed => '完了';

  @override
  String get incomplete => '未完了';

  @override
  String get statistics => '統計';

  @override
  String get daysCompleted => '完了日数';

  @override
  String get day => '日';

  @override
  String get days => '日';

  @override
  String get done => '完了';

  @override
  String get history => '履歴';

  @override
  String get noHistory => '履歴なし';

  @override
  String get viewHistory => '履歴を表示';

  @override
  String get statisticsTooltip => '統計';

  @override
  String get addTask => 'タスクを追加';

  @override
  String get editTasks => 'タスクを編集';

  @override
  String get youCanOnlyAddTasksForToday => '今日の日付にのみタスクを追加できます！';

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
      other: '日',
      one: '日',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '日',
      one: '日',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '$day日目';
  }

  @override
  String get defaultTaskExercise => '運動';

  @override
  String get defaultTaskStudy => '勉強';

  @override
  String get defaultTaskMeditation => '瞑想';

  @override
  String get defaultTaskHousework => '家事';

  @override
  String get chooseColorTheme => 'カラーテーマを選択';

  @override
  String get close => '閉じる';

  @override
  String get congratulations => '🎉 おめでとうございます！🎉';

  @override
  String get allTasksCompletedToday => '今日のすべてのタスクが完了しました！';

  @override
  String get keepUpGreatWork => 'この調子で頑張ってください！💪';
}
