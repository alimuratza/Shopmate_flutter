import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product_model.dart';

/// Firestore Seeder - Adds sample data to Firestore (run once in dev)
class FirestoreSeeder {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> seedSampleProducts() async {
    try {
      // Check if products already exist
      final count = await _firestore.collection('products').count().get();
      if (count.count! > 0) {
        print('✅ Products already exist in Firestore');
        return;
      }

      final products = _sampleProducts();
      final batch = _firestore.batch();

      for (var product in products) {
        final docRef = _firestore.collection('products').doc();
        batch.set(docRef, {
          ...product.toJson(),
          'id': docRef.id,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();
      print('✅ Firestore seeded with ${products.length} products');
    } catch (e) {
      print('❌ Error seeding Firestore: $e');
    }
  }

  static List<ProductModel> _sampleProducts() {
    return [
      // Electronics
      ProductModel(
        id: '1',
        name: 'MacBook Pro 14"',
        description: 'Powerful laptop with M3 Pro chip. Perfect for professionals.',
        price: 149999,
        originalPrice: 179999,
        imageUrl:
            'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=500&h=500&fit=crop',
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
        description: 'The most advanced iPhone ever. A17 Pro chip.',
        price: 134900,
        originalPrice: 149900,
        imageUrl:
            'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=500&h=500&fit=crop',
        category: 'Electronics',
        stock: 15,
        rating: 4.9,
        reviewCount: 1024,
        isFeatured: true,
      ),
      ProductModel(
        id: '3',
        name: 'Sony WH-1000XM5',
        description: 'Industry-leading noise cancellation headphones.',
        price: 24990,
        originalPrice: 29990,
        imageUrl:
            'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500&h=500&fit=crop',
        category: 'Electronics',
        stock: 25,
        rating: 4.7,
        reviewCount: 512,
        isFeatured: true,
      ),
      ProductModel(
        id: '4',
        name: 'iPad Air',
        description: 'Stunning 11-inch Liquid Retina display.',
        price: 79999,
        originalPrice: 89999,
        imageUrl:
            'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=500&h=500&fit=crop',
        category: 'Electronics',
        stock: 8,
        rating: 4.6,
        reviewCount: 345,
      ),

      // Fashion
      ProductModel(
        id: '5',
        name: 'Nike Air Max 270',
        description: 'Iconic style meets all-day comfort.',
        price: 12995,
        originalPrice: 15995,
        imageUrl:
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&h=500&fit=crop',
        category: 'Fashion',
        stock: 20,
        rating: 4.6,
        reviewCount: 328,
        sizes: ['UK 6', 'UK 7', 'UK 8', 'UK 9', 'UK 10'],
        colors: ['Red', 'Black', 'White'],
      ),
      ProductModel(
        id: '6',
        name: 'Premium Cotton T-Shirt',
        description: '100% organic cotton with modern relaxed fit.',
        price: 1499,
        originalPrice: 1999,
        imageUrl:
            'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&h=500&fit=crop',
        category: 'Fashion',
        stock: 50,
        rating: 4.4,
        reviewCount: 89,
        sizes: ['S', 'M', 'L', 'XL', 'XXL'],
        colors: ['White', 'Black', 'Navy', 'Grey'],
      ),
      ProductModel(
        id: '7',
        name: 'Adidas Ultraboost',
        description: 'Energy-returning Boost midsole for responsive cushioning.',
        price: 16999,
        originalPrice: 19999,
        imageUrl:
            'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=500&h=500&fit=crop',
        category: 'Fashion',
        stock: 18,
        rating: 4.7,
        reviewCount: 445,
        sizes: ['UK 6', 'UK 7', 'UK 8', 'UK 9', 'UK 10', 'UK 11'],
        isFeatured: true,
      ),
      ProductModel(
        id: '8',
        name: 'Leather Wallet',
        description: 'Genuine leather bifold with RFID protection.',
        price: 1299,
        originalPrice: 1799,
        imageUrl:
            'https://images.unsplash.com/photo-1627123424574-724758594e93?w=500&h=500&fit=crop',
        category: 'Fashion',
        stock: 40,
        rating: 4.3,
        reviewCount: 78,
        colors: ['Brown', 'Black', 'Tan'],
      ),

      // Sports
      ProductModel(
        id: '9',
        name: 'Yoga Mat Premium',
        description: 'Non-slip exercise mat with carrying strap.',
        price: 2499,
        originalPrice: 3499,
        imageUrl:
            'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=500&h=500&fit=crop',
        category: 'Sports',
        stock: 30,
        rating: 4.5,
        reviewCount: 156,
      ),
      ProductModel(
        id: '10',
        name: 'Dumbbells Set',
        description: 'Adjustable dumbbells 2-10kg with rack.',
        price: 8999,
        originalPrice: 11999,
        imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500&h=500&fit=crop',
        category: 'Sports',
        stock: 15,
        rating: 4.7,
        reviewCount: 234,
        isFeatured: true,
      ),

      // Home
      ProductModel(
        id: '11',
        name: 'Smart LED Desk Lamp',
        description: 'Touch-controlled with USB charging port.',
        price: 2499,
        originalPrice: 3499,
        imageUrl:
            'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=500&h=500&fit=crop',
        category: 'Home',
        stock: 30,
        rating: 4.5,
        reviewCount: 156,
        isFeatured: true,
      ),
      ProductModel(
        id: '12',
        name: 'Minimalist Backpack',
        description: 'Sleek backpack with laptop compartment.',
        price: 2999,
        originalPrice: 3999,
        imageUrl:
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&h=500&fit=crop',
        category: 'Home',
        stock: 35,
        rating: 4.5,
        reviewCount: 234,
        colors: ['Black', 'Grey', 'Navy'],
      ),
      ProductModel(
        id: '13',
        name: 'Stainless Steel Water Bottle',
        description: 'Keeps drinks cold for 24 hours.',
        price: 1899,
        originalPrice: 2499,
        imageUrl:
            'https://images.unsplash.com/photo-1602143407151-7111542de6e9?w=500&h=500&fit=crop',
        category: 'Home',
        stock: 50,
        rating: 4.6,
        reviewCount: 312,
        colors: ['Silver', 'Black', 'Rose Gold'],
      ),
    ];
  }
}
