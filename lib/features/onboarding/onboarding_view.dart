import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../shared/widgets/primary_button.dart';
import 'onboarding_view_model.dart';

// onboarding screen shown only on first app launch
// uses a pageview to swipe through the onboarding steps

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(OnboardingViewModel());
    final PageController pageController = PageController();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // -- skip button --
            Align(
              alignment: Alignment.topRight,
              child: Obx(() => vm.isLastPage
                  ? const SizedBox.shrink()
                  : TextButton(
                      onPressed: vm.skip,
                      child: Text(
                        'Skip',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.accent,
                        ),
                      ),
                    )),
            ),

            // -- pages --
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: vm.pages.length,
                onPageChanged: (index) => vm.currentPage.value = index,
                itemBuilder: (context, index) {
                  final page = vm.pages[index];
                  return _OnboardingPage(
                    title: page['title']!,
                    subtitle: page['subtitle']!,
                  );
                },
              ),
            ),

            // -- dots indicator --
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    vm.pages.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: vm.currentPage.value == index ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: vm.currentPage.value == index
                            ? AppColors.accent
                            : AppColors.divider,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )),

            const SizedBox(height: 32),

            // -- button --
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Obx(() => PrimaryButton(
                    label: vm.isLastPage ? 'Get Started' : 'Next',
                    onPressed: () {
                      if (vm.isLastPage) {
                        vm.finish();
                      } else {
                        vm.nextPage();
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  )),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// -- single onboarding page widget --
class _OnboardingPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // -- icon --
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(32),
            ),
            child: const Icon(
              Icons.bolt_rounded,
              color: AppColors.accent,
              size: 64,
            ),
          ),

          const SizedBox(height: 40),

          // -- title --
          Text(
            title,
            style: AppTextStyles.h2,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // -- subtitle --
          Text(
            subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}