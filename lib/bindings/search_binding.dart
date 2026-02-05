import 'package:ecommerceapp/ui/search/search_vm.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchVM>(() => SearchVM());
  }
}
