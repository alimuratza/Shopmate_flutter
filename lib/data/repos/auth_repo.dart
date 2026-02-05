import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// Authentication Repository - handles all Firebase auth operations
class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign up with email and password
  Future<User?> signUp(String email, String password) async {
    try {
      debugPrint('🔥 Attempting to sign up user: $email');
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('✅ Sign up successful! User ID: ${result.user?.uid}');
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      if (e.code == 'weak-password') {
        throw 'Password is too weak';
      } else if (e.code == 'email-already-in-use') {
        throw 'Email already exists';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address';
      } else {
        throw 'Signup failed: ${e.message}';
      }
    } catch (e) {
      debugPrint('❌ Unknown error: $e');
      throw e.toString();
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      debugPrint('🔥 Attempting to sign in user: $email');
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('✅ Sign in successful! User ID: ${result.user?.uid}');
      return result.user;
    } on FirebaseAuthException catch (e) {
      debugPrint('❌ Firebase Auth Error: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found') {
        throw 'No account found with this email';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address';
      } else {
        throw 'Login failed: ${e.message}';
      }
    } catch (e) {
      debugPrint('❌ Unknown error: $e');
      throw e.toString();
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e.toString();
    }
  }

  // Change password
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      User? user = currentUser;
      if (user != null && user.email != null) {
        // Re-authenticate user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);
        
        // Update password
        await user.updatePassword(newPassword);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
