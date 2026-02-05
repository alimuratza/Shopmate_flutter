import 'package:get/get.dart';
import '../ui/splash/splash_vm.dart';
import '../ui/profile/profile_vm.dart';
import 'repo_binding.dart';

// Initial Binding - Loaded at app startup
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Register app-wide repositories/services first
    RepoBinding().dependencies();

    // Put SplashVM as permanent so it survives route changes
    Get.put<SplashVM>(SplashVM(), permanent: true);

    // Safety net: Home bottom-nav instantiates tabs directly, so ensure ProfileVM
    // exists even if ProfileScreen is built outside the /profile route/binding.
    // Using fenix makes it re-creatable if disposed.
    Get.lazyPut<ProfileVM>(() => ProfileVM(), fenix: true);
  }
}
