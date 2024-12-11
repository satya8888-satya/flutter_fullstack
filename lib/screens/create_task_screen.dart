import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/task_provider.dart';

class CreateTaskScreen extends StatefulWidget {
  final TaskModel? task; // Optional parameter for editing an existing task

  CreateTaskScreen({this.task});

  @override
  _CreateTaskScreenState createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _category = '';
  int _priority = 1; // Default priority (1 for Normal)
  DateTime? _dueDate;
  String _status = 'Not Started'; // Default status

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      // If editing an existing task, populate fields with task data
      _title = widget.task!.title;
      _description = widget.task!.description;
      _category = widget.task!.category;
      _priority = widget.task!.priority;
      _dueDate = widget.task!.dueDate;
      _status = widget.task!.status;
    }
  }

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      TaskModel newTask = TaskModel(
        id: widget.task?.id, // Use existing ID if editing
        title: _title,
        description: _description,
        category: _category,
        priority: _priority,
        dueDate:
            _dueDate ?? DateTime.now(), // Default to now if no due date is set
        status: _status,
      );

      try {
        if (widget.task == null) {
          // Create a new task
          await taskProvider.addTask(newTask);
        } else {
          // Update existing task
          await taskProvider.updateTask(newTask);
        }
        Navigator.of(context).pop(); // Go back to the previous screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save task: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Create Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a title' : null,
                onChanged: (value) => setState(() => _title = value),
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
                onChanged: (value) => setState(() => _description = value),
              ),
              TextFormField(
                initialValue: _category,
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) => setState(() => _category = value),
              ),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: InputDecoration(labelText: 'Priority'),
                items: [0, 1, 2]
                    .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value == 0
                            ? 'Low'
                            : value == 1
                                ? 'Normal'
                                : 'High')))
                    .toList(),
                onChanged: (value) => setState(() => _priority = value!),
              ),
              ListTile(
                title: Text(_dueDate == null
                    ? 'Due Date'
                    : 'Due Date:${_dueDate!.toLocal()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _dueDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101));
                  if (pickedDate != null && pickedDate != _dueDate) {
                    setState(() {
                      _dueDate = pickedDate;
                    });
                  }
                },
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Not Started', 'In Progress', 'Completed']
                    .map((status) =>
                        DropdownMenuItem(value: status, child: Text(status)))
                    .toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _saveTask,
                  child: Text(
                      widget.task == null ? 'Create Task' : 'Update Task')),
            ],
          ),
        ),
      ),
    );
  }
}
