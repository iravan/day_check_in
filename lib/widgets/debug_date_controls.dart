import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../services/date_service.dart';

/// Debug widget for simulating date changes (only visible in debug mode)
class DebugDateControls extends StatefulWidget {
  final VoidCallback onDateChanged;

  const DebugDateControls({
    super.key,
    required this.onDateChanged,
  });

  @override
  State<DebugDateControls> createState() => _DebugDateControlsState();
}

class _DebugDateControlsState extends State<DebugDateControls> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    // Only show in debug mode
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    final simulatedDate = DateService.simulatedDate;
    final currentDate = DateService.now;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Toggle button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.orange,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                tooltip: _isVisible ? 'Hide Debug Controls' : 'Show Debug Controls',
              ),
              if (!_isVisible)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isVisible = true;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bug_report, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        simulatedDate != null
                            ? 'Simulated: ${_formatDate(simulatedDate)}'
                            : 'Real Date: ${_formatDate(currentDate)}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        // Controls (shown when visible)
        if (_isVisible)
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              border: Border.all(color: Colors.orange, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bug_report, size: 16, color: Colors.orange),
                    const SizedBox(width: 4),
                    Text(
                      simulatedDate != null
                          ? 'Simulated: ${_formatDate(simulatedDate)}'
                          : 'Real Date: ${_formatDate(currentDate)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  alignment: WrapAlignment.center,
                  children: [
                    _buildButton(
                      '-7',
                      () => _shiftDays(-7),
                      Icons.remove,
                    ),
                    _buildButton(
                      '-1',
                      () => _shiftDays(-1),
                      Icons.arrow_back,
                    ),
                    _buildButton(
                      'Today',
                      _resetDate,
                      Icons.today,
                    ),
                    _buildButton(
                      '+1',
                      () => _shiftDays(1),
                      Icons.arrow_forward,
                    ),
                    _buildButton(
                      '+7',
                      () => _shiftDays(7),
                      Icons.add,
                    ),
                    _buildButton(
                      'Pick',
                      _pickDate,
                      Icons.calendar_today,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed, IconData icon) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: const Size(0, 32),
        textStyle: const TextStyle(fontSize: 12),
      ),
    );
  }

  void _shiftDays(int days) {
    DateService.shiftDays(days);
    widget.onDateChanged();
    setState(() {});
  }

  void _resetDate() {
    DateService.reset();
    widget.onDateChanged();
    setState(() {});
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateService.now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      DateService.setSimulatedDate(picked);
      widget.onDateChanged();
      setState(() {});
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
