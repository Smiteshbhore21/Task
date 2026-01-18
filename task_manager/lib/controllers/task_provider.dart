import 'package:flutter_riverpod/legacy.dart';
import '../models/task_model.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>(
  (ref) => TaskListNotifier(),
);

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]);

  void setTasks(List<Task> tasks) {
    state = List.unmodifiable(tasks);
  }

  void addTask(Task task) {
    state = [task, ...state];
  }

  void updateTask(Task updated) {
    state = [
      for (final t in state)
        if (t.id == updated.id) updated else t
    ];
  }

  void deleteTask(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void toggleComplete(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(isCompleted: !t.isCompleted) else t
    ];
  }
}
