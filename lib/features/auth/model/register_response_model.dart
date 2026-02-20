import 'user_model.dart';

// what i get back after a successful registration
// same structure as login response but always marks isNewUser as true

class RegisterResponseModel {
  final UserModel user;
  final String token;
  final bool isNewUser;

  const RegisterResponseModel({
    required this.user,
    required this.token,
    this.isNewUser = true, // always true on register
  });
}