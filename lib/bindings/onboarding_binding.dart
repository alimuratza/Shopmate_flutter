import 'package:get/get.dart';

import '../ui/onboarding/onboarding_vm.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingVM>(() => OnboardingVM());
  }
}
