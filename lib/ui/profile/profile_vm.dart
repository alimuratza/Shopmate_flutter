import 'package:get/get.dart';

class ProfileVM extends GetxController {
  // User profile data
  final userName = 'Guest'.obs;
  final userEmail = 'guest@example.com'.obs;

  void openOrders() => Get.toNamed('/orders');

  void openAddresses() => Get.toNamed('/profile/address');

  void openPaymentMethods() => Get.toNamed('/profile/payment-methods');

  void openSettings() => Get.toNamed('/settings');

  void logout() {
    // Placeholder for real logout logic
    Get.snackbar('Logout', 'Logged out');
    Get.offAllNamed('/login');
  }
}
