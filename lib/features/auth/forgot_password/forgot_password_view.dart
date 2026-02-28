import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import 'forgot_password_view_model.dart';

// forgot password screen - redesigned to match new UI

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.put(ForgotPasswordViewModel());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.textPrimary, size: 20),
          onPressed: vm.goBack,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Obx(() => vm.emailSent.value
              ? _SuccessState()
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          // -- lock icon --
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_outline,
              color: AppColors.primary,
              size: 48,
            ),
          ),

          const SizedBox(height: 32),

          // -- header --
          Text(
            'Forgot password?',
            style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            'Enter your email address to receive a verification code',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // -- email field --
          CustomTextField(
            label: 'Email',
            hint: 'Email',
            controller: vm.emailController,
            validator: vm.validateEmail,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
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

          // -- send button --
          Obx(() => PrimaryButton(
                label: 'Send',
                onPressed: vm.sendResetEmail,
                isLoading: vm.isLoading.value,
              )),

          const SizedBox(height: 20),

          // -- back to login --
          GestureDetector(
            onTap: vm.goBack,
            child: Text(
              'Back to login',
              style: AppTextStyles.link,
            ),
          ),
        ],
      ),
    );
  }
}

// -- success state --
class _SuccessState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.mark_email_read_outlined,
              color: AppColors.primary,
              size: 48,
            ),
          ),

          const SizedBox(height: 32),

          Text('Check your email', style: AppTextStyles.h2.copyWith(
            color: AppColors.textPrimary,
          )),

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