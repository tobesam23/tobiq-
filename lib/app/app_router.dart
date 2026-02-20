import 'package:get/get.dart';
import '../features/splash/splash_view.dart';
import '../features/onboarding/onboarding_view.dart';
import '../features/auth/login/login_view.dart';
import '../features/auth/register/register_view.dart';
import '../features/auth/forgot_password/forgot_password_view.dart';
import '../home_view.dart';

// all my app routes in one place
// no hardcoded route strings anywhere else in the app

class AppRoutes {
  AppRoutes._(); // private constructor

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
}

class AppRouter {
  AppRouter._(); // private constructor

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
    ),
  ];
}