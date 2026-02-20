import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/utils/validators.dart';
import '../../../app/app_router.dart';
import '../model/register_request_model.dart';

// controls all logic for the register screen

class RegisterViewModel extends GetxController {
  final AuthProvider _authProvider = Get.find<AuthProvider>();

  // -- form key --
  final formKey = GlobalKey<FormState>();

  // -- text controllers --
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // -- observable state --
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // -- validators --
  String? validateName(String? value) => Validators.name(value);
  String? validateEmail(String? value) => Validators.email(value);
  String? validatePassword(String? value) => Validators.password(value);
  String? validateConfirmPassword(String? value) =>
      Validators.confirmPassword(value, passwordController.text);

  // -- register --
  Future<void> register() async {
    errorMessage.value = '';

    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    await _authProvider.register(
      RegisterRequestModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );

    if (_authProvider.errorMessage.isNotEmpty) {
      errorMessage.value = _authProvider.errorMessage.value;
    }

    isLoading.value = false;
  }

  // -- navigate back to login --
  void goToLogin() => Get.toNamed(AppRoutes.login);

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}