// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '每日打卡';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tasks => '任务';

  @override
  String get noTasks => '没有任务';

  @override
  String get tapToAddTask => '点击 + 添加任务';

  @override
  String get addTasksOnToday => '在今天添加任务';

  @override
  String get newTask => '新任务';

  @override
  String get editTask => '编辑任务';

  @override
  String get taskName => '任务名称';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get createNewTask => '创建新任务';

  @override
  String get completed => '已完成';

  @override
  String get incomplete => '未完成';

  @override
  String get statistics => '统计';

  @override
  String get daysCompleted => '完成天数';

  @override
  String get day => '天';

  @override
  String get days => '天';

  @override
  String get done => '完成';

  @override
  String get history => '历史';

  @override
  String get noHistory => '没有历史记录';

  @override
  String get viewHistory => '查看历史';

  @override
  String get statisticsTooltip => '统计';

  @override
  String get addTask => '添加任务';

  @override
  String get editTasks => '编辑任务';

  @override
  String get youCanOnlyAddTasksForToday => '您只能为今天添加任务！';

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
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '第 $day 天';
  }
}

/// The translations for Chinese, as used in China (`zh_CN`).
class AppLocalizationsZhCn extends AppLocalizationsZh {
  AppLocalizationsZhCn() : super('zh_CN');

  @override
  String get appTitle => '每日打卡';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tasks => '任务';

  @override
  String get noTasks => '没有任务';

  @override
  String get tapToAddTask => '点击 + 添加任务';

  @override
  String get addTasksOnToday => '在今天添加任务';

  @override
  String get newTask => '新任务';

  @override
  String get editTask => '编辑任务';

  @override
  String get taskName => '任务名称';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get save => '保存';

  @override
  String get edit => '编辑';

  @override
  String get delete => '删除';

  @override
  String get createNewTask => '创建新任务';

  @override
  String get completed => '已完成';

  @override
  String get incomplete => '未完成';

  @override
  String get statistics => '统计';

  @override
  String get daysCompleted => '完成天数';

  @override
  String get day => '天';

  @override
  String get days => '天';

  @override
  String get done => '完成';

  @override
  String get history => '历史';

  @override
  String get noHistory => '没有历史记录';

  @override
  String get viewHistory => '查看历史';

  @override
  String get statisticsTooltip => '统计';

  @override
  String get addTask => '添加任务';

  @override
  String get editTasks => '编辑任务';

  @override
  String get youCanOnlyAddTasksForToday => '您只能为今天添加任务！';

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
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '第 $day 天';
  }
}

/// The translations for Chinese, as used in Hong Kong (`zh_HK`).
class AppLocalizationsZhHk extends AppLocalizationsZh {
  AppLocalizationsZhHk() : super('zh_HK');

  @override
  String get appTitle => '每日打卡';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tasks => '任務';

  @override
  String get noTasks => '沒有任務';

  @override
  String get tapToAddTask => '點擊 + 新增任務';

  @override
  String get addTasksOnToday => '在今天新增任務';

  @override
  String get newTask => '新任務';

  @override
  String get editTask => '編輯任務';

  @override
  String get taskName => '任務名稱';

  @override
  String get cancel => '取消';

  @override
  String get add => '新增';

  @override
  String get save => '儲存';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get createNewTask => '建立新任務';

  @override
  String get completed => '已完成';

  @override
  String get incomplete => '未完成';

  @override
  String get statistics => '統計';

  @override
  String get daysCompleted => '完成天數';

  @override
  String get day => '天';

  @override
  String get days => '天';

  @override
  String get done => '完成';

  @override
  String get history => '歷史記錄';

  @override
  String get noHistory => '沒有歷史記錄';

  @override
  String get viewHistory => '查看歷史記錄';

  @override
  String get statisticsTooltip => '統計';

  @override
  String get addTask => '新增任務';

  @override
  String get editTasks => '編輯任務';

  @override
  String get youCanOnlyAddTasksForToday => '您只能為今天新增任務！';

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
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '第 $day 天';
  }
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw() : super('zh_TW');

  @override
  String get appTitle => '每日打卡';

  @override
  String get today => '今天';

  @override
  String get yesterday => '昨天';

  @override
  String get tasks => '任務';

  @override
  String get noTasks => '沒有任務';

  @override
  String get tapToAddTask => '點擊 + 新增任務';

  @override
  String get addTasksOnToday => '在今天新增任務';

  @override
  String get newTask => '新任務';

  @override
  String get editTask => '編輯任務';

  @override
  String get taskName => '任務名稱';

  @override
  String get cancel => '取消';

  @override
  String get add => '新增';

  @override
  String get save => '儲存';

  @override
  String get edit => '編輯';

  @override
  String get delete => '刪除';

  @override
  String get createNewTask => '建立新任務';

  @override
  String get completed => '已完成';

  @override
  String get incomplete => '未完成';

  @override
  String get statistics => '統計';

  @override
  String get daysCompleted => '完成天數';

  @override
  String get day => '天';

  @override
  String get days => '天';

  @override
  String get done => '完成';

  @override
  String get history => '歷史記錄';

  @override
  String get noHistory => '沒有歷史記錄';

  @override
  String get viewHistory => '查看歷史記錄';

  @override
  String get statisticsTooltip => '統計';

  @override
  String get addTask => '新增任務';

  @override
  String get editTasks => '編輯任務';

  @override
  String get youCanOnlyAddTasksForToday => '您只能為今天新增任務！';

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
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '天',
      one: '天',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '第 $day 天';
  }
}
