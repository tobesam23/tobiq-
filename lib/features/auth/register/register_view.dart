import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';
import 'register_view_model.dart';

// register screen - redesigned to match new UI

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(RegisterViewModel());
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
                Text('Create Account', style: AppTextStyles.h1.copyWith(
                  color: AppColors.textPrimary,
                )),
                const SizedBox(height: 8),
                Text(
                  'Start your career with us',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 40),

                // -- name field --
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Full name',
                  controller: vm.nameController,
                  validator: vm.validateName,
                  prefixIcon: Icons.person_outline,
                ),

                const SizedBox(height: 16),

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
                  prefixIcon: Icons.lock_outline,
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

                // -- register button --
                Obx(() => PrimaryButton(
                      label: 'Sign Up',
                      onPressed: vm.register,
                      isLoading: vm.isLoading.value,
                    )),

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
                    )
                    ),

                     

                const SizedBox(height: 24),

                // -- terms of service --
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        const TextSpan(text: 'By signing up you accept the '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // -- login link --
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: AppTextStyles.bodySmall,
                      ),
                      GestureDetector(
                        onTap: vm.goToLogin,
                        child: Text(
                          'Log In',
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
  final bool isApple;

  const _SocialButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.isApple = false,
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
          child: isApple
              ? const Icon(Icons.apple, color: Colors.black, size: 28)
              : Text(
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