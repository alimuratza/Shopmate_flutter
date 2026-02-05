import 'package:ecommerceapp/ui/cart/cart_vm.dart';
import 'package:get/get.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartVM>(() => CartVM());
  }
}
