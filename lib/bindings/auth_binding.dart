import 'package:get/get.dart';
import '../ui/auth/login_vm.dart';

// Login Binding - Injects LoginVM when login page is accessed
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginVM>(() => LoginVM());
  }
}
