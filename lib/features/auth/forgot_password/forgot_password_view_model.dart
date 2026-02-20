import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/utils/validators.dart';

// controls all logic for the forgot password screen

class ForgotPasswordViewModel extends GetxController {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  // -- form key --
  final formKey = GlobalKey<FormState>();

  // -- text controller --
  final emailController = TextEditingController();

  // -- observable state --
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool emailSent = false.obs;

  // -- validator --
  String? validateEmail(String? value) => Validators.email(value);

  // -- send reset email --
  Future<void> sendResetEmail() async {
    errorMessage.value = '';

    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await _authProvider.forgotPassword(emailController.text.trim());

    if (_authProvider.errorMessage.isNotEmpty) {
      errorMessage.value = _authProvider.errorMessage.value;
    } else {
      // show success state
      emailSent.value = true;
    }

    isLoading.value = false;
  }

  // -- go back to login --
  void goBack() => Get.back();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}