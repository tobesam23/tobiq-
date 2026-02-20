import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'register_view_model.dart';

// register screen - for new users creating an account

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(RegisterViewModel());

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
                Text('Create account', style: AppTextStyles.h1),
                const SizedBox(height: 8),
                Text(
                  'Sign up to get started',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),

                const SizedBox(height: 48),

                // -- name field --
                CustomTextField(
                  label: 'Full Name',
                  hint: 'Enter your name',
                  controller: vm.nameController,
                  validator: vm.validateName,
                  prefixIcon: Icons.person_outline,
                ),

                const SizedBox(height: 20),

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
                  hint: 'Create a password',
                  controller: vm.passwordController,
                  validator: vm.validatePassword,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                ),

                const SizedBox(height: 20),

                // -- confirm password field --
                CustomTextField(
                  label: 'Confirm Password',
                  hint: 'Re-enter your password',
                  controller: vm.confirmPasswordController,
                  validator: vm.validateConfirmPassword,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  prefixIcon: Icons.lock_outline,
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

                // -- register button --
                Obx(() => PrimaryButton(
                      label: 'Create Account',
                      onPressed: vm.register,
                      isLoading: vm.isLoading.value,
                    )),

                const SizedBox(height: 20),

                // -- login link --
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTextStyles.bodySmall,
                    ),
                    GestureDetector(
                      onTap: vm.goToLogin,
                      child: Text(
                        'Sign In',
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