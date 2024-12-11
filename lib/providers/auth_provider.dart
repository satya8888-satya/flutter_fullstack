import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  UserModel? _user;
  String? _email;
  String? _password;

  UserModel? get user => _user;
  String? get email => _email;
  String? get password => _password;

  set email(String? value) {
    _email = value;
    notifyListeners();
  }

  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    _user = await _authService.signIn(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _user = await _authService.register(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
