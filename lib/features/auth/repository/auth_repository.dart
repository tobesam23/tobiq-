import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../service/auth_service.dart';
import '../../../core/storage/secure_storage.dart';

// repository sits between service and controller
// handles saving to secure storage after every auth action

class AuthRepository {
  final AuthService _authService = AuthService();

  // -- email login --
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _authService.login(request);
    await _saveSession(response.user.uid, response.user.email);
    return response;
  }

  // -- email register --
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final response = await _authService.register(request);
    await _saveSession(response.user.uid, response.user.email);
    return response;
  }

  // -- google sign in --
  Future<LoginResponseModel> signInWithGoogle() async {
    final response = await _authService.signInWithGoogle();
    await _saveSession(response.user.uid, response.user.email);
    return response;
  }

  // -- facebook sign in --
  Future<LoginResponseModel> signInWithFacebook() async {
    final response = await _authService.signInWithFacebook();
    await _saveSession(response.user.uid, response.user.email);
    return response;
  }

    // -- logout --
  Future<void> logout() async {
    await _authService.logout();
    await SecureStorage.clearAll();
  }

  // -- forgot password --
  Future<void> forgotPassword(String email) async {
    await _authService.forgotPassword(email);
  }

  // -- check if user is already logged in --
  Future<bool> isLoggedIn() async {
    return await SecureStorage.isLoggedIn();
  }

  // -- helper: save session to secure storage --
  Future<void> _saveSession(String uid, String email) async {
    await SecureStorage.setLoggedIn(true);
    await SecureStorage.setUserId(uid);
    await SecureStorage.setUserEmail(email);
  }
}