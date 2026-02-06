import 'package:flutter/foundation.dart';

/// Service to manage the current date, allowing simulation in debug mode
class DateService {
  static DateTime? _simulatedDate;

  /// Get the current date (or simulated date in debug mode)
  static DateTime get now {
    if (kDebugMode && _simulatedDate != null) {
      return _simulatedDate!;
    }
    return DateTime.now();
  }

  /// Set a simulated date (only works in debug mode)
  static void setSimulatedDate(DateTime? date) {
    if (kDebugMode) {
      _simulatedDate = date;
    }
  }

  /// Get the simulated date (null if not set)
  static DateTime? get simulatedDate => _simulatedDate;

  /// Reset to use real current date
  static void reset() {
    _simulatedDate = null;
  }

  /// Shift the simulated date by a number of days
  static void shiftDays(int days) {
    if (kDebugMode) {
      final current = _simulatedDate ?? DateTime.now();
      _simulatedDate = current.add(Duration(days: days));
    }
  }
}
