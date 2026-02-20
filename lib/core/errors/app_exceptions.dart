// all my custom exceptions in one place
// instead of throwing generic errors i throw these so i know exactly what went wrong

class AppException implements Exception {
  final String message;
  final String? code;

  const AppException({required this.message, this.code});

  @override
  String toString() => message;
}

// thrown when login or register fails
class AuthException extends AppException {
  const AuthException({required super.message, super.code});
}

// thrown when a network request fails
class NetworkException extends AppException {
  const NetworkException({required super.message, super.code});
}

// thrown when something is not found - eg user document in firestore
class NotFoundException extends AppException {
  const NotFoundException({required super.message, super.code});
}

// thrown when the user doesn't have permission to do something
class PermissionException extends AppException {
  const PermissionException({required super.message, super.code});
}

// thrown when form input doesn't pass validation
class ValidationException extends AppException {
  const ValidationException({required super.message, super.code});
}

// maps firebase auth error codes to my custom auth exceptions
// so i never have to deal with raw firebase error strings in my UI
AuthException mapFirebaseAuthError(String code) {
  switch (code) {
    case 'user-not-found':
      return const AuthException(
        message: 'No account found with this email.',
        code: 'user-not-found',
      );
    case 'wrong-password':
      return const AuthException(
        message: 'Incorrect password. Please try again.',
        code: 'wrong-password',
      );
    case 'email-already-in-use':
      return const AuthException(
        message: 'An account already exists with this email.',
        code: 'email-already-in-use',
      );
    case 'invalid-email':
      return const AuthException(
        message: 'Please enter a valid email address.',
        code: 'invalid-email',
      );
    case 'weak-password':
      return const AuthException(
        message: 'Password must be at least 8 characters.',
        code: 'weak-password',
      );
    case 'too-many-requests':
      return const AuthException(
        message: 'Too many attempts. Please try again later.',
        code: 'too-many-requests',
      );
    case 'network-request-failed':
      return const AuthException(
        message: 'No internet connection. Please check your network.',
        code: 'network-request-failed',
      );
    default:
      return const AuthException(
        message: 'Wrong Email or Password.',
        code: 'unknown',
      );
  }
}