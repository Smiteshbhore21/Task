import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task_model.dart';

class TaskRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TaskRepository(this._firestore, this._auth);

  String? get currentUserId => _auth.currentUser?.uid;

  CollectionReference<Map<String, dynamic>> _tasksForUser() {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      return _firestore.collection('tasks_public');
    }
    return _firestore.collection('users').doc(uid).collection('tasks');
  }

  Stream<List<Task>> tasksStream() {
    final col = _tasksForUser();
    return col.orderBy('dueDate').snapshots().map((snap) =>
        snap.docs.map((d) => Task.fromDoc(d as DocumentSnapshot)).toList());
  }

  Future<void> addTask(Task task) async {
    final col = _tasksForUser();
    final data = task.toMap();
    try {
      if (task.id.isNotEmpty && task.id.length >= 8) {
        await col.doc(task.id).set(data);
      } else {
        await col.add(data);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(Task task) async {
    final col = _tasksForUser();
    if (task.id.isEmpty) {
      throw StateError('Task id is empty for update');
    }
    await col.doc(task.id).update(task.toMap());
  }

  Future<void> deleteTask(String id) async {
    final col = _tasksForUser();
    await col.doc(id).delete();
  }

  Future<void> toggleComplete(Task task) async {
    final col = _tasksForUser();
    await col.doc(task.id).update({'isCompleted': !task.isCompleted});
  }
}
