import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/auth_repo.dart';

// Signup ViewModel - handles signup logic
class SignupVM extends GetxController {
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable loading state
  var isLoading = false.obs;
  
  // Password visibility
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;
  
  // Terms acceptance
  var acceptTerms = false.obs;

  // Signup function
  Future<void> signup() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validation
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    try {
      isLoading.value = true;

      // Call repository to sign up
      await _authRepo.signUp(email, password);

      Get.snackbar('Success', 'Account created successfully!');
      
      // Navigate to home
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', 'Signup failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to login page
  void goToLogin() {
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
