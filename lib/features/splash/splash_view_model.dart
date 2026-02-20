import 'package:get/get.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../app/app_router.dart';
import '../../../core/constants/app_constants.dart';

// controls what happens on the splash screen
// checks if user is logged in and where to navigate next

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    // wait for splash duration before navigating
    await Future.delayed(Duration(seconds: AppConstants.splashDuration));

    final isLoggedIn = await SecureStorage.isLoggedIn();
    final isOnboardingDone = await SecureStorage.isOnboardingDone();

    if (isLoggedIn) {
      // user already has a session - go straight to home
      Get.offAllNamed(AppRoutes.home);
    } else if (!isOnboardingDone) {
      // first time user - show onboarding
      Get.offAllNamed(AppRoutes.onboarding);
    } else {
      // returning user not logged in - go to login
      Get.offAllNamed(AppRoutes.login);
    }
  }
}