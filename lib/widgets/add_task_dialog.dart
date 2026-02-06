import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../constants/app_colors.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      title: Text(
        AppLocalizations.of(context)!.newTask,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ),
      content: TextField(
        controller: _controller,
        autofocus: true,
        style: const TextStyle(
          fontSize: 17,
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.taskName,
          hintStyle: const TextStyle(
            color: AppColors.gray,
          ),
          filled: true,
          fillColor: AppColors.background,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onSubmitted: (_) => _saveTask(context),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: TextStyle(
              fontSize: 17,
              color: AppColors.blue,
            ),
          ),
        ),
        TextButton(
          onPressed: () => _saveTask(context),
          child: Text(
            AppLocalizations.of(context)!.add,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
            ),
          ),
        ),
      ],
    );
  }

  void _saveTask(BuildContext context) {
    final title = _controller.text.trim();
    if (title.isNotEmpty) {
      Navigator.of(context).pop(title);
    }
  }
}
