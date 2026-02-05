import 'package:get/get.dart';

class OnboardingVM extends GetxController {
  void next() {
    // Use named routing (teacher pattern)
    Get.toNamed('/onboarding/two');
  }
}
