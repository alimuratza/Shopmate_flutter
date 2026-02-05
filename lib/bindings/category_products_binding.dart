import 'package:ecommerceapp/ui/categories/category_products_vm.dart';
import 'package:get/get.dart';

class CategoryProductsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryProductsVM>(() => CategoryProductsVM());
  }
}
