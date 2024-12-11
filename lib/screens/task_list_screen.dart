import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import 'create_task_screen.dart';

class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateTaskScreen()),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: taskProvider.fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching tasks'));
          } else {
            return ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(DateFormat.yMMMd().format(task.dueDate)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await taskProvider.deleteTask(task.id!);
                      // Optionally, you can show a Snackbar for feedback
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task deleted')),
                      );
                    },
                  ),
                  onTap: () {
                    // Navigate to edit screen if needed
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateTaskScreen(task: task),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
