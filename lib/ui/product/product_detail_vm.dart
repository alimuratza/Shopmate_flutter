import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/repos/product_firestore_repo.dart';
import '../cart/cart_vm.dart';

class ProductDetailVM extends GetxController {
  // Product data
  late ProductModel _product;
  final ProductFirestoreRepo _repo = ProductFirestoreRepo();
  final _isProductLoaded = false.obs;
  
  // Observable states
  final isWishlisted = false.obs;
  final quantity = 1.obs;
  final selectedSize = ''.obs;
  final selectedColor = Rx<Color>(Colors.black);
  final isAddingToCart = false.obs;
  final isLoading = false.obs;
  
  // Available options
  final availableSizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final availableColors = [
    Colors.black,
    Colors.white,
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  @override
  void onInit() {
    super.onInit();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      isLoading.value = true;
      final args = Get.arguments;
      
      if (args is ProductModel) {
        // Arguments passed as ProductModel directly
        _product = args;
      } else if (args is String && args.isNotEmpty) {
        // Arguments passed as product ID - fetch from Firestore
        final product = await _repo.getById(args);
        _product = product ?? ProductModel(
          id: 'dummy',
          name: 'Product Not Found',
          description: 'Product description',
          price: 0,
          imageUrl: '',
          category: '',
          stock: 0,
        );
      } else {
        // No arguments, use dummy product
        _product = ProductModel(
          id: 'dummy',
          name: 'Product',
          description: 'Product description',
          price: 0,
          imageUrl: '',
          category: '',
          stock: 0,
        );
      }
      
      // Set default selections
      if (availableSizes.isNotEmpty) {
        selectedSize.value = availableSizes[1]; // Default to M
      }
      if (availableColors.isNotEmpty) {
        selectedColor.value = availableColors[0];
      }
      
      _isProductLoaded.value = true;
    } catch (e) {
      print('Error loading product: $e');
      // Initialize with dummy product even on error
      _product = ProductModel(
        id: 'error',
        name: 'Error Loading Product',
        description: 'Could not load product data',
        price: 0,
        imageUrl: '',
        category: '',
        stock: 0,
      );
      _isProductLoaded.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  // Getters for product info
  String get productName => _product.name;
  double get price => _product.price;
  double? get originalPrice => _product.originalPrice;
  String get description => _product.description.isEmpty
      ? 'This is a high-quality product made with premium materials. '
          'Perfect for everyday use and designed to last. '
          'Experience comfort and style with this amazing product.'
      : _product.description;
  String get category => _product.category;
  double get rating => _product.rating ?? 4.5;
  int get reviewCount => _product.reviewCount ?? 120;
  bool get isInStock => true;
  List<String> get productImages => _product.imageUrl != null && _product.imageUrl!.isNotEmpty
      ? [_product.imageUrl!]
      : [];
  
  int get discountPercent {
    if (originalPrice != null && originalPrice! > price) {
      return ((originalPrice! - price) / originalPrice! * 100).round();
    }
    return 0;
  }

  // Actions
  void toggleWishlist() {
    isWishlisted.value = !isWishlisted.value;
    if (isWishlisted.value) {
      Get.snackbar(
        'Wishlist',
        'Added to wishlist',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  void addToWishlist() {
    isWishlisted.value = true;
    Get.snackbar('Wishlist', 'Added to wishlist');
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectColor(Color color) {
    selectedColor.value = color;
  }

  void setQuantity(int qty) {
    quantity.value = qty;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  Future<void> addToCart() async {
    if (_product == null) {
      Get.snackbar('Error', 'Product not found');
      return;
    }
    if (selectedSize.value.isEmpty) {
      Get.snackbar(
        'Select Size',
        'Please select a size before adding to cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    isAddingToCart.value = true;

    final cartVM = Get.isRegistered<CartVM>()
        ? Get.find<CartVM>()
        : Get.put(CartVM(), permanent: true);

    cartVM.addToCartWithOptions(
      _product!,
      size: selectedSize.value,
      color: _colorToHex(selectedColor.value),
      quantity: quantity.value,
    );

    await Future.delayed(const Duration(milliseconds: 400));
    isAddingToCart.value = false;
  }

  String _colorToHex(Color color) {
    final value = color.value.toRadixString(16).padLeft(8, '0');
    return '#$value';
  }
}
