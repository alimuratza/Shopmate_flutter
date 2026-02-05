import 'package:ecommerceapp/ui/profile/profile_vm.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileVM>(() => ProfileVM());
  }
}
