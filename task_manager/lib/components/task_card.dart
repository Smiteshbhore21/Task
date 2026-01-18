import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_model.dart';
import 'tag_pill.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final void Function(Task) onEdit;
  final Future<void> Function(Task) onToggleComplete;
  final VoidCallback onOpenOptions;

  const TaskCard({
    super.key,
    required this.task,
    required this.onEdit,
    required this.onToggleComplete,
    required this.onOpenOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: InkWell(
          onTap: () => onToggleComplete(task),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: task.isCompleted ? Colors.green : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isCompleted ? Colors.green : Colors.grey.shade500,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                task.title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  decoration:
                      task.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Wrap(
              spacing: 6,
              children: task.tags
                  .map(
                    (tag) => TagPill(tag: tag, priority: task.priority),
                  )
                  .toList(),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            DateFormat.yMMMd().format(task.dueDate),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ),
        onTap: onOpenOptions,
      ),
    );
  }
}
