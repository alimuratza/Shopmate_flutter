import 'package:ecommerceapp/ui/notifications/notifications_vm.dart';
import 'package:get/get.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationsVM>(() => NotificationsVM());
  }
}
