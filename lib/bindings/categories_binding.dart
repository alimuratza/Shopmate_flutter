import 'package:ecommerceapp/ui/categories/categories_vm.dart';
import 'package:get/get.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesVM>(() => CategoriesVM());
  }
}
