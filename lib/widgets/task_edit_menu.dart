import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/task.dart';
import '../constants/app_colors.dart';

class TaskEditMenu extends StatelessWidget {
  final Task? task; // null for "create new task"
  final Function(Task)? onEdit;
  final Function(Task)? onDelete;
  final VoidCallback? onCreate;

  const TaskEditMenu({
    super.key,
    this.task,
    this.onEdit,
    this.onDelete,
    this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (task != null) ...[
            ListTile(
              leading: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              title: Text(
                AppLocalizations.of(context)!.edit,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onEdit?.call(task!);
              },
            ),
            const Divider(height: 1, color: AppColors.divider),
            ListTile(
              leading: const Icon(Icons.delete, color: AppColors.red),
              title: Text(
                AppLocalizations.of(context)!.delete,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.red,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onDelete?.call(task!);
              },
            ),
          ] else if (onCreate != null) ...[
            ListTile(
              leading: Icon(Icons.add, color: Theme.of(context).colorScheme.primary),
              title: Text(
                AppLocalizations.of(context)!.createNewTask,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onCreate?.call();
              },
            ),
          ],
        ],
      ),
    );
  }
}
