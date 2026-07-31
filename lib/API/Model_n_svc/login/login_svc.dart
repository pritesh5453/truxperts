import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:truxperts/API/Model_n_svc/login/login_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  /// Login API call with full logging
  Future<LoginResponse> login({
    required String mobileNumber,
    required String password,
  }) async {
    try {
      // Log request details
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

      // Log response status
      print('🔶 LOGIN RESPONSE');
      print('📊 Status Code: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        // Log full response data
        print('✅ Success Response Data:');
        print(response.data); // full JSON
        
        // Parse and log token separately
        final loginResponse = LoginResponse.fromJson(response.data);
        print('🔑 Token: ${loginResponse.token}');
        print('👤 User: ${loginResponse.user.fullName} (${loginResponse.user.mobileNumber})');
        
        return loginResponse;
      } else {
        // Log error response
        print('❌ Error Response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // Log Dio error details
      print('❌ DIO EXCEPTION:');
      print('   Message: ${e.message}');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');
      throw e;
    } catch (e) {
      // Catch any other unexpected errors
      print('❌ UNEXPECTED ERROR: $e');
      print('❌ Parse error: $e');
    print('📄 Response data: $json');
      rethrow;
    }
  }
}