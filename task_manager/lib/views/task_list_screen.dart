import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/controllers/auth_provider.dart';
import '../components/add_edit_task_sheet.dart';
import '../components/calender_view.dart';
import '../components/header_bar.dart';
import '../components/task_list_view.dart';
import '../controllers/login_session.dart';
import '../controllers/repo_provider.dart';
import '../controllers/task_stream_provider.dart';
import '../models/task_model.dart';
import 'login_screen.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});
  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  String searchQuery = '';
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primary;
    final tasksAsync = ref.watch(taskStreamProvider);

    void openAddEditSheet([Task? task]) {
      final repo = ref.read(taskRepositoryProvider);
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => AddEditTaskSheet(repo: repo, task: task),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(160),
        child: HeaderBar(
          colorPrimary: colorPrimary,
          onSearchChanged: (v) => setState(() => searchQuery = v),
          onLogout: () async {
            await ref.read(authControllerProvider).logout();
            await LoginSession.clearSession();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
                (route) => false,
              );
            }
          },
        ),
      ),
      body: _selectedIndex == 0
          ? TaskListView(
              tasksAsync: tasksAsync,
              searchQuery: searchQuery,
              onEdit: (t) => openAddEditSheet(t),
              onAdd: () => openAddEditSheet(),
              onToggleComplete: (t) =>
                  ref.read(taskRepositoryProvider).toggleComplete(t),
              onDelete: (t) =>
                  ref.read(taskRepositoryProvider).deleteTask(t.id),
            )
          : CalendarView(
              tasksAsync: tasksAsync,
              focusedDay: _focusedDay,
              selectedDay: _selectedDay,
              onDaySelected: (sel, foc) {
                setState(() {
                  _selectedDay = sel;
                  _focusedDay = foc;
                });
              },
              onEdit: (t) => openAddEditSheet(t),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => openAddEditSheet(),
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_stream_rounded),
            label: "Tasks",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_sharp),
            label: "Calendar",
          ),
        ],
      ),
    );
  }
}
