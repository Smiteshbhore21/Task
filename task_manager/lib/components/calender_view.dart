import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task_model.dart';
import 'task_card.dart';

class CalendarView extends StatelessWidget {
  final AsyncValue<List<Task>> tasksAsync;
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final void Function(DateTime selected, DateTime focused) onDaySelected;
  final void Function(Task) onEdit;

  const CalendarView(
      {super.key,
      required this.tasksAsync,
      required this.focusedDay,
      required this.selectedDay,
      required this.onDaySelected,
      required this.onEdit});

  List<Task> _tasksForDay(DateTime day, List<Task> tasks) {
    return tasks
        .where((t) =>
            t.dueDate.year == day.year &&
            t.dueDate.month == day.month &&
            t.dueDate.day == day.day)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return tasksAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (tasks) {
        final selectedTasks =
            _tasksForDay(selectedDay ?? DateTime.now(), tasks);
        return Column(children: [
          TableCalendar<Task>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: focusedDay,
            selectedDayPredicate: (d) => isSameDay(d, selectedDay),
            eventLoader: (d) => _tasksForDay(d, tasks),
            calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                  color: Color.fromARGB(255, 68, 114, 201),
                  shape: BoxShape.circle),
              todayDecoration: BoxDecoration(
                  color:
                      const Color.fromARGB(255, 68, 114, 201).withOpacity(0.4),
                  shape: BoxShape.circle),
              markerDecoration: const BoxDecoration(
                  color: Colors.redAccent, shape: BoxShape.circle),
            ),
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            onDaySelected: (s, f) => onDaySelected(s, f),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: selectedTasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks for this day',
                      style: TextStyle(color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: selectedTasks.length,
                    itemBuilder: (c, i) => TaskCard(
                      task: selectedTasks[i],
                      onEdit: onEdit,
                      onToggleComplete: (_) async {},
                      onOpenOptions: () => onEdit(selectedTasks[i]),
                    ),
                  ),
          ),
        ]);
      },
    );
  }
}
