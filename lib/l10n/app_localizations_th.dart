// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'เช็คอินรายวัน';

  @override
  String get today => 'วันนี้';

  @override
  String get yesterday => 'เมื่อวาน';

  @override
  String get tasks => 'งาน';

  @override
  String get noTasks => 'ไม่มีงาน';

  @override
  String get tapToAddTask => 'แตะ + เพื่อเพิ่มงาน';

  @override
  String get addTasksOnToday => 'เพิ่มงานในวันนี้';

  @override
  String get newTask => 'งานใหม่';

  @override
  String get editTask => 'แก้ไขงาน';

  @override
  String get taskName => 'ชื่องาน';

  @override
  String get cancel => 'ยกเลิก';

  @override
  String get add => 'เพิ่ม';

  @override
  String get save => 'บันทึก';

  @override
  String get edit => 'แก้ไข';

  @override
  String get delete => 'ลบ';

  @override
  String get createNewTask => 'สร้างงานใหม่';

  @override
  String get completed => 'เสร็จสมบูรณ์';

  @override
  String get incomplete => 'ยังไม่เสร็จ';

  @override
  String get statistics => 'สถิติ';

  @override
  String get daysCompleted => 'วันที่เสร็จสมบูรณ์';

  @override
  String get day => 'วัน';

  @override
  String get days => 'วัน';

  @override
  String get done => 'เสร็จสิ้น';

  @override
  String get history => 'ประวัติ';

  @override
  String get noHistory => 'ไม่มีประวัติ';

  @override
  String get viewHistory => 'ดูประวัติ';

  @override
  String get statisticsTooltip => 'สถิติ';

  @override
  String get addTask => 'เพิ่มงาน';

  @override
  String get editTasks => 'แก้ไขงาน';

  @override
  String get youCanOnlyAddTasksForToday =>
      'คุณสามารถเพิ่มงานได้เฉพาะวันนี้เท่านั้น!';

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
      other: 'วัน',
      one: 'วัน',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'วัน',
      one: 'วัน',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return 'วันที่ $day';
  }
}
