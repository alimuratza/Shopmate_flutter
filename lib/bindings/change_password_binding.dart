import 'package:ecommerceapp/ui/auth/change_password_vm.dart';
import 'package:get/get.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordVM>(() => ChangePasswordVM());
  }
}
