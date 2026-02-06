import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../services/storage_service.dart';
import '../constants/app_colors.dart';

class HistoryDialog extends StatefulWidget {
  const HistoryDialog({super.key});

  @override
  State<HistoryDialog> createState() => _HistoryDialogState();
}

class _HistoryDialogState extends State<HistoryDialog> {
  Map<String, List<String>> _monthHistory = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final completedDays = await StorageService.getCompletedDays();
    final Map<String, List<String>> grouped = {};

    for (final day in completedDays) {
      final parts = day.split('-');
      if (parts.length == 3) {
        final monthKey = '${parts[0]}-${parts[1]}';
        if (!grouped.containsKey(monthKey)) {
          grouped[monthKey] = [];
        }
        grouped[monthKey]!.add(day);
      }
    }

    // Sort months descending
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    final sortedMap = <String, List<String>>{};
    for (final key in sortedKeys) {
      sortedMap[key] = grouped[key]!..sort((a, b) => b.compareTo(a));
    }

    setState(() {
      _monthHistory = sortedMap;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // iOS style header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.history,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      letterSpacing: 0.37,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.blue),
                    onPressed: () => Navigator.of(context).pop(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.divider),
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_monthHistory.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 48,
                        color: AppColors.lightGray,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.noHistory,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppColors.gray,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: Container(
                  color: AppColors.background,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _monthHistory.length,
                    itemBuilder: (context, index) {
                      final monthKey = _monthHistory.keys.elementAt(index);
                      final days = _monthHistory[monthKey]!;
                      final monthName = _getMonthName(monthKey);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.white,
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          leading: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            monthName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ),
                          subtitle: Text(
                            AppLocalizations.of(context)!.monthHistoryDays(days.length),
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.gray,
                            ),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(0),
                            ),
                          ),
                          children: [
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: days.map((day) {
                                final formattedDate = _formatDate(day);
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: AppColors.green,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        formattedDate,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String monthKey) {
    final parts = monthKey.split('-');
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final locale = Localizations.localeOf(context);
    final date = DateTime(year, month, 1);
    // Use yMMMM format which gives locale-appropriate "Year Month" format
    // e.g., "January 2024" for English, "2024年1月" for Chinese
    final dateFormat = DateFormat.yMMMM(locale.toString());
    return dateFormat.format(date);
  }

  String _formatDate(String dateString) {
    final parts = dateString.split('-');
    if (parts.length != 3) return dateString;
    
    final year = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final day = int.parse(parts[2]);
    final date = DateTime(year, month, day);
    final locale = Localizations.localeOf(context);
    
    // Use localized date format (e.g., "MMMM d" for "January 15" or "M月d日" for "1月15日")
    final dateFormat = DateFormat('MMMM d', locale.toString());
    return dateFormat.format(date);
  }
}
