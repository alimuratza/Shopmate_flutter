import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/auth_repo.dart';

// Forgot Password ViewModel
class ForgotPasswordVM extends GetxController {
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  // Text controller
  final emailController = TextEditingController();

  // Observable loading state
  var isLoading = false.obs;

  // Send reset password email
  Future<void> sendResetEmail() async {
    String email = emailController.text.trim();

    // Validation
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email');
      return;
    }

    try {
      isLoading.value = true;

      // Call repository
      await _authRepo.resetPassword(email);

      Get.snackbar('Success', 'Password reset email sent!');
      
      // Go back to login
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
