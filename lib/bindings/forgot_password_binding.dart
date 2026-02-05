import 'package:ecommerceapp/ui/auth/forgot_password_vm.dart';
import 'package:get/get.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordVM>(() => ForgotPasswordVM());
  }
}
