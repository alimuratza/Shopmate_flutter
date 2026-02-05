import 'package:get/get.dart';

class SearchVM extends GetxController {
  final query = ''.obs;

  void setQuery(String value) {
    query.value = value;

    if (value.trim().isNotEmpty) {
      Get.snackbar('Search', 'Searching: $value');
    }
  }
}
