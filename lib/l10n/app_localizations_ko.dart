// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '일일 체크인';

  @override
  String get today => '오늘';

  @override
  String get yesterday => '어제';

  @override
  String get tasks => '작업';

  @override
  String get noTasks => '작업 없음';

  @override
  String get tapToAddTask => '+를 탭하여 작업 추가';

  @override
  String get addTasksOnToday => '오늘 날짜에 작업 추가';

  @override
  String get newTask => '새 작업';

  @override
  String get editTask => '작업 편집';

  @override
  String get taskName => '작업 이름';

  @override
  String get cancel => '취소';

  @override
  String get add => '추가';

  @override
  String get save => '저장';

  @override
  String get edit => '편집';

  @override
  String get delete => '삭제';

  @override
  String get createNewTask => '새 작업 만들기';

  @override
  String get completed => '완료됨';

  @override
  String get incomplete => '미완료';

  @override
  String get statistics => '통계';

  @override
  String get daysCompleted => '완료된 일수';

  @override
  String get day => '일';

  @override
  String get days => '일';

  @override
  String get done => '완료';

  @override
  String get history => '기록';

  @override
  String get noHistory => '기록 없음';

  @override
  String get viewHistory => '기록 보기';

  @override
  String get statisticsTooltip => '통계';

  @override
  String get addTask => '작업 추가';

  @override
  String get editTasks => '작업 편집';

  @override
  String get youCanOnlyAddTasksForToday => '오늘 날짜에만 작업을 추가할 수 있습니다!';

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
      other: '일',
      one: '일',
    );
    return '$count $_temp0';
  }

  @override
  String monthHistoryDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '일',
      one: '일',
    );
    return '$count $_temp0';
  }

  @override
  String dayNumber(String day) {
    return '$day일';
  }

  @override
  String get defaultTaskExercise => '운동';

  @override
  String get defaultTaskStudy => '공부';

  @override
  String get defaultTaskMeditation => '명상';

  @override
  String get defaultTaskHousework => '집안일';

  @override
  String get chooseColorTheme => '색상 테마 선택';

  @override
  String get close => '닫기';

  @override
  String get congratulations => '🎉 축하합니다! 🎉';

  @override
  String get allTasksCompletedToday => '오늘의 모든 작업이 완료되었습니다!';

  @override
  String get keepUpGreatWork => '계속 잘하세요! 💪';
}
