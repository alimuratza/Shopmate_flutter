import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/product_model.dart';
import '../../data/repos/product_firestore_repo.dart';
import '../../data/services/image_upload_service.dart';

class ProductsAdminVM extends GetxController {
  final ProductFirestoreRepo _repo = Get.find<ProductFirestoreRepo>();
  final ImageUploadService _imageService = ImageUploadService();

  // filters / query
  final searchController = TextEditingController();
  final categoryFilterController = TextEditingController();
  final selectedCategory = ''.obs; // empty means all
  final isSearching = false.obs;
  final searchResults = <ProductModel>[].obs;

  // form controllers
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final imageUrlController = TextEditingController();
  final stockController = TextEditingController(text: '0');

  final isSaving = false.obs;

  // Image upload state
  final isUploadingImage = false.obs;
  final selectedImagePath = RxnString(); // For preview before upload

  // Edit mode
  final editingProductId = RxnString(); // null = create mode, non-null = edit mode
  bool get isEditMode => editingProductId.value != null;

  /// Pick image from gallery and upload to Cloudinary
  Future<void> pickAndUploadImage() async {
    try {
      // First pick the image
      final XFile? image = await _imageService.pickImageFromGallery();
      if (image == null) return;

      // Show preview
      selectedImagePath.value = image.path;

      // Upload to Cloudinary
      isUploadingImage.value = true;
      final String? url = await _imageService.uploadImage(image);

      if (url != null) {
        imageUrlController.text = url;
        Get.snackbar('Success', 'Image uploaded!',
            backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Failed to upload image',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed: $e');
    } finally {
      isUploadingImage.value = false;
    }
  }

  /// Clear selected image
  void clearImage() {
    selectedImagePath.value = null;
    imageUrlController.clear();
  }

  Stream<List<ProductModel>> streamProducts() {
    final category = selectedCategory.value.trim();
    if (category.isEmpty) return _repo.streamAll();
    return _repo.streamByCategory(category);
  }

  Future<void> searchByName() async {
    final q = searchController.text.trim();
    if (q.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      isSearching.value = true;
      final results = await _repo.searchByNamePrefix(q);
      searchResults.assignAll(results);
    } catch (e) {
      Get.snackbar('Error', 'Search failed: $e');
    } finally {
      isSearching.value = false;
    }
  }

  void clearSearch() {
    searchController.clear();
    searchResults.clear();
  }

  /// Load product into form for editing
  void loadProductForEdit(ProductModel product) {
    editingProductId.value = product.id;
    nameController.text = product.name;
    descriptionController.text = product.description;
    categoryController.text = product.category;
    priceController.text = product.price.toString();
    stockController.text = product.stock.toString();
    imageUrlController.text = product.imageUrl ?? '';
    selectedImagePath.value = null; // Clear local preview when editing existing product
  }

  /// Cancel edit mode and clear form
  void cancelEdit() {
    editingProductId.value = null;
    _clearForm();
  }

  /// Create or Update based on mode
  Future<void> saveProduct() async {
    if (isEditMode) {
      await updateProduct();
    } else {
      await createProduct();
    }
  }

  Future<void> createProduct() async {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final category = categoryController.text.trim();
    final imageUrl = imageUrlController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;
    final stock = int.tryParse(stockController.text.trim()) ?? 0;

    if (name.isEmpty || category.isEmpty) {
      Get.snackbar('Error', 'Name and category are required');
      return;
    }

    final product = ProductModel(
      id: '',
      name: name,
      description: description,
      price: price,
      imageUrl: imageUrl.isEmpty ? 'https://via.placeholder.com/300' : imageUrl,
      category: category,
      stock: stock,
      rating: null,
    );

    try {
      isSaving.value = true;
      final id = await _repo.create(product);
      Get.snackbar('Success', 'Created product: $name');
      _clearForm();
    } catch (e) {
      Get.snackbar('Error', 'Create failed: $e');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> updateProduct() async {
    final id = editingProductId.value;
    if (id == null) return;

    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final category = categoryController.text.trim();
    final imageUrl = imageUrlController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;
    final stock = int.tryParse(stockController.text.trim()) ?? 0;

    if (name.isEmpty || category.isEmpty) {
      Get.snackbar('Error', 'Name and category are required');
      return;
    }

    try {
      isSaving.value = true;
      await _repo.updateFields(id, {
        'name': name,
        'description': description,
        'category': category,
        'price': price,
        'stock': stock,
        'imageUrl': imageUrl.isEmpty ? 'https://via.placeholder.com/300' : imageUrl,
      });
      Get.snackbar('Success', 'Updated product: $name');
      cancelEdit();
    } catch (e) {
      Get.snackbar('Error', 'Update failed: $e');
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      await _repo.delete(id);
      // If we were editing this product, cancel edit
      if (editingProductId.value == id) {
        cancelEdit();
      }
      Get.snackbar('Deleted', 'Product removed');
    } catch (e) {
      Get.snackbar('Error', 'Delete failed: $e');
    }
  }

  void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    categoryController.clear();
    priceController.clear();
    imageUrlController.clear();
    stockController.text = '0';
    selectedImagePath.value = null; // Clear image preview
  }

  @override
  void onClose() {
    searchController.dispose();
    categoryFilterController.dispose();
    nameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    stockController.dispose();
    super.onClose();
  }
}
