import 'package:flutter/material.dart';
import '../services/storage_service.dart';

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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                const Text(
                  'History',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              thickness: 1,
              color: Colors.grey.shade200,
            ),
            if (_isLoading)
              const Expanded(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_monthHistory.isEmpty)
              const Expanded(
                child: Center(
                  child: Text(
                    'No completed days yet.\nComplete all tasks for a day to see it here!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _monthHistory.length,
                  itemBuilder: (context, index) {
                    final monthKey = _monthHistory.keys.elementAt(index);
                    final days = _monthHistory[monthKey]!;
                    final monthName = _getMonthName(monthKey);

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade200),
                      ),
                      child: ExpansionTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.green.shade600,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          monthName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            '${days.length} completed ${days.length == 1 ? 'day' : 'days'}',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: days.map((day) {
                                final parts = day.split('-');
                                final dayNumber = parts[2];
                                return Chip(
                                  avatar: Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Colors.green.shade600,
                                  ),
                                  label: Text(
                                    'Day $dayNumber',
                                    style: const TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  backgroundColor: Colors.green.shade50,
                                  side: BorderSide(color: Colors.green.shade200),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(String monthKey) {
    final parts = monthKey.split('-');
    final year = parts[0];
    final month = int.parse(parts[1]);
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${monthNames[month - 1]} $year';
  }
}
