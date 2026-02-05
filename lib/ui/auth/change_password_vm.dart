import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repos/auth_repo.dart';

// Change Password ViewModel
class ChangePasswordVM extends GetxController {
  final AuthRepo _authRepo = Get.find<AuthRepo>();

  // Text controllers
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Observable loading state
  var isLoading = false.obs;

  // Change password function
  Future<void> changePassword() async {
    String currentPassword = currentPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validation
    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'New passwords do not match');
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters');
      return;
    }

    try {
      isLoading.value = true;

      // Call repository
      await _authRepo.changePassword(currentPassword, newPassword);

      Get.snackbar('Success', 'Password changed successfully!');
      
      // Go back
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
