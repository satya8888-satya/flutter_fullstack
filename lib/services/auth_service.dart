import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserModel?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return UserModel(
          id: user!.uid,
          email: user.email!,
          role: "team_member"); // Adjust role as necessary
    } catch (e) {
      print('Sign in failed: $e');
      return null;
    }
  }

  // Register with email and password
  Future<UserModel?> register(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      return UserModel(
          id: user!.uid,
          email: user.email!,
          role: "team_member"); // Adjust role as necessary
    } catch (e) {
      print('Registration failed: $e');
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
