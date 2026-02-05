import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/product_model.dart';

// Cart ViewModel - handles cart operations
class CartVM extends GetxController {
  // Observable cart items list
  var cartItems = <CartItemModel>[].obs;

  // Computed properties
  int get itemCount => cartItems.length;
  
  double get totalAmount {
    return subtotal - discount + 99; // subtotal - discount + shipping
  }
  
  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }
  
  double get discount {
    // Calculate discount based on original prices
    return cartItems.fold(0.0, (sum, item) {
      if (item.product.originalPrice != null) {
        return sum + (item.product.originalPrice! - item.product.price) * item.quantity;
      }
      return sum;
    });
  }

  int get totalQuantity {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  // Add product to cart with size and color
  void addToCartWithOptions(ProductModel product, {String? size, String? color, int quantity = 1}) {
    try {
      // Check if same product with same options exists
      int index = cartItems.indexWhere((item) => 
        item.product.id == product.id && 
        item.size == size && 
        item.color == color
      );

      if (index != -1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + quantity,
        );
        Get.snackbar('Success', '${product.name} quantity increased');
      } else {
        cartItems.add(CartItemModel(
          product: product, 
          quantity: quantity,
          size: size,
          color: color,
        ));
        Get.snackbar('Success', '${product.name} added to cart');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to add to cart: $e');
    }
  }

  // Add product to cart (simple)
  void addToCart(ProductModel product) {
    addToCartWithOptions(product);
  }

  // Update quantity
  void updateQuantity(String productId, int newQuantity) {
    try {
      int index = cartItems.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        if (newQuantity <= 0) {
          removeFromCart(productId);
        } else {
          cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity: $e');
    }
  }

  // Remove product from cart
  void removeFromCart(String productId) {
    try {
      cartItems.removeWhere((item) => item.product.id == productId);
      Get.snackbar('Success', 'Item removed from cart');
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove item: $e');
    }
  }

  // Increase quantity
  void increaseQuantity(String productId) {
    try {
      int index = cartItems.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        cartItems[index] = cartItems[index].copyWith(
          quantity: cartItems[index].quantity + 1,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity: $e');
    }
  }

  // Decrease quantity
  void decreaseQuantity(String productId) {
    try {
      int index = cartItems.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        if (cartItems[index].quantity > 1) {
          cartItems[index] = cartItems[index].copyWith(
            quantity: cartItems[index].quantity - 1,
          );
        } else {
          removeFromCart(productId);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update quantity: $e');
    }
  }

  // Clear cart
  void clearCart() {
    cartItems.clear();
    Get.snackbar('Success', 'Cart cleared');
  }

  // Check if product is in cart
  bool isInCart(String productId) {
    return cartItems.any((item) => item.product.id == productId);
  }

  // Get quantity of a specific product in cart
  int getProductQuantity(String productId) {
    try {
      return cartItems.firstWhere((item) => item.product.id == productId).quantity;
    } catch (e) {
      return 0;
    }
  }

  // Checkout
  void checkout() {
    if (cartItems.isEmpty) {
      Get.snackbar('Error', 'Your cart is empty');
      return;
    }
    Get.toNamed('/checkout');
  }
}
