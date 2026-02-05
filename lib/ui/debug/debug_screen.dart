import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../categories/categories_screen.dart';
import '../search/search_screen.dart';
import '../cart/cart_screen.dart';
import '../orders/orders_screen.dart';
import '../wishlist/wishlist_screen.dart';
import '../notifications/notifications_screen.dart';
import '../settings/settings_screen.dart';
import 'debug_vm.dart';

/// Screen 21: Debug - Quick navigation to all screens (for demo/testing)
class DebugScreen extends GetView<DebugVM> {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [
      {'name': 'Categories', 'icon': Icons.category, 'screen': const CategoriesScreen()},
      {'name': 'Search', 'icon': Icons.search, 'screen': const SearchScreen()},
      {'name': 'Cart', 'icon': Icons.shopping_cart, 'screen': const CartScreen()},
      {'name': 'Orders', 'icon': Icons.receipt, 'screen': const OrdersScreen()},
      {'name': 'Wishlist', 'icon': Icons.favorite, 'screen': const WishlistScreen()},
      {'name': 'Notifications', 'icon': Icons.notifications, 'screen': const NotificationsScreen()},
      {'name': 'Settings', 'icon': Icons.settings, 'screen': const SettingsScreen()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug - All Screens'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final screen = screens[index];
          return Card(
            child: InkWell(
              onTap: () => controller.open(screen['name'] as String),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(screen['icon'] as IconData, size: 48),
                  const SizedBox(height: 8),
                  Text(screen['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
