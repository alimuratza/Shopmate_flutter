import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

/// Firestore-backed repository for Products.
///
/// Collection: `products`
/// Document id: productId
/// Fields:
/// - name (string)
/// - description (string)
/// - price (number)
/// - imageUrl (string)
/// - category (string)
/// - stock (number)
/// - rating (number, optional)
/// - createdAt (timestamp)
/// - updatedAt (timestamp)
class ProductFirestoreRepo {
  ProductFirestoreRepo({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _col => _firestore.collection('products');

  /// Create a product with auto-generated doc id.
  Future<String> create(ProductModel product) async {
    final now = FieldValue.serverTimestamp();

    final doc = await _col.add({
      ...product.toJson(),
      // we store id in the document too so mapping stays simple
      'id': '',
      'createdAt': now,
      'updatedAt': now,
    });

    await doc.update({'id': doc.id});
    return doc.id;
  }

  /// Create/update a product at a known id (useful for admin edits).
  Future<void> upsert(ProductModel product) async {
    final now = FieldValue.serverTimestamp();

    await _col.doc(product.id).set({
      ...product.toJson(),
      'createdAt': now,
      'updatedAt': now,
    }, SetOptions(merge: true));
  }

  Future<void> updateFields(String id, Map<String, dynamic> fields) async {
    await _col.doc(id).update({
      ...fields,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> delete(String id) => _col.doc(id).delete();

  Future<ProductModel?> getById(String id) async {
    final snap = await _col.doc(id).get();
    if (!snap.exists) return null;
    return ProductModel.fromJson(snap.data()!);
  }

  /// Stream all products, newest first.
  Stream<List<ProductModel>> streamAll({int limit = 50}) {
    return _col
        .orderBy('createdAt', descending: true)
        .limit(limit)
        .snapshots()
        .map((q) => q.docs.map((d) => ProductModel.fromJson(d.data())).toList());
  }

  /// Stream products by category.
  Stream<List<ProductModel>> streamByCategory(String category, {int limit = 50}) {
    // Note: Removed orderBy to avoid requiring composite index
    // Products will be returned in default order
    return _col
        .where('category', isEqualTo: category)
        .limit(limit)
        .snapshots()
        .map((q) => q.docs.map((d) => ProductModel.fromJson(d.data())).toList());
  }

  /// Simple search by name prefix: where name >= query and < query + \uf8ff.
  ///
  /// Requires `nameLower` field for better results; for now we query `name`.
  Future<List<ProductModel>> searchByNamePrefix(String query, {int limit = 20}) async {
    final q = query.trim();
    if (q.isEmpty) return [];

    final snap = await _col
        .orderBy('name')
        .startAt([q]).endAt(['$q\uf8ff']).limit(limit).get();

    return snap.docs.map((d) => ProductModel.fromJson(d.data())).toList();
  }

  /// Seed dummy products for demo (call once during app initialization)
  Future<void> seedDummyProducts() async {
    try {
      // Check if products already exist
      final existing = await _col.limit(1).get();
      if (existing.docs.isNotEmpty) {
        print('✅ Products already exist, skipping seed');
        return;
      }

      final dummyProducts = [
        // Electronics
        ProductModel(
          id: '',
          name: 'Wireless Headphones',
          description: 'Premium noise-cancelling wireless headphones with 30-hour battery',
          price: 12999,
          imageUrl: 'https://via.placeholder.com/300?text=Headphones',
          category: 'Electronics',
          stock: 15,
        ),
        ProductModel(
          id: '',
          name: 'USB-C Cable',
          description: 'Fast charging USB-C cable, 2 meters long',
          price: 499,
          imageUrl: 'https://via.placeholder.com/300?text=Cable',
          category: 'Electronics',
          stock: 50,
        ),
        ProductModel(
          id: '',
          name: 'Portable Speaker',
          description: 'Waterproof Bluetooth speaker with 360-degree sound',
          price: 4999,
          imageUrl: 'https://via.placeholder.com/300?text=Speaker',
          category: 'Electronics',
          stock: 20,
        ),

        // Fashion
        ProductModel(
          id: '',
          name: 'Blue Running Shoes',
          description: 'Professional running shoes with cushioning technology',
          price: 7999,
          imageUrl: 'https://via.placeholder.com/300?text=Shoes',
          category: 'Fashion',
          stock: 25,
        ),
        ProductModel(
          id: '',
          name: 'Cotton T-Shirt',
          description: '100% organic cotton comfortable t-shirt in multiple colors',
          price: 999,
          imageUrl: 'https://via.placeholder.com/300?text=TShirt',
          category: 'Fashion',
          stock: 100,
        ),
        ProductModel(
          id: '',
          name: 'Black Formal Jacket',
          description: 'Premium wool formal jacket, perfect for office or parties',
          price: 8999,
          imageUrl: 'https://via.placeholder.com/300?text=Jacket',
          category: 'Fashion',
          stock: 15,
        ),

        // Sports
        ProductModel(
          id: '',
          name: 'Yoga Mat',
          description: 'Non-slip eco-friendly yoga mat with carrying strap',
          price: 1999,
          imageUrl: 'https://via.placeholder.com/300?text=YogaMat',
          category: 'Sports',
          stock: 30,
        ),
        ProductModel(
          id: '',
          name: 'Dumbbells Set',
          description: 'Adjustable dumbbells set from 2kg to 20kg',
          price: 19999,
          imageUrl: 'https://via.placeholder.com/300?text=Dumbbells',
          category: 'Sports',
          stock: 10,
        ),
        ProductModel(
          id: '',
          name: 'Sports Bottle',
          description: 'Insulated water bottle keeps drinks hot/cold for 24 hours',
          price: 1499,
          imageUrl: 'https://via.placeholder.com/300?text=Bottle',
          category: 'Sports',
          stock: 50,
        ),
      ];

      // Add all products
      for (var product in dummyProducts) {
        await create(product);
      }

      print('✅ Seeded ${dummyProducts.length} dummy products successfully');
    } catch (e) {
      print('❌ Error seeding products: $e');
    }
  }
}
