// Product Model - represents product data
class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice; // For discount calculation
  final String? imageUrl;
  final List<String>? images; // Multiple images
  final String category;
  final int stock;
  final double? rating;
  final int? reviewCount;
  final bool? isFeatured;
  final List<String>? sizes;
  final List<String>? colors;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    this.imageUrl,
    this.images,
    required this.category,
    required this.stock,
    this.rating,
    this.reviewCount,
    this.isFeatured,
    this.sizes,
    this.colors,
  });

  // Create ProductModel from JSON (for Firebase/API)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      originalPrice: json['originalPrice']?.toDouble(),
      imageUrl: json['imageUrl'],
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : null,
      category: json['category'] ?? '',
      stock: json['stock'] ?? 0,
      rating: json['rating']?.toDouble(),
      reviewCount: json['reviewCount'],
      isFeatured: json['isFeatured'],
      sizes: json['sizes'] != null 
          ? List<String>.from(json['sizes']) 
          : null,
      colors: json['colors'] != null 
          ? List<String>.from(json['colors']) 
          : null,
    );
  }

  // Convert ProductModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'images': images,
      'category': category,
      'stock': stock,
      'rating': rating,
      'reviewCount': reviewCount,
      'isFeatured': isFeatured,
      'sizes': sizes,
      'colors': colors,
    };
  }

  // Copy with method for immutability
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    List<String>? images,
    String? category,
    int? stock,
    double? rating,
    int? reviewCount,
    bool? isFeatured,
    List<String>? sizes,
    List<String>? colors,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      category: category ?? this.category,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFeatured: isFeatured ?? this.isFeatured,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
    );
  }
  
  // Helper getters
  bool get hasDiscount => originalPrice != null && originalPrice! > price;
  
  int get discountPercent {
    if (hasDiscount) {
      return ((originalPrice! - price) / originalPrice! * 100).round();
    }
    return 0;
  }
  
  bool get isInStock => stock > 0;
}
