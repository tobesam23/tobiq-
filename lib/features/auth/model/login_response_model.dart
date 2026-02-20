import 'user_model.dart';

// what i get back after a successful login
// wraps the user data and the firebase token together

class LoginResponseModel {
  final UserModel user;
  final String token;
  final bool isNewUser;

  const LoginResponseModel({
    required this.user,
    required this.token,
    this.isNewUser = false,
  });
}