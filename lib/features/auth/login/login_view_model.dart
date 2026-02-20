import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../../../core/utils/validators.dart';
import '../../../app/app_router.dart';
import '../model/login_request_model.dart';

// controls all logic for the login screen
// the view only calls methods from here, no logic in the view

class LoginViewModel extends GetxController {
  final AuthController _authController = Get.find<AuthController>();

  // -- form key for validation --
  final formKey = GlobalKey<FormState>();

  // -- text controllers --
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // -- observable state --
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // -- validators --
  String? validateEmail(String? value) => Validators.email(value);
  String? validatePassword(String? value) => Validators.password(value);

  // -- login --
  Future<void> login() async {
    // clear any previous errors
    errorMessage.value = '';

    // validate form first
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await _authController.login(
      LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );

    // if auth provider has an error show it
    if (_authController.errorMessage.isNotEmpty) {
      errorMessage.value = _authController.errorMessage.value;
    }

    isLoading.value = false;
  }

  // -- navigate to register --
  void goToRegister() => Get.toNamed(AppRoutes.register);

  // -- navigate to forgot password --
  void goToForgotPassword() => Get.toNamed(AppRoutes.forgotPassword);

  @override
  void onClose() {
    // always dispose controllers to avoid memory leaks
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}