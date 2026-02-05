import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_vm.dart';
import '../../widgets/advanced/advanced_widgets.dart';
import '../../core/constants/app_colors.dart';

/// Advanced Cart Screen with modern UI
class AdvancedCartScreen extends GetView<CartVM> {
  const AdvancedCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() => controller.itemCount > 0
              ? TextButton(
                  onPressed: controller.clearCart,
                  child: const Text(
                    'Clear All',
                    style: TextStyle(color: AppColors.error),
                  ),
                )
              : const SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.itemCount == 0) {
          return _buildEmptyCart();
        }
        return _buildCartContent(context);
      }),
      bottomNavigationBar: Obx(() {
        if (controller.itemCount == 0) return const SizedBox.shrink();
        return _buildBottomBar(context);
      }),
    );
  }

  Widget _buildEmptyCart() {
    return AdvancedEmptyState(
      icon: Icons.shopping_cart_outlined,
      title: 'Your Cart is Empty',
      subtitle: 'Looks like you haven\'t added any items to your cart yet.',
      actionText: 'Start Shopping',
      onAction: () => Get.toNamed('/categories/products', arguments: 'All'),
    );
  }

  Widget _buildCartContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Cart Items
          _buildCartItems(),
          
          const SizedBox(height: 24),
          
          // Promo Code
          _buildPromoCode(),
          
          const SizedBox(height: 24),
          
          // Order Summary
          _buildOrderSummary(),
          
          const SizedBox(height: 100), // Space for bottom bar
        ],
      ),
    );
  }

  Widget _buildCartItems() {
    return Obx(() => ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.cartItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = controller.cartItems[index];
        return _CartItemCard(
          name: item.productName,
          price: item.price,
          quantity: item.quantity,
          imageUrl: item.imageUrl,
          size: item.size,
          color: item.color,
          onQuantityChanged: (qty) => controller.updateQuantity(item.productId, qty),
          onRemove: () => controller.removeFromCart(item.productId),
        );
      },
    ));
  }

  Widget _buildPromoCode() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.discount_outlined,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Apply Promo Code',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => _buildSummaryRow('Subtotal', '₹${controller.subtotal.toStringAsFixed(0)}')),
          const SizedBox(height: 8),
          _buildSummaryRow('Shipping', '₹99'),
          const SizedBox(height: 8),
          Obx(() => _buildSummaryRow(
            'Discount',
            '-₹${controller.discount.toStringAsFixed(0)}',
            valueColor: AppColors.success,
          )),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Obx(() => _buildSummaryRow(
            'Total',
            '₹${controller.totalAmount.toStringAsFixed(0)}',
            isBold: true,
            fontSize: 18,
          )),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isBold = false,
    double fontSize = 14,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? (isBold ? AppColors.primary : AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                  '₹${controller.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AnimatedButton(
              text: 'Checkout',
              icon: Icons.arrow_forward_rounded,
              onPressed: controller.checkout,
              height: 54,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual cart item card
class _CartItemCard extends StatelessWidget {
  final String name;
  final double price;
  final int quantity;
  final String? imageUrl;
  final String? size;
  final String? color;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.name,
    required this.price,
    required this.quantity,
    this.imageUrl,
    this.size,
    this.color,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(name),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 28,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: imageUrl != null && imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _buildPlaceholder(),
                      ),
                    )
                  : _buildPlaceholder(),
            ),
            const SizedBox(width: 12),
            
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (size != null || color != null)
                    Text(
                      [if (size != null) 'Size: $size', if (color != null) 'Color: $color']
                          .join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      QuantitySelector(
                        quantity: quantity,
                        onChanged: onQuantityChanged,
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(
        Icons.shopping_bag_outlined,
        size: 32,
        color: Colors.grey[400],
      ),
    );
  }
}
