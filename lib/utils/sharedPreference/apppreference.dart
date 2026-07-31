import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppPreferences {
  static SharedPreferences? _prefs;

  // Initialize SharedPreferences (call this in main before using)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> get _instance async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  // ========== AUTH KEYS ==========
  static const String _keyToken = 'token';
  static const String _keyUser = 'user';
  static const String _keyIsLoggedIn = 'isLoggedIn';

  // ========== LOCATION KEYS ========== 🔥
  static const String _keyLocationAddress = 'locationAddress';
  static const String _keyLocationLat = 'locationLat';
  static const String _keyLocationLng = 'locationLng';

  // =====================================================
  // ========== AUTH METHODS ==========
  // =====================================================

  // Save token
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await _instance;
      await prefs.setString(_keyToken, token);
      await prefs.setBool(_keyIsLoggedIn, true);
      return true;
    } catch (e) {
      print('❌ Error saving token: $e');
      return false;
    }
  }

  // Get token
  static Future<String?> getToken() async {
    try {
      final prefs = await _instance;
      return prefs.getString(_keyToken);
    } catch (e) {
      print('❌ Error getting token: $e');
      return null;
    }
  }

  // Save user data (as JSON string)
  static Future<bool> saveUser(Map<String, dynamic> userData) async {
    try {
      final prefs = await _instance;
      await prefs.setString(_keyUser, jsonEncode(userData));
      return true;
    } catch (e) {
      print('❌ Error saving user: $e');
      return false;
    }
  }

  // Get user data (returns Map or null)
  static Future<Map<String, dynamic>?> getUser() async {
    try {
      final prefs = await _instance;
      final userJson = prefs.getString(_keyUser);
      if (userJson != null) {
        return jsonDecode(userJson) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('❌ Error getting user: $e');
      return null;
    }
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await _instance;
      return prefs.getBool(_keyIsLoggedIn) ?? false;
    } catch (e) {
      print('❌ Error checking login status: $e');
      return false;
    }
  }

  // Clear all session data (logout)
  static Future<bool> clearSession() async {
    try {
      final prefs = await _instance;
      await prefs.remove(_keyToken);
      await prefs.remove(_keyUser);
      await prefs.setBool(_keyIsLoggedIn, false);
      return true;
    } catch (e) {
      print('❌ Error clearing session: $e');
      return false;
    }
  }

  // =====================================================
  // ========== LOCATION METHODS ========== 🔥
  // =====================================================

  // Save location details (address, latitude, longitude)
  static Future<bool> saveLocation({
    required String address,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final prefs = await _instance;
      await prefs.setString(_keyLocationAddress, address);
      await prefs.setDouble(_keyLocationLat, latitude);
      await prefs.setDouble(_keyLocationLng, longitude);
      print('✅ Location saved: $address');
      return true;
    } catch (e) {
      print('❌ Error saving location: $e');
      return false;
    }
  }

  // Get location (returns Map with address, latitude, longitude or null)
  static Future<Map<String, dynamic>?> getLocation() async {
    try {
      final prefs = await _instance;
      final address = prefs.getString(_keyLocationAddress);
      final lat = prefs.getDouble(_keyLocationLat);
      final lng = prefs.getDouble(_keyLocationLng);
      if (address != null && lat != null && lng != null) {
        return {
          'address': address,
          'latitude': lat,
          'longitude': lng,
        };
      }
      return null;
    } catch (e) {
      print('❌ Error getting location: $e');
      return null;
    }
  }

  // Get location address only (returns String or null)
  static Future<String?> getLocationAddress() async {
    try {
      final prefs = await _instance;
      return prefs.getString(_keyLocationAddress);
    } catch (e) {
      print('❌ Error getting location address: $e');
      return null;
    }
  }

  // Get location latitude only (returns double or null)
  static Future<double?> getLocationLatitude() async {
    try {
      final prefs = await _instance;
      return prefs.getDouble(_keyLocationLat);
    } catch (e) {
      print('❌ Error getting location latitude: $e');
      return null;
    }
  }

  // Get location longitude only (returns double or null)
  static Future<double?> getLocationLongitude() async {
    try {
      final prefs = await _instance;
      return prefs.getDouble(_keyLocationLng);
    } catch (e) {
      print('❌ Error getting location longitude: $e');
      return null;
    }
  }

  // Clear location data
  static Future<bool> clearLocation() async {
    try {
      final prefs = await _instance;
      await prefs.remove(_keyLocationAddress);
      await prefs.remove(_keyLocationLat);
      await prefs.remove(_keyLocationLng);
      print('✅ Location cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing location: $e');
      return false;
    }
  }

  // =====================================================
  // ========== CLEAR ALL METHODS ==========
  // =====================================================

  // Clear everything (auth + location)
  static Future<bool> clearAll() async {
    try {
      final prefs = await _instance;
      await prefs.clear();
      print('✅ All preferences cleared');
      return true;
    } catch (e) {
      print('❌ Error clearing all: $e');
      return false;
    }
  }
}