import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'forgot_password_view_model.dart';

// forgot password screen - sends a reset email to the user

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(ForgotPasswordViewModel());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: vm.goBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() => vm.emailSent.value
              ? _SuccessState() // show success after email is sent
              : _FormState(vm: vm)),
        ),
      ),
    );
  }
}

// -- form state --
class _FormState extends StatelessWidget {
  final ForgotPasswordViewModel vm;

  const _FormState({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          // -- header --
          Text('Forgot Password', style: AppTextStyles.h1),
          const SizedBox(height: 8),
          Text(
            'Enter your email and we\'ll send you a reset link.',
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
            textInputAction: TextInputAction.done,
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

          // -- send button --
          Obx(() => PrimaryButton(
                label: 'Send Reset Link',
                onPressed: vm.sendResetEmail,
                isLoading: vm.isLoading.value,
              )),
        ],
      ),
    );
  }
}

// -- success state shown after email is sent --
class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // -- icon --
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.accent,
              size: 48,
            ),
          ),

          const SizedBox(height: 32),

          Text('Check your email', style: AppTextStyles.h2),
          const SizedBox(height: 12),
          Text(
            'We sent a password reset link to your email address.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          PrimaryButton(
            label: 'Back to Login',
            onPressed: () => Get.back(),
            isOutlined: true,
          ),
        ],
      ),
    );
  }
}