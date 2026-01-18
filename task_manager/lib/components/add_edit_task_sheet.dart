import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/utils/color_ext.dart';
import '../models/task_model.dart';
import '../controllers/task_repo.dart';

class AddEditTaskSheet extends StatefulWidget {
  final TaskRepository repo;
  final Task? task;
  const AddEditTaskSheet({super.key, required this.repo, this.task});

  @override
  State<AddEditTaskSheet> createState() => _AddEditTaskSheetState();
}

class _AddEditTaskSheetState extends State<AddEditTaskSheet> {
  late TextEditingController tcTitle;
  late TextEditingController tcDate;
  final tcTag = TextEditingController();
  late List<String> localTags;
  String selectedPriority = 'low';

  @override
  void initState() {
    super.initState();
    selectedPriority = widget.task?.priority ?? 'low';
    tcTitle = TextEditingController(text: widget.task?.title ?? '');
    tcDate = TextEditingController(
        text: widget.task != null
            ? DateFormat.yMMMd().format(widget.task!.dueDate)
            : '');
    localTags = List<String>.from(widget.task?.tags ?? []);
  }

  @override
  void dispose() {
    tcTitle.dispose();
    tcDate.dispose();
    tcTag.dispose();
    super.dispose();
  }

  void addTag() {
    final t = tcTag.text.trim();
    if (t.isEmpty) return;
    if (!localTags.contains(t)) setState(() => localTags.add(t));
    tcTag.clear();
  }

  Future<void> submit() async {
    if (tcTitle.text.trim().isEmpty || tcDate.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title & date required'),
        ),
      );
      return;
    }
    DateTime due;
    try {
      due = DateFormat.yMMMd().parse(tcDate.text.trim());
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid date format'),
        ),
      );
      return;
    }

    Navigator.of(context).pop();

    if (widget.task == null) {
      final newTask = Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: tcTitle.text.trim(),
          dueDate: due,
          priority: selectedPriority,
          tags: List.from(localTags));
      await widget.repo.addTask(newTask);
    } else {
      final updated = widget.task!.copyWith(
          title: tcTitle.text.trim(),
          dueDate: due,
          priority: selectedPriority,
          tags: List.from(localTags));
      await widget.repo.updateTask(updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
              child: Text(widget.task == null ? 'Add Task' : 'Edit Task',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700))),
          const SizedBox(height: 18),
          const Text('Title'),
          TextField(
              controller: tcTitle,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), isDense: true)),
          const SizedBox(height: 12),
          const Text('Date'),
          TextField(
            controller: tcDate,
            readOnly: true,
            onTap: () async {
              final picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  initialDate: widget.task?.dueDate ?? DateTime.now());
              if (picked != null) {
                setState(
                  () => tcDate.text = DateFormat.yMMMd().format(picked),
                );
              }
            },
            decoration: const InputDecoration(
                suffixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
                isDense: true),
          ),
          const SizedBox(height: 12),
          const Text('Priority'),
          const SizedBox(height: 8),
          Row(children: [
            _priorityOption('low'),
            const SizedBox(width: 8),
            _priorityOption('medium'),
            const SizedBox(width: 8),
            _priorityOption('high'),
          ]),
          const SizedBox(height: 12),
          const Text('Tags'),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(
                child: TextField(
                    controller: tcTag,
                    decoration: const InputDecoration(
                        hintText: 'Enter tag and press +',
                        border: OutlineInputBorder(),
                        isDense: true),
                    onSubmitted: (_) => addTag())),
            const SizedBox(width: 8),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: addTag,
                child: const Icon(Icons.add),
              ),
            ),
          ]),
          const SizedBox(height: 8),
          Wrap(
              spacing: 8,
              runSpacing: 6,
              children: localTags
                  .map(
                    (t) => Chip(
                      label: Text(t),
                      onDeleted: () => setState(
                        () => localTags.remove(t),
                      ),
                    ),
                  )
                  .toList()),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: submit,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(widget.task == null ? 'Submit' : 'Update'),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _priorityOption(String value) {
    final color = _priorityToColor(value);
    final isSelected = selectedPriority == value;
    return GestureDetector(
      onTap: () => setState(() => selectedPriority = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.12) : Colors.transparent,
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          value.toUpperCase(),
          style: TextStyle(
            color: isSelected ? color.darken(0.2) : color.darken(0.0),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Color _priorityToColor(String p) {
    switch (p.toLowerCase()) {
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return Colors.orangeAccent;
      default:
        return Colors.green;
    }
  }
}
