import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider with ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  Future<void> fetchTasks() async {
    _tasks = await _taskService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await _taskService.createTask(task);
    await fetchTasks(); // Refresh the list after adding
  }

  Future<void> updateTask(TaskModel task) async {
    await _taskService.updateTask(task);
    await fetchTasks(); // Refresh the list after updating
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
    await fetchTasks(); // Refresh the list after deleting
  }
}
