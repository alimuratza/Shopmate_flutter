import 'package:ecommerceapp/ui/checkout/checkout_vm.dart';
import 'package:get/get.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckoutVM>(() => CheckoutVM());
  }
}
