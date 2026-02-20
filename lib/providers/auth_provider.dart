import 'package:get/get.dart';
import '../features/auth/model/login_request_model.dart';
import '../features/auth/model/login_response_model.dart';
import '../features/auth/model/register_request_model.dart';
import '../features/auth/model/register_response_model.dart';
import '../features/auth/model/user_model.dart';
import '../features/auth/repository/auth_repository.dart';
import '../core/errors/app_exceptions.dart';
import '../app/app_router.dart';

// global auth state - getx makes this accessible from anywhere in the app
// this is what my views and viewmodels observe and react to

class AuthProvider extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // -- observable state --
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    // check login state when app starts
    _checkLoginState();
  }

  // -- check if user is already logged in on app start --
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

      // navigate to home after successful login
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

      final RegisterResponseModel response =
          await _authRepository.register(request);
      currentUser.value = response.user;
      isLoggedIn.value = true;

      // navigate to home after successful registration
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

      // send user back to login
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