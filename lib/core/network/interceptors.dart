import 'package:firebase_auth/firebase_auth.dart';

// interceptors handle things that need to happen on every request
// like attaching the firebase token automatically so i dont do it manually each time

class Interceptors {
  Interceptors._(); // private constructor

  // -- get current user token --
  // call this before any authenticated http request
  // firebase refreshes the token automatically if it has expired
  static Future<String?> getAuthToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      // forceRefresh: false means use cached token if still valid
      final token = await user.getIdToken(false);
      return token;
    } catch (e) {
      return null;
    }
  }

  // -- check if user is authenticated --
  static bool isAuthenticated() {
    return FirebaseAuth.instance.currentUser != null;
  }

  // -- log request (for debugging) --
  // i can remove this in production
  static void logRequest(String method, String endpoint, {Map<String, dynamic>? body}) {
    assert(() {
      print('── REQUEST ──────────────────────');
      print('$method $endpoint');
      if (body != null) print('Body: $body');
      print('─────────────────────────────────');
      return true;
    }());
  }

  // -- log response (for debugging) --
  static void logResponse(int statusCode, dynamic body) {
    assert(() {
      print('── RESPONSE ─────────────────────');
      print('Status: $statusCode');
      print('Body: $body');
      print('─────────────────────────────────');
      return true;
    }());
  }
}