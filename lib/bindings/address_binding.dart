import 'package:ecommerceapp/ui/profile/address_vm.dart';
import 'package:get/get.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressVM>(() => AddressVM());
  }
}
