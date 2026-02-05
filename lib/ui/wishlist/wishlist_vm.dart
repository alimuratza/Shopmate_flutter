import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishlistVM extends GetxController {
  // Placeholder: later connect to repo.
  final itemCount = 0.obs;

  void openItem(String name) {
    Get.snackbar('Wishlist', '$name clicked');
  }

  void confirmRemove(String name) {
    Get.dialog(
      AlertDialog(
        title: Text('Remove item from Wishlist'),
        content: Text(
          'Are you sure you want to remove "$name" from your wishlist?',
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              removeItem(name);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void removeItem(String name) {
    // Placeholder until connected to repo.
    Get.snackbar('Wishlist', '$name removed');
  }
}
