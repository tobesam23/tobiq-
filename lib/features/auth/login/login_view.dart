import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'login_view_model.dart';

// login screen - entry point for returning users

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(LoginViewModel());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
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
                Text('Welcome back', style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text(
                  'Sign in to your account',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 48),

                // -- email field --
                CustomTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: vm.emailController,
                  validator: vm.validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                // -- password field --
                CustomTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: vm.passwordController,
                  validator: vm.validatePassword,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 12),

                // -- forgot password --
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: vm.goToForgotPassword,
                    child: Text(
                      'Forgot password?',
                      style: AppTextStyles.link,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // -- error message --
                Obx(() => vm.errorMessage.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          vm.errorMessage.value,
                          style: AppTextStyles.errorText,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox.shrink()),

                // -- login button --
                Obx(() => PrimaryButton(
                      label: 'Sign In',
                      onPressed: vm.login,
                      isLoading: vm.isLoading.value,
                    )),

                const SizedBox(height: 20),

                // -- register link --
                Row(
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

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}