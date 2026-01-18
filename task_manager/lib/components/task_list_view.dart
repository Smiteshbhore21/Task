import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'task_card.dart';

class TaskListView extends StatelessWidget {
  final AsyncValue<List<Task>> tasksAsync;
  final String searchQuery;
  final void Function(Task) onEdit;
  final VoidCallback onAdd;
  final Future<void> Function(Task) onToggleComplete;
  final Future<void> Function(Task) onDelete;

  const TaskListView({
    super.key,
    required this.tasksAsync,
    required this.searchQuery,
    required this.onEdit,
    required this.onAdd,
    required this.onToggleComplete,
    required this.onDelete,
  });

  Map<String, List<Task>> _groupedTasks(List<Task> list) {
    final today = DateTime.now();
    final t0 = DateTime(today.year, today.month, today.day);
    final t1 = t0.add(const Duration(days: 1));
    final map = {'Today': <Task>[], 'Tomorrow': <Task>[], 'Later': <Task>[]};
    for (final t in list) {
      final d = DateTime(t.dueDate.year, t.dueDate.month, t.dueDate.day);
      if (d == t0) {
        map['Today']!.add(t);
      } else if (d == t1) {
        map['Tomorrow']!.add(t);
      } else {
        map['Later']!.add(t);
      }
    }
    map.removeWhere((k, v) => v.isEmpty);
    return map;
  }

  @override
  Widget build(BuildContext context) {
    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (tasks) {
        final filtered = tasks.where((t) {
          final q = searchQuery.toLowerCase();
          return q.isEmpty ||
              t.title.toLowerCase().contains(q) ||
              t.tags.any((tag) => tag.toLowerCase().contains(q));
        }).toList();
        filtered.sort((a, b) => a.dueDate.compareTo(b.dueDate));
        final grouped = _groupedTasks(filtered);

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_rounded, size: 64, color: Colors.grey[300]),
                const SizedBox(height: 12),
                const Text('No tasks', style: TextStyle(color: Colors.black54)),
                const SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Add task'),
                ),
              ],
            ),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 90),
          children: grouped.entries.map(
            (e) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e.key,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...e.value.map(
                      (t) => Dismissible(
                        key: ValueKey(t.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 16),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              color: Colors.redAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        onDismissed: (_) async => await onDelete(t),
                        child: TaskCard(
                          task: t,
                          onEdit: onEdit,
                          onToggleComplete: onToggleComplete,
                          onOpenOptions: () => onEdit(t),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
