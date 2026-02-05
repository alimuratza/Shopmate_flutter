import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import 'categories_vm.dart';

class CategoriesScreen extends GetView<CategoriesVM> {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowColor.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
          ),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Browse by category',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildCategoryCard(
                    name: 'Electronics',
                    icon: Icons.phone_android_rounded,
                    color: AppColors.info,
                    count: 120,
                    onTap: () => controller.openCategory('Electronics'),
                  ),
                  _buildCategoryCard(
                    name: 'Fashion',
                    icon: Icons.checkroom_rounded,
                    color: AppColors.accent,
                    count: 250,
                    onTap: () => controller.openCategory('Fashion'),
                  ),
                  _buildCategoryCard(
                    name: 'Home & Living',
                    icon: Icons.home_rounded,
                    color: AppColors.warning,
                    count: 85,
                    onTap: () => controller.openCategory('Home'),
                  ),
                  _buildCategoryCard(
                    name: 'Sports',
                    icon: Icons.sports_basketball_rounded,
                    color: AppColors.success,
                    count: 64,
                    onTap: () => controller.openCategory('Sports'),
                  ),
                  _buildCategoryCard(
                    name: 'Books',
                    icon: Icons.menu_book_rounded,
                    color: AppColors.primary,
                    count: 180,
                    onTap: () => controller.openCategory('Books'),
                  ),
                  _buildCategoryCard(
                    name: 'Toys & Games',
                    icon: Icons.toys_rounded,
                    color: const Color(0xFFE91E63),
                    count: 95,
                    onTap: () => controller.openCategory('Toys'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required String name,
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 14),
            Text(
              name,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              '$count items',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}