import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'splash_view_model.dart';

// first screen the user sees when they open the app
// shows the logo and brand name while we check login state

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize the viewmodel which handles navigation
    Get.put(SplashViewModel());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // -- logo placeholder --
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.bolt_rounded,
                color: AppColors.primary,
                size: 50,
              ),
            ),

            const SizedBox(height: 24),

            // -- app name --
            Text(
              'tobiq',
              style: AppTextStyles.h1.copyWith(
                color: AppColors.textPrimary,
                letterSpacing: 4,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            // -- tagline --
            Text(
              'built different.',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.accent,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}