import '../model/login_request_model.dart';
import '../model/login_response_model.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';
import '../service/auth_service.dart';
import '../../../core/storage/secure_storage.dart';

// the repository sits between the service and the viewmodel
// it calls the service and also handles saving to secure storage
// the viewmodel never talks to the service directly

class AuthRepository {
  final AuthService _authService = AuthService();

  // -- login --
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _authService.login(request);

    // save session data locally after successful login
    await SecureStorage.setLoggedIn(true);
    await SecureStorage.setUserId(response.user.uid);
    await SecureStorage.setUserEmail(response.user.email);

    return response;
  }

  // -- register --
  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    final response = await _authService.register(request);

    // save session data locally after successful registration
    await SecureStorage.setLoggedIn(true);
    await SecureStorage.setUserId(response.user.uid);
    await SecureStorage.setUserEmail(response.user.email);

    return response;
  }

  // -- logout --
  Future<void> logout() async {
    await _authService.logout();

    // wipe everything from local storage on logout
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
}