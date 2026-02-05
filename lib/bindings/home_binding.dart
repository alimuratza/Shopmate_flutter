import 'package:get/get.dart';
import '../ui/home/home_vm.dart';
import '../ui/cart/cart_vm.dart';

// Home Binding - Injects HomeVM and CartVM when home screen is accessed
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeVM>(() => HomeVM());
    Get.lazyPut<CartVM>(() => CartVM(), fenix: true); // fenix: true keeps CartVM alive across routes
  }
}
