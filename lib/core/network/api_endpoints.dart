// all my API endpoint strings live here
// even though firebase handles most things, i keep this here
// in case i add a custom backend later

class ApiEndpoints {
  ApiEndpoints._(); // private constructor

  // -- base --
  static const String baseUrl = 'https://api.tobiq.com'; // update when backend is ready

  // -- auth endpoints (for future custom backend) --
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';
  static const String refreshToken = '/auth/refresh-token';

  // -- user endpoints --
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/update';
  static const String deleteAccount = '/user/delete';
}