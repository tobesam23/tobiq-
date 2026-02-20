// all my app-wide constants in one place
class AppConstants {
  AppConstants._(); // private constructor

  // -- app info --
  static const String appName = 'Tobiq';
  static const String appVersion = '1.0.0';

  // -- firebase collections --
  // these are the exact collection names i use in firestore
  static const String usersCollection = 'users';

  // -- shared preferences / storage keys --
  // keys i use when reading and writing to secure storage
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';
  static const String keyOnboardingDone = 'onboarding_done';

  // -- validation limits --
  static const int passwordMinLength = 8;
  static const int nameMinLength = 2;
  static const int nameMaxLength = 50;

  // -- timeouts --
  static const int splashDuration = 3; // seconds before moving off splash screen
}