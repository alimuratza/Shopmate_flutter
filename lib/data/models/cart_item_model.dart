import 'product_model.dart';

// CartItem Model - represents item in shopping cart
class CartItemModel {
  final ProductModel product;
  final int quantity;
  final String? size;
  final String? color;

  CartItemModel({
    required this.product,
    required this.quantity,
    this.size,
    this.color,
  });

  // Calculate total price for this cart item
  double get totalPrice => product.price * quantity;
  
  // Helper getters for UI
  String get productId => product.id;
  String get productName => product.name;
  double get price => product.price;
  String? get imageUrl => product.imageUrl;

  // Create CartItemModel from JSON
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'] ?? 1,
      size: json['size'],
      color: json['color'],
    );
  }

  // Convert CartItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
      'size': size,
      'color': color,
    };
  }

  // Copy with method for immutability
  CartItemModel copyWith({
    ProductModel? product,
    int? quantity,
    String? size,
    String? color,
  }) {
    return CartItemModel(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
