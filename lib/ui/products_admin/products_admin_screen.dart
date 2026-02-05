import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/product_model.dart';
import 'products_admin_vm.dart';

class ProductsAdminScreen extends GetView<ProductsAdminVM> {
  const ProductsAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products Admin'),
        elevation: 0,
      ),
      body: Row(
        children: [
          // Left side - Form
          Expanded(
            flex: 2,
            child: _buildFormSection(context),
          ),
          const VerticalDivider(width: 1),
          // Right side - Products List
          Expanded(
            flex: 3,
            child: _buildListSection(context),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form Header
            Obx(() => Row(
                  children: [
                    Icon(
                      controller.isEditMode ? Icons.edit : Icons.add_circle,
                      color: controller.isEditMode ? Colors.orange : Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      controller.isEditMode ? 'Edit Product' : 'Create Product',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    if (controller.isEditMode)
                      TextButton.icon(
                        onPressed: controller.cancelEdit,
                        icon: const Icon(Icons.close, size: 18),
                        label: const Text('Cancel'),
                      ),
                  ],
                )),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Form Fields
            _buildTextField(
              controller: controller.nameController,
              label: 'Product Name *',
              icon: Icons.shopping_bag,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: controller.categoryController,
              label: 'Category * (e.g. Electronics, Fashion)',
              icon: Icons.category,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: controller.priceController,
                    label: 'Price (₹)',
                    icon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: controller.stockController,
                    label: 'Stock',
                    icon: Icons.inventory,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Image Upload Section
            const Text(
              'Product Image',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Obx(() => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    children: [
                      // Image Preview
                      if (controller.imageUrlController.text.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            controller.imageUrlController.text,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              height: 120,
                              color: Colors.grey[200],
                              child: const Icon(Icons.broken_image, size: 40),
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, size: 40, color: Colors.grey),
                        ),
                      const SizedBox(height: 12),
                      // Upload Button
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: controller.isUploadingImage.value
                                  ? null
                                  : controller.pickAndUploadImage,
                              icon: controller.isUploadingImage.value
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    )
                                  : const Icon(Icons.cloud_upload, size: 18),
                              label: Text(controller.isUploadingImage.value
                                  ? 'Uploading...'
                                  : 'Upload Image'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          if (controller.imageUrlController.text.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: controller.clearImage,
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: 'Remove image',
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 12),
            _buildTextField(
              controller: controller.descriptionController,
              label: 'Description (optional)',
              icon: Icons.description,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // Save Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: controller.isSaving.value ? null : controller.saveProduct,
                    icon: controller.isSaving.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Icon(controller.isEditMode ? Icons.save : Icons.add),
                    label: Text(
                      controller.isEditMode ? 'Update Product' : 'Create Product',
                      style: const TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: controller.isEditMode ? Colors.orange : Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                )),

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // Search Section
            const Text(
              'Search Products',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: controller.clearSearch,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (_) => controller.searchByName(),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: controller.searchByName,
                child: const Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildListSection(BuildContext context) {
    return Column(
      children: [
        // Filter Bar
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.blue[50],
          child: Row(
            children: [
              const Icon(Icons.filter_list, color: Colors.blue),
              const SizedBox(width: 8),
              const Text('Filter by Category:'),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller.categoryFilterController,
                  decoration: InputDecoration(
                    hintText: 'All categories',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (v) => controller.selectedCategory.value = v.trim(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.selectedCategory.value = '';
                  controller.categoryFilterController.clear();
                },
              ),
            ],
          ),
        ),

        // Products List
        Expanded(
          child: Obx(() {
            final searchItems = controller.searchResults;
            final isSearching = controller.isSearching.value;
            final isShowingSearch = controller.searchController.text.trim().isNotEmpty;

            if (isShowingSearch) {
              if (isSearching) {
                return const Center(child: CircularProgressIndicator());
              }
              if (searchItems.isEmpty) {
                return _buildEmptyState('No search results', Icons.search_off);
              }
              return _ProductsGrid(
                items: searchItems,
                onEdit: controller.loadProductForEdit,
                onDelete: controller.deleteProduct,
                editingId: controller.editingProductId.value,
              );
            }

            return StreamBuilder<List<ProductModel>>(
              stream: controller.streamProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final items = snapshot.data ?? [];
                if (items.isEmpty) {
                  return _buildEmptyState('No products yet', Icons.inventory_2_outlined);
                }

                return _ProductsGrid(
                  items: items,
                  onEdit: controller.loadProductForEdit,
                  onDelete: controller.deleteProduct,
                  editingId: controller.editingProductId.value,
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid({
    required this.items,
    required this.onEdit,
    required this.onDelete,
    this.editingId,
  });

  final List<ProductModel> items;
  final void Function(ProductModel product) onEdit;
  final void Function(String id) onDelete;
  final String? editingId;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final p = items[index];
        final isEditing = editingId == p.id;

        return Card(
          elevation: isEditing ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isEditing ? Colors.orange : Colors.transparent,
              width: 2,
            ),
          ),
          child: InkWell(
            onTap: () => onEdit(p),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with actions
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          p.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.blue[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: isEditing ? Colors.orange : Colors.grey,
                        ),
                        onPressed: () => onEdit(p),
                        tooltip: 'Edit',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                        onPressed: () => _confirmDelete(context, p),
                        tooltip: 'Delete',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Image
                  Expanded(
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: (p.imageUrl?.isNotEmpty ?? false)
                            ? Image.network(
                                p.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => _buildPlaceholder(),
                              )
                            : _buildPlaceholder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Name
                  Text(
                    p.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Price & Stock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₹${p.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: p.stock > 0 ? Colors.green[50] : Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Stock: ${p.stock}',
                          style: TextStyle(
                            fontSize: 11,
                            color: p.stock > 0 ? Colors.green[700] : Colors.red[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.shopping_bag, size: 40, color: Colors.blue),
    );
  }

  void _confirmDelete(BuildContext context, ProductModel product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Product?'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              onDelete(product.id);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
