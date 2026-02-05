import 'package:get/get.dart';

class OrdersVM extends GetxController {
  /// Placeholder for future: load order history from repo.
  final isLoading = false.obs;

  void openOrderDetail(String orderId) {
    Get.toNamed('/orders/detail', arguments: orderId);
  }
}
