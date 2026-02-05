import 'package:ecommerceapp/ui/orders/order_detail_vm.dart';
import 'package:get/get.dart';

class OrderDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderDetailVM>(() => OrderDetailVM());
  }
}
