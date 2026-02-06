import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_th.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
    Locale('th'),
    Locale('zh'),
    Locale('zh', 'CN'),
    Locale('zh', 'HK'),
    Locale('zh', 'TW'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Day Check In'**
  String get appTitle;

  /// Label for today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Label for yesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Label for tasks section
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// Message when there are no tasks
  ///
  /// In en, this message translates to:
  /// **'No Tasks'**
  String get noTasks;

  /// Hint to add a task
  ///
  /// In en, this message translates to:
  /// **'Tap + to add a task'**
  String get tapToAddTask;

  /// Hint to add tasks on today
  ///
  /// In en, this message translates to:
  /// **'Add tasks on today\'s date'**
  String get addTasksOnToday;

  /// Title for new task dialog
  ///
  /// In en, this message translates to:
  /// **'New Task'**
  String get newTask;

  /// Title for edit task dialog
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// Placeholder for task name input
  ///
  /// In en, this message translates to:
  /// **'Task name'**
  String get taskName;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Add button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Edit action
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Create new task action
  ///
  /// In en, this message translates to:
  /// **'Create New Task'**
  String get createNewTask;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Incomplete status
  ///
  /// In en, this message translates to:
  /// **'Incomplete'**
  String get incomplete;

  /// Statistics dialog title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Days completed label
  ///
  /// In en, this message translates to:
  /// **'Days Completed'**
  String get daysCompleted;

  /// Singular day
  ///
  /// In en, this message translates to:
  /// **'day'**
  String get day;

  /// Plural days
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// History dialog title
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// Message when there is no history
  ///
  /// In en, this message translates to:
  /// **'No History'**
  String get noHistory;

  /// View history tooltip
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// Statistics tooltip
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTooltip;

  /// Add task tooltip
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// Edit tasks tooltip
  ///
  /// In en, this message translates to:
  /// **'Edit Tasks'**
  String get editTasks;

  /// Error message when trying to add tasks for non-today
  ///
  /// In en, this message translates to:
  /// **'You can only add tasks for today!'**
  String get youCanOnlyAddTasksForToday;

  /// Month names
  ///
  /// In en, this message translates to:
  /// **'{month}'**
  String monthNames(String month);

  /// Day of month
  ///
  /// In en, this message translates to:
  /// **'{day}'**
  String dayOfMonth(int day);

  /// Day label (S, M, T, etc.)
  ///
  /// In en, this message translates to:
  /// **'{day}'**
  String dayLabel(String day);

  /// Task completion count
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total}'**
  String taskCount(int completed, int total);

  /// Completed days count with plural
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{day} other{days}}'**
  String completedDaysCount(int count);

  /// Month history days count
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{day} other{days}}'**
  String monthHistoryDays(int count);

  /// Day number label
  ///
  /// In en, this message translates to:
  /// **'Day {day}'**
  String dayNumber(String day);

  /// Default task: Exercise
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get defaultTaskExercise;

  /// Default task: Study
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get defaultTaskStudy;

  /// Default task: Meditation
  ///
  /// In en, this message translates to:
  /// **'Meditation'**
  String get defaultTaskMeditation;

  /// Default task: Housework
  ///
  /// In en, this message translates to:
  /// **'Housework'**
  String get defaultTaskHousework;

  /// Color theme picker dialog title
  ///
  /// In en, this message translates to:
  /// **'Choose Color Theme'**
  String get chooseColorTheme;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Celebration dialog title
  ///
  /// In en, this message translates to:
  /// **'🎉 Congratulations! 🎉'**
  String get congratulations;

  /// Message when all tasks are completed
  ///
  /// In en, this message translates to:
  /// **'All tasks completed for today!'**
  String get allTasksCompletedToday;

  /// Encouragement message
  ///
  /// In en, this message translates to:
  /// **'Keep up the great work! 💪'**
  String get keepUpGreatWork;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko', 'th', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
          case 'HK':
            return AppLocalizationsZhHk();
          case 'TW':
            return AppLocalizationsZhTw();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'th':
      return AppLocalizationsTh();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
