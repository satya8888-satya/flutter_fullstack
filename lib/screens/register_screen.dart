import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => authProvider.email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) => authProvider.password = value,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await authProvider.register(
                      authProvider.email!, authProvider.password!);
                  Navigator.of(context).pushReplacementNamed('/tasks');
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
