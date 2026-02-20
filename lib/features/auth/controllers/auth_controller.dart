import 'package:get/get.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../app/app_router.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

// main auth controller - manages all auth state and logic
// views and viewmodels interact with this, never with the repository directly

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // -- observable state --
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    isLoggedIn.value = await _authRepository.isLoggedIn();
  }

  // -- login --
  Future<void> login(LoginRequestModel request) async {
    try {
      _setLoading(true);
      _clearError();

      final LoginResponseModel response = await _authRepository.login(request);
      currentUser.value = response.user;
      isLoggedIn.value = true;

      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (e) {
      _setError(e.message);
    } on AppException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Something went wrong. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  // -- register --
  Future<void> register(RegisterRequestModel request) async {
    try {
      _setLoading(true);
      _clearError();

      final RegisterResponseModel response = await _authRepository.register(request);
      currentUser.value = response.user;
      isLoggedIn.value = true;

      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (e) {
      _setError(e.message);
    } on AppException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError('Something went wrong. Please try again.');
    } finally {
      _setLoading(false);
    }
  }

  // -- logout --
  Future<void> logout() async {
    try {
      _setLoading(true);
      await _authRepository.logout();
      currentUser.value = null;
      isLoggedIn.value = false;
      Get.offAllNamed(AppRoutes.login);
    } on AppException catch (e) {
      _setError(e.message);
    } finally {
      _setLoading(false);
    }
  }

  // -- forgot password --
  Future<void> forgotPassword(String email) async {
    try {
      _setLoading(true);
      _clearError();
      await _authRepository.forgotPassword(email);
    } on AppException catch (e) {
      _setError(e.message);
    } finally {
      _setLoading(false);
    }
  }

  // -- helpers --
  void _setLoading(bool value) => isLoading.value = value;
  void _setError(String message) => errorMessage.value = message;
  void _clearError() => errorMessage.value = '';
}