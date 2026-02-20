import 'package:get/get.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../app/app_router.dart';

// controls the onboarding flow
// tracks which page the user is on and handles navigation

class OnboardingViewModel extends GetxController {
  final RxInt currentPage = 0.obs;

  // -- onboarding pages content --
  final List<Map<String, String>> pages = [
    {
      'title': 'Welcome to Tobiq',
      'subtitle': 'Your journey starts here.',
      'icon': 'bolt_rounded',
    },
    {
      'title': 'Stay Connected',
      'subtitle': 'Everything you need in one place.',
      'icon': 'hub_rounded',
    },
    {
      'title': 'Ready to Go',
      'subtitle': 'Let\'s get you set up.',
      'icon': 'rocket_launch_rounded',
    },
  ];

  // -- check if on last page --
  bool get isLastPage => currentPage.value == pages.length - 1;

  // -- move to next page --
  void nextPage() {
    if (!isLastPage) {
      currentPage.value++;
    }
  }

  // -- skip onboarding --
  Future<void> skip() async {
    await _completeOnboarding();
  }

  // -- finish onboarding --
  Future<void> finish() async {
    await _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    // mark onboarding as done so we never show it again
    await SecureStorage.setOnboardingDone(true);
    Get.offAllNamed(AppRoutes.login);
  }
}