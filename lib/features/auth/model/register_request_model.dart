// the data i collect from the register form and send to firebase auth

class RegisterRequestModel {
  final String name;
  final String email;
  final String password;

  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}