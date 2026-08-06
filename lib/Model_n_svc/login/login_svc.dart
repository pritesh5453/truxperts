import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/login/login_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  // =====================================================
  // LOGIN
  // =====================================================
  Future<LoginResponse> login({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      print('🔷 LOGIN REQUEST');
      print('📍 URL: ${ApiEndpoints.login}');
      print('📦 Data: {"mobile_number": "$mobileNumber", "password": "********"}');

      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'mobile_number': mobileNumber,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('🔶 LOGIN RESPONSE');
      print('📊 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ Success Response Data:');
        print(response.data);

        final loginResponse = LoginResponse.fromJson(response.data);
        print('🔑 Token: ${loginResponse.token}');
        print('👤 User: ${loginResponse.user.fullName ?? loginResponse.user.ownerName ?? 'N/A'} (${loginResponse.user.mobileNumber ?? 'N/A'})');
        print('📋 Account Type: ${loginResponse.user.accountType}');

        // ✅ Save token and user data to SharedPreferences
        await _saveLoginData(loginResponse);

        return loginResponse;
      } else {
        print('❌ Error Response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ DIO EXCEPTION:');
      print('   Message: ${e.message}');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('❌ UNEXPECTED ERROR: $e');
      rethrow;
    }
  }

  // =====================================================
  // SAVE LOGIN DATA
  // =====================================================
  Future<void> _saveLoginData(LoginResponse response) async {
    try {
      // Save token
      await AppPreferences.saveToken(response.token);

      // Save user data
      final userData = {
        'id': response.user.id,
        'account_type': response.user.accountType,
        'full_name': response.user.fullName,
        'mobile_number': response.user.mobileNumber,
        'email': response.user.email,
        'location': response.user.location,
        'city': response.user.city,
        'state': response.user.state,
        'latitude': response.user.latitude,
        'longitude': response.user.longitude,
        'business_name': response.user.businessName,
        'owner_name': response.user.ownerName,
        'service_type': response.user.serviceType,
        'verification_status': response.user.verificationStatus,
      };
      await AppPreferences.saveUser(userData);

      print('✅ Login data saved to SharedPreferences');
    } catch (e) {
      print('❌ Failed to save login data: $e');
    }
  }

  // =====================================================
  // LOGOUT
  // =====================================================
  Future<void> logout() async {
    try {
      await AppPreferences.clearSession(); // or clearAll() if you want to remove everything
      print('✅ Logged out successfully');
    } catch (e) {
      print('❌ Logout error: $e');
    }
  }

  // =====================================================
  // CHECK LOGIN STATUS
  // =====================================================
  Future<bool> isLoggedIn() async {
    return await AppPreferences.isLoggedIn();
  }

  // =====================================================
  // GET CURRENT USER
  // =====================================================
  Future<Map<String, dynamic>?> getCurrentUser() async {
    return await AppPreferences.getUser();
  }

  // =====================================================
  // GET TOKEN
  // =====================================================
  Future<String?> getToken() async {
    return await AppPreferences.getToken();
  }
}