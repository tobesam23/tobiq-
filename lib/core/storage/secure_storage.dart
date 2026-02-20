import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

// wrapper around flutter_secure_storage
// all reads and writes to local secure storage go through here
// nothing gets stored as plain text on the device

class SecureStorage {
  SecureStorage._(); // private constructor

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true, // using encrypted shared prefs on android
    ),
  );

  // -- write --
  static Future<void> setLoggedIn(bool value) async {
    await _storage.write(
      key: AppConstants.keyIsLoggedIn,
      value: value.toString(),
    );
  }

  static Future<void> setUserId(String userId) async {
    await _storage.write(key: AppConstants.keyUserId, value: userId);
  }

  static Future<void> setUserEmail(String email) async {
    await _storage.write(key: AppConstants.keyUserEmail, value: email);
  }

  static Future<void> setOnboardingDone(bool value) async {
    await _storage.write(
      key: AppConstants.keyOnboardingDone,
      value: value.toString(),
    );
  }

  // -- read --
  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: AppConstants.keyIsLoggedIn);
    return value == 'true';
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: AppConstants.keyUserId);
  }

  static Future<String?> getUserEmail() async {
    return await _storage.read(key: AppConstants.keyUserEmail);
  }

  static Future<bool> isOnboardingDone() async {
    final value = await _storage.read(key: AppConstants.keyOnboardingDone);
    return value == 'true';
  }

  // -- delete --
  // call this on logout to wipe everything
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}