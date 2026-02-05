import 'package:ecommerceapp/ui/orders/orders_vm.dart';
import 'package:get/get.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersVM>(() => OrdersVM());
  }
}
