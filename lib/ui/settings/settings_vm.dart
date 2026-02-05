import 'package:get/get.dart';

class SettingsVM extends GetxController {
  final notificationsEnabled = true.obs;

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  void openNotifications() {
    Get.toNamed('/notifications');
  }

  void openEditProfile() {
    Get.toNamed('/profile');
  }

  void changePassword() {
    Get.toNamed('/auth/change-password');
  }

  void logout() {
    Get.offAllNamed('/auth/login');
  }

  void showLanguage() {
    Get.snackbar('Language', 'English');
  }

  void showVersion() {
    Get.snackbar('App Version', 'v1.0.0');
  }

  void openHelp() {
    Get.snackbar('Help & Support', 'Contact support@example.com');
  }

  // Demo/admin entry to verify Firestore CRUD/query/stream.
  void openProductsAdmin() {
    Get.toNamed('/admin/products');
  }
}
