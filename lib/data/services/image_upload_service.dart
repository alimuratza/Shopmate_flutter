import 'dart:typed_data';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:image_picker/image_picker.dart';

/// Service for uploading images to Cloudinary.
///
/// Cloudinary is a cloud-based image hosting service.
/// Images are uploaded and we get a URL back to store in Firestore.
class ImageUploadService {
  // ===========================================
  // IMPORTANT: Replace these with YOUR values!
  // ===========================================
  // 1. Go to https://cloudinary.com and sign up (free)
  // 2. Go to Dashboard
  // 3. Copy your "Cloud Name"
  // 4. Go to Settings > Upload > Upload presets
  // 5. Create a new preset with "Unsigned" mode
  // 6. Copy the preset name
  // ===========================================

  static const String _cloudName = 'dii8bskle'; // Your cloud name
  static const String _uploadPreset = 'flutter_products'; // Your upload preset

  final CloudinaryPublic _cloudinary = CloudinaryPublic(
    _cloudName,
    _uploadPreset,
    cache: false,
  );

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  /// Pick image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      return image;
    } catch (e) {
      print('Error picking image: $e');
      return null;
    }
  }

  /// Upload image file to Cloudinary and return the URL
  Future<String?> uploadImage(XFile imageFile) async {
    try {
      // Read file as bytes (works on web and mobile)
      final Uint8List bytes = await imageFile.readAsBytes();

      final CloudinaryResponse response = await _cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          bytes,
          identifier: imageFile.name,
          folder: 'products', // Images will be stored in 'products' folder
        ),
      );

      return response.secureUrl; // Returns the HTTPS URL of uploaded image
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  /// Pick and upload image in one step (convenience method)
  Future<String?> pickAndUploadFromGallery() async {
    final XFile? image = await pickImageFromGallery();
    if (image == null) return null;
    return uploadImage(image);
  }

  /// Pick from camera and upload (convenience method)
  Future<String?> pickAndUploadFromCamera() async {
    final XFile? image = await pickImageFromCamera();
    if (image == null) return null;
    return uploadImage(image);
  }
}
