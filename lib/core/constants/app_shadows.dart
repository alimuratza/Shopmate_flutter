import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Consistent shadow styles used throughout the app
class AppShadows {
  // Light shadow for cards
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.08),
      blurRadius: 10,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // Medium shadow for elevated elements
  static List<BoxShadow> get elevatedShadow => [
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
      spreadRadius: 0,
    ),
  ];

  // Strong shadow for modals and dialogs
  static List<BoxShadow> get modalShadow => [
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.16),
      blurRadius: 30,
      offset: const Offset(0, 12),
      spreadRadius: 0,
    ),
  ];

  // Bottom navigation shadow
  static List<BoxShadow> get bottomNavShadow => [
    BoxShadow(
      color: AppColors.shadowColor.withOpacity(0.1),
      blurRadius: 20,
      offset: const Offset(0, -4),
      spreadRadius: 0,
    ),
  ];

  // Button shadow
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: AppColors.primary.withOpacity(0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  // Soft inner shadow (for pressed states)
  static List<BoxShadow> get innerShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
      spreadRadius: -1,
    ),
  ];
}
