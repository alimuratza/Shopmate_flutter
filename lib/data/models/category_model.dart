import 'package:flutter/material.dart';

// Category Model - represents category data
class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final int productCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.productCount = 0,
  });

  // Create CategoryModel from JSON (for Firebase/API)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: _getIconFromString(json['icon']),
      color: Color(json['color'] ?? 0xFF000000),
      productCount: json['productCount'] ?? 0,
    );
  }

  // Convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon.codePoint,
      'color': color.toARGB32(),
      'productCount': productCount,
    };
  }

  // Helper method to convert icon code point to IconData
  static IconData _getIconFromString(dynamic iconCode) {
    if (iconCode is int) {
      return IconData(iconCode, fontFamily: 'MaterialIcons');
    }
    return Icons.category;
  }

  // Copy with method for immutability
  CategoryModel copyWith({
    String? id,
    String? name,
    IconData? icon,
    Color? color,
    int? productCount,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      productCount: productCount ?? this.productCount,
    );
  }
}
