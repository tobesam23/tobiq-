import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../features/auth/controllers/auth_controller.dart';
import 'app_router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tobiq',
      debugShowCheckedModeBanner: false,

      // registering auth controller globally so it's available everywhere
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);
      }),

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
      ),

      initialRoute: AppRoutes.splash,
      getPages: AppRouter.routes,
    );
  }
}