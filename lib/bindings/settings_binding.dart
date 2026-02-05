import 'package:ecommerceapp/ui/settings/settings_vm.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsVM>(() => SettingsVM());
  }
}
