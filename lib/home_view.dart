import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_text_styles.dart';
import 'providers/auth_provider.dart';

// placeholder home screen - will be built out after auth is done

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Get.find<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You are logged in!', style: AppTextStyles.h2),
            const SizedBox(height: 24),
            TextButton(
              onPressed: authProvider.logout,
              child: Text(
                'Logout',
                style: AppTextStyles.link,
              ),
            ),
          ],
        ),
      ),
    );
  }
}