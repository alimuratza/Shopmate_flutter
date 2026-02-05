import 'package:get/get.dart';

import '../ui/product/product_detail_vm.dart';
import '../ui/cart/cart_vm.dart';

class ProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailVM>(() => ProductDetailVM());
    Get.lazyPut<CartVM>(() => CartVM(), fenix: true);
  }
}
