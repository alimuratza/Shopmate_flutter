import 'package:get/get.dart';
import '../ui/auth/signup_vm.dart';

// Signup Binding - Injects SignupVM when signup page is accessed
class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupVM>(() => SignupVM());
  }
}
