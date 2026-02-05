import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';
import '../../data/repos/product_repo.dart';
import '../../data/repos/product_firestore_repo.dart';
import '../cart/cart_vm.dart';

// Home ViewModel - handles home screen logic and data
class HomeVM extends GetxController {
  final ProductRepo _productRepo = Get.find<ProductRepo>();

  // Observable lists
  var products = <ProductModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var isLoading = false.obs;

  // Bottom nav state
  final tabIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _seedProductsIfNeeded();
    loadData();
  }

  // Seed dummy products on first load
  Future<void> _seedProductsIfNeeded() async {
    try {
      final firestoreRepo = ProductFirestoreRepo();
      await firestoreRepo.seedDummyProducts();
    } catch (e) {
      print('Error seeding products: $e');
    }
  }

  // Load all products and categories
  void loadData() {
    try {
      isLoading.value = true;
      
      print('📦 Loading products and categories...');
      // Load products and categories from repository
      products.value = _productRepo.getAllProducts();
      categories.value = _productRepo.getAllCategories();
      
      print('✅ Loaded ${products.length} products');
      print('✅ Loaded ${categories.length} categories: ${categories.map((c) => c.name).toList()}');
      
    } catch (e) {
      print('❌ Error loading data: $e');
      Get.snackbar('Error', 'Failed to load data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Navigate to search screen
  void navigateToSearch() {
    Get.toNamed('/search');
  }

  // Navigate to category screen
  void navigateToCategory(String categoryName) {
    Get.toNamed('/categories/products', arguments: categoryName);
  }

  void setTab(int index) {
    tabIndex.value = index;
  }

  // Add product to cart
  void addToCart(ProductModel product) {
    final cartVM = Get.isRegistered<CartVM>()
        ? Get.find<CartVM>()
        : Get.put(CartVM(), permanent: true);
    cartVM.addToCart(product);
  }

  // View product details
  void viewProductDetails(ProductModel product) {
    Get.toNamed('/product/detail', arguments: product);
  }

  // Refresh data (for pull-to-refresh)
  Future<void> refreshData() async {
    try {
      // In the future, this would fetch from Firebase
      await Future.delayed(Duration(seconds: 1));
      loadData();
    } catch (e) {
      Get.snackbar('Error', 'Failed to refresh data: $e');
    }
  }

  // Get products by category
  List<ProductModel> getProductsByCategory(String category) {
    return _productRepo.getProductsByCategory(category);
  }
}
