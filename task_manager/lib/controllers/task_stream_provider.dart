import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'repo_provider.dart';

final taskStreamProvider = StreamProvider.autoDispose<List<Task>>((ref) {
  final repo = ref.watch(taskRepositoryProvider);
  return repo.tasksStream();
});
