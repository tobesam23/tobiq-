import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';
import 'login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(LoginViewModel());
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: vm.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                // -- header --
                Text(
                  'Welcome Back',
                  style: AppTextStyles.h1.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your account',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                // -- email field --
                CustomTextField(
                  label: 'Email',
                  hint: 'Email',
                  controller: vm.emailController,
                  validator: vm.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 16),

                // -- password field --
                CustomTextField(
                  label: 'Password',
                  hint: 'Password',
                  controller: vm.passwordController,
                  validator: vm.validatePassword,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 16),

                // -- error message --
                Obx(() => vm.errorMessage.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          vm.errorMessage.value,
                          style: AppTextStyles.errorText,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox.shrink()),

                // -- login button --
                Obx(() => PrimaryButton(
                      label: 'Log In',
                      onPressed: vm.login,
                      isLoading: vm.isLoading.value,
                    )),

                const SizedBox(height: 12),

                // -- forgot password --
                Center(
                  child: GestureDetector(
                    onTap: vm.goToForgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // -- or divider --
                Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.divider)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'or',
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.divider)),
                  ],
                ),

                const SizedBox(height: 24),

                // -- social buttons --
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // google
                        _SocialButton(
                          icon: 'G',
                          color: const Color(0xFFDB4437),
                          onTap: authController.isSocialLoading.value
                              ? null
                              : authController.signInWithGoogle,
                        ),

                        const SizedBox(width: 20),

                        // facebook
                        _SocialButton(
                          icon: 'f',
                          color: const Color(0xFF1877F2),
                          onTap: authController.isSocialLoading.value
                              ? null
                              : authController.signInWithFacebook,
                        ),
                      ],
                    )),

                const SizedBox(height: 32),

                // -- register link --
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.bodySmall,
                      ),
                      GestureDetector(
                        onTap: vm.goToRegister,
                        child: Text(
                          'Sign Up',
                          style: AppTextStyles.link,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -- reusable social sign in button --
class _SocialButton extends StatelessWidget {
  final String icon;
  final Color color;
  final VoidCallback? onTap;

  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.divider),
        ),
        child: Center(
          child: Text(
            icon,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    