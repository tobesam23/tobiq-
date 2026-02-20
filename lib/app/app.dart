import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import 'app_router.dart';

// root of my app
// getx initializes my global providers here so they're available everywhere

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tobiq',
      debugShowCheckedModeBanner: false,

      // registering my global auth provider so it's available app-wide
      initialBinding: BindingsBuilder(() {
        Get.put(AuthProvider(), permanent: true);
      }),

      // setting up my color scheme from app_colors
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBg,
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.accent,
          surface: AppColors.surface,
        ),
      ),

      // getx handles all my routing from app_router
      initialRoute: AppRoutes.splash,
      getPages: AppRouter.routes,
    );
  }
}