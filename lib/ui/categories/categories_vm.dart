import 'package:get/get.dart';

class CategoriesVM extends GetxController {
  /// Example: you can store selected category or a loading state here later.
  final selectedCategory = RxnString();

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  void openCategory(String category) {
    selectCategory(category);
    Get.toNamed('/categories/products', arguments: category);
  }
}
