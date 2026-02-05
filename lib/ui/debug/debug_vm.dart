import 'package:get/get.dart';

class DebugVM extends GetxController {
  final logsEnabled = false.obs;

  void open(String name) {
    String? route;
    switch (name) {
      case 'Categories':
        route = '/categories';
        break;
      case 'Search':
        route = '/search';
        break;
      case 'Cart':
        route = '/cart';
        break;
      case 'Orders':
        route = '/orders';
        break;
      case 'Wishlist':
        route = '/wishlist';
        break;
      case 'Profile':
        route = '/profile';
        break;
      case 'Notifications':
        route = '/notifications';
        break;
      case 'Settings':
        route = '/settings';
        break;
      default:
        route = null;
    }

    if (route == null) return;
    Get.toNamed(route);
  }
}
