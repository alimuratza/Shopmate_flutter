import 'package:get/get.dart';

class OrderDetailVM extends GetxController {
  /// Placeholder for future: load order detail using id from arguments.
  final orderId = RxnString();

  @override
  void onInit() {
    super.onInit();
    orderId.value = Get.arguments as String?;
  }
}
