import 'package:get/get.dart';

class CheckoutVM extends GetxController {
  final isPlacingOrder = false.obs;

  void finishAfterOrder() {
    // Teacher-style: keep navigation centralized in VM.
    Get.offAllNamed('/home');
  }

  Future<void> placeOrder() async {
    if (isPlacingOrder.value) return;
    try {
      isPlacingOrder.value = true;
      await Future.delayed(const Duration(milliseconds: 600));
      Get.snackbar('Success', 'Order placed');

      finishAfterOrder();
    } finally {
      isPlacingOrder.value = false;
    }
  }
}
