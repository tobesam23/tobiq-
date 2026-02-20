import '../constants/app_constants.dart';

// all my form validation logic in one place
// each method returns null if valid, or an error string if invalid
// this is the format flutter form validators expect

class Validators {
  Validators._(); // private constructor

  // -- email --
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    // basic email pattern check
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  // -- password --
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < AppConstants.passwordMinLength) {
      return 'Password must be at least ${AppConstants.passwordMinLength} characters.';
    }
    // must have at least one letter and one number
    if (!value.contains(RegExp(r'[a-zA-Z]'))) {
      return 'Password must contain at least one letter.';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    return null;
  }

  // -- confirm password --
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password.';
    }
    if (value != original) {
      return 'Passwords do not match.';
    }
    return null;
  }

  // -- name --
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required.';
    }
    if (value.trim().length < AppConstants.nameMinLength) {
      return 'Name must be at least ${AppConstants.nameMinLength} characters.';
    }
    if (value.trim().length > AppConstants.nameMaxLength) {
      return 'Name must be less than ${AppConstants.nameMaxLength} characters.';
    }
    return null;
  }

  // -- required field (generic) --
  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }
}