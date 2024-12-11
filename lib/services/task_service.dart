import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTask(TaskModel task) async {
    await _firestore.collection('tasks').add(task.toJson());
  }

  Future<List<TaskModel>> getTasks() async {
    QuerySnapshot snapshot = await _firestore.collection('tasks').get();
    return snapshot.docs
        .map((doc) =>
            TaskModel.fromJson(doc.data() as Map<String, dynamic>)..id = doc.id)
        .toList();
  }

  Future<void> updateTask(TaskModel task) async {
    if (task.id != null) {
      await _firestore.collection('tasks').doc(task.id).update(task.toJson());
    }
  }

  Future<void> deleteTask(String id) async {
    await _firestore.collection('tasks').doc(id).delete();
  }
}
