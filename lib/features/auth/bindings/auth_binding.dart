import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

// auth binding - tells getx what to initialize when auth routes are loaded
// this replaces manually calling Get.put() in each view

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}