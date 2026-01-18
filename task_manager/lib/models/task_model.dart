import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class Task {
  final String id;
  final String title;
  final DateTime dueDate;
  final String priority;
  final bool isCompleted;
  final List<String> tags;

  const Task({
    required this.id,
    required this.title,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.tags = const [],
  });

  Task copyWith({
    String? id,
    String? title,
    DateTime? dueDate,
    String? priority,
    bool? isCompleted,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'dueDate': Timestamp.fromDate(dueDate),
      'priority': priority,
      'isCompleted': isCompleted,
      'tags': tags.map((e) => e).toList(),
    };
  }

  factory Task.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};

    DateTime parseDue(dynamic raw) {
      if (raw == null) return DateTime.now();
      if (raw is Timestamp) return raw.toDate();
      if (raw is String) {
        final dt = DateTime.tryParse(raw);
        return dt ?? DateTime.now();
      }
      if (raw is int) {
        return DateTime.fromMillisecondsSinceEpoch(raw);
      }
      return DateTime.now();
    }

    return Task(
      id: doc.id,
      title: data['title'] ?? '',
      dueDate: parseDue(data['dueDate']),
      priority: (data['priority'] ?? 'low') as String,
      isCompleted: (data['isCompleted'] ?? false) as bool,
      tags: List<String>.from(data['tags'] ?? const []),
    );
  }

  factory Task.fromMap(Map<String, dynamic> m) {
    DateTime due;
    final raw = m['dueDate'];
    if (raw is String) {
      due = DateTime.tryParse(raw) ?? DateTime.now();
    } else if (raw is int) {
      due = DateTime.fromMillisecondsSinceEpoch(raw);
    } else if (raw is DateTime) {
      due = raw;
    } else {
      due = DateTime.now();
    }
    return Task(
      id: m['id'] ?? '',
      title: m['title'] ?? '',
      dueDate: due,
      priority: m['priority'] ?? 'low',
      isCompleted: m['isCompleted'] ?? false,
      tags: List<String>.from(m['tags'] ?? const []),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          dueDate == other.dueDate &&
          priority == other.priority &&
          isCompleted == other.isCompleted &&
          listEquals(tags, other.tags);

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      dueDate.hashCode ^
      priority.hashCode ^
      isCompleted.hashCode ^
      tags.hashCode;
}
