import 'package:ecommerceapp/ui/debug/debug_vm.dart';
import 'package:get/get.dart';

class DebugBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DebugVM>(() => DebugVM());
  }
}
