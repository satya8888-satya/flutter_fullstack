import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider package

import '../providers/auth_provider.dart'; // Adjust the import path as needed
import '../providers/task_provider.dart'; // Adjust the import path as needed
import '../screens/create_task_screen.dart'; // Adjust the import path as needed
import '../screens/login_screen.dart'; // Adjust the import path as needed
import '../screens/register_screen.dart'; // Adjust the import path as needed
import '../screens/task_list_screen.dart'; // Adjust the import path as needed

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
      child: MaterialApp(
        title: "Task Management",
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/tasks': (context) => TaskListScreen(),
          '/create-task': (context) => CreateTaskScreen(),
        },
      ),
    );
  }
}
