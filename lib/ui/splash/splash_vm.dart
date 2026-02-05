import 'package:get/get.dart';
import 'dart:async';

// Splash ViewModel - handles splash screen logic
class SplashVM extends GetxController {
  Timer? _navTimer;

  @override
  void onInit() {
    super.onInit();
    _navigateToOnboarding();
  }

  @override
  void onClose() {
    _navTimer?.cancel();
    _navTimer = null;
    super.onClose();
  }

  // Navigate to onboarding after delay
  void _navigateToOnboarding() {
    _navTimer?.cancel();
    _navTimer = Timer(const Duration(seconds: 2), () {
      if (!isClosed) {
        Get.offNamed('/onboarding');
      }
    });
  }
}
