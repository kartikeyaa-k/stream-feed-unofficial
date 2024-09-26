import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
/// `SecureTokenStorage` This class is not utilised in this version
/// In the next release will be working on this
class SecureTokenStorage {
  // Create a secure storage instance
  final _storage = const FlutterSecureStorage();

  /// Stores the token securely with the given key
  Future<void> storeToken(String key, String token) async {
    try {
      await _storage.write(key: key, value: token);
    } catch (e) {
      if (kDebugMode) {
        print('Error storing token: $e');
      }
      throw Exception('Failed to store token securely');
    }
  }

  /// Retrieves the token securely using the given key
  Future<String?> getToken(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving token: $e');
      }
      return null;
    }
  }

  /// Deletes the token securely using the given key
  Future<void> deleteToken(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting token: $e');
      }
      throw Exception('Failed to delete token securely');
    }
  }

  /// Clears all stored tokens (use cautiously)
  Future<void> clearAllTokens() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing all tokens: $e');
      }
      throw Exception('Failed to clear tokens securely');
    }
  }
}
