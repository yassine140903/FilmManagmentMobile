import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Login method
  Future<String?> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return 'Please fill in all fields';
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Register method
  Future<String?> register({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      return 'Please fill in all fields';
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // Optionally: sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  
  Future<String?> signup({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Validate
    if (email.trim().isEmpty || password.trim().isEmpty || confirmPassword.trim().isEmpty) {
      return 'Please fill in all fields';
    }

    if (password.trim() != confirmPassword.trim()) {
      return 'Passwords do not match';
    }

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null; // success
    } catch (e) {
      return e.toString(); // return error message
    }
}
}


