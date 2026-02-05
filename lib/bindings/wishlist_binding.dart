import 'package:ecommerceapp/ui/wishlist/wishlist_vm.dart';
import 'package:get/get.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WishlistVM>(() => WishlistVM());
  }
}
