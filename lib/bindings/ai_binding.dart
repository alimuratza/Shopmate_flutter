import 'package:get/get.dart';
import '../../ui/ai/ai_view_model.dart';

class AIBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AIViewModel>(() => AIViewModel());
  }
}
