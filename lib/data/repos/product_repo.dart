import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/category_model.dart';

// Product Repository - handles product data operations
class ProductRepo {
  // Mock data for products (can be replaced with Firebase/API calls later)
  List<ProductModel> getAllProducts() {
    return [
      ProductModel(
        id: '1',
        name: 'MacBook Pro 14"',
        description: 'Powerful laptop with M3 Pro chip. Perfect for professionals who need performance and portability. Features a stunning Liquid Retina XDR display.',
        price: 149999,
        originalPrice: 179999,
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
        category: 'Electronics',
        stock: 10,
        rating: 4.8,
        reviewCount: 256,
        isFeatured: true,
        sizes: ['13"', '14"', '16"'],
      ),
      ProductModel(
        id: '2',
        name: 'iPhone 15 Pro Max',
        description: 'The most advanced iPhone ever. Titanium design, A17 Pro chip, and a revolutionary camera system.',
        price: 134900,
        originalPrice: 149900,
        imageUrl: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=400',
        category: 'Electronics',
        stock: 15,
        rating: 4.9,
        reviewCount: 1024,
        isFeatured: true,
      ),
      ProductModel(
        id: '3',
        name: 'Sony WH-1000XM5',
        description: 'Industry-leading noise cancellation headphones with exceptional sound quality and 30-hour battery life.',
        price: 24990,
        originalPrice: 29990,
        imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        category: 'Electronics',
        stock: 25,
        rating: 4.7,
        reviewCount: 512,
        isFeatured: true,
      ),
      ProductModel(
        id: '4',
        name: 'Nike Air Max 270',
        description: 'Iconic style meets all-day comfort. The Nike Air Max 270 features Nike\'s biggest heel Air unit yet for a super-soft ride.',
        price: 12995,
        originalPrice: 15995,
        imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        category: 'Sports',
        stock: 20,
        rating: 4.6,
        reviewCount: 328,
        sizes: ['UK 6', 'UK 7', 'UK 8', 'UK 9', 'UK 10'],
        colors: ['Red', 'Black', 'White'],
      ),
      ProductModel(
        id: '5',
        name: 'Premium Cotton T-Shirt',
        description: '100% organic cotton t-shirt with a modern relaxed fit. Sustainable fashion at its finest.',
        price: 1499,
        originalPrice: 1999,
        imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=400',
        category: 'Fashion',
        stock: 50,
        rating: 4.4,
        reviewCount: 89,
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Black', 'Navy', 'Grey'],
      ),
      ProductModel(
        id: '6',
        name: 'Smart LED Desk Lamp',
        description: 'Touch-controlled LED lamp with multiple brightness levels and color temperatures. USB charging port included.',
        price: 2499,
        originalPrice: 3499,
        imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400',
        category: 'Home',
        stock: 30,
        rating: 4.5,
        reviewCount: 156,
      ),
      ProductModel(
        id: '7',
        name: 'Adidas Ultraboost',
        description: 'Energy-returning Boost midsole provides responsive cushioning. Perfect for running or everyday wear.',
        price: 16999,
        originalPrice: 19999,
        imageUrl: 'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400',
        category: 'Sports',
        stock: 18,
        rating: 4.7,
        reviewCount: 445,
        sizes: ['UK 6', 'UK 7', 'UK 8', 'UK 9', 'UK 10', 'UK 11'],
        isFeatured: true,
      ),
      ProductModel(
        id: '8',
        name: 'Leather Wallet',
        description: 'Genuine leather bifold wallet with RFID protection. Multiple card slots and bill compartment.',
        price: 1299,
        originalPrice: 1799,
        imageUrl: 'https://images.unsplash.com/photo-1627123424574-724758594e93?w=400',
        category: 'Fashion',
        stock: 40,
        rating: 4.3,
        reviewCount: 78,
        colors: ['Brown', 'Black', 'Tan'],
      ),
      ProductModel(
        id: '9',
        name: 'Apple Watch Series 9',
        description: 'The most powerful Apple Watch yet. Advanced health features, brighter display, and carbon neutral options.',
        price: 41900,
        originalPrice: 45900,
        imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
        category: 'Electronics',
        stock: 12,
        rating: 4.8,
        reviewCount: 678,
        isFeatured: true,
      ),
      ProductModel(
        id: '10',
        name: 'Minimalist Backpack',
        description: 'Sleek and functional backpack with laptop compartment. Water-resistant fabric with anti-theft features.',
        price: 2999,
        originalPrice: 3999,
        imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400',
        category: 'Fashion',
        stock: 35,
        rating: 4.5,
        reviewCount: 234,
        colors: ['Black', 'Grey', 'Navy'],
      ),
    ];
  }

  // Get all categories
  List<CategoryModel> getAllCategories() {
    return [
      CategoryModel(
        id: '1',
        name: 'Sports',
        icon: Icons.sports,
        color: Colors.orange,
        productCount: 5,
      ),
      CategoryModel(
        id: '2',
        name: 'Fashion',
        icon: Icons.checkroom,
        color: Colors.pink,
        productCount: 12,
      ),
      CategoryModel(
        id: '3',
        name: 'Home',
        icon: Icons.home,
        color: Colors.green,
        productCount: 8,
      ),
      CategoryModel(
        id: '4',
        name: 'Electronics',
        icon: Icons.phone_android,
        color: Colors.blue,
        productCount: 15,
      ),
    ];
  }

  // Get products by category
  List<ProductModel> getProductsByCategory(String category) {
    return getAllProducts()
        .where((product) => product.category == category)
        .toList();
  }

  // Get product by ID
  ProductModel? getProductById(String id) {
    try {
      return getAllProducts().firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search products by name
  List<ProductModel> searchProducts(String query) {
    return getAllProducts()
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // Future methods for when you integrate Firebase/API
  Future<List<ProductModel>> fetchProductsFromFirebase() async {
    // TODO: Implement Firebase fetch
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return getAllProducts();
  }

  Future<List<CategoryModel>> fetchCategoriesFromFirebase() async {
    // TODO: Implement Firebase fetch
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    return getAllCategories();
  }
}
