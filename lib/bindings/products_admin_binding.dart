import 'package:get/get.dart';

import '../ui/products_admin/products_admin_vm.dart';

class ProductsAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsAdminVM>(() => ProductsAdminVM());
  }
}
