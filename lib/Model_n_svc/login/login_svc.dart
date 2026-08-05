import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/login/login_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

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
}