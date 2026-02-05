import 'package:ecommerceapp/ui/profile/payment_methods_vm.dart';
import 'package:get/get.dart';

class PaymentMethodsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentMethodsVM>(() => PaymentMethodsVM());
  }
}
