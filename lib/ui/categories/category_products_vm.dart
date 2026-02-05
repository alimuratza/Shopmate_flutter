import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import '../../data/repos/product_firestore_repo.dart';

class CategoryProductsVM extends GetxController {
  final ProductFirestoreRepo _repo = Get.find<ProductFirestoreRepo>();

  /// Passed via Get.arguments (category name).
  final categoryName = RxnString();

  String get title {
    final value = categoryName.value;
    if (value == null || value.trim().isEmpty) return 'Category';
    return value;
  }

  /// Stream products filtered by category from Firestore.
  Stream<List<ProductModel>> get productsStream {
    final cat = categoryName.value;
    if (cat == null || cat.trim().isEmpty) {
      return Stream.value([]);
    }
    // If "All" is selected, show all products
    if (cat.toLowerCase() == 'all') {
      return _repo.streamAll();
    }
    return _repo.streamByCategory(cat);
  }

  @override
  void onInit() {
    super.onInit();
    categoryName.value = Get.arguments as String?;
  }

  void openProductDetail({String? productId, String? productName}) {
    Get.toNamed('/product/detail', arguments: productId ?? productName);
  }
}
