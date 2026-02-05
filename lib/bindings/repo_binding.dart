import 'package:get/get.dart';

import '../data/repos/auth_repo.dart';
import '../data/repos/product_repo.dart';
import '../data/repos/product_firestore_repo.dart';

/// Registers app repositories for dependency injection.
///
/// This keeps ViewModels clean (no `AuthRepo()` inside VMs) and matches
/// the teacher DI pattern: bindings create dependencies, VMs consume them.
class RepoBinding extends Bindings {
  @override
  void dependencies() {
    // Auth repository (Firebase auth wrapper)
    Get.lazyPut<AuthRepo>(() => AuthRepo(), fenix: true);

    // Product repository (local demo data / later firestore)
    Get.lazyPut<ProductRepo>(() => ProductRepo(), fenix: true);

    // Firestore-backed product repository (quiz/assignment)
    Get.lazyPut<ProductFirestoreRepo>(() => ProductFirestoreRepo(), fenix: true);
  }
}
