import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/auth_repo.dart';

// Login ViewModel - handles login logic
class LoginVM extends GetxController {
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  // Text controllers for form fields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable loading state
  var isLoading = false.obs;
  
  // Password visibility
  var obscurePassword = true.obs;

  // Login function
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validation
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    try {
      isLoading.value = true;

      // Call repository to sign in
      await _authRepo.signIn(email, password);

      Get.snackbar('Success', 'Login successful!');
      
      // Navigate to home
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Login failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to signup page
  void goToSignup() {
    Get.toNamed('/auth/signup');
  }

  // Navigate to forgot password page
  void goToForgotPassword() {
    Get.toNamed('/auth/forgot-password');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
