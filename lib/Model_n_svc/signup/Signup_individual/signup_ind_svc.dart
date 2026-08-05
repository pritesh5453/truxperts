import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/signup/Signup_individual/signup_Ind_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class SignupService {
  final Dio _dio;

  SignupService(this._dio);

  /// Signup API call with full logging
  Future<SignupResponse> signup({
    required String accountType,
    required String fullName,
    required String mobileNumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      print('🔷 SIGNUP REQUEST');
      print('📍 URL: ${ApiEndpoints.signup}');
      print('📦 Data: { "account_type": "$accountType", "full_name": "$fullName", "mobile_number": "$mobileNumber", "email": "$email", "password": "********", "confirm_password": "********" }');

      final response = await _dio.post(
        ApiEndpoints.signup,
        data: {
          'account_type': accountType,
          'full_name': fullName,
          'mobile_number': mobileNumber,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print('🔶 SIGNUP RESPONSE');
      print('📊 Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Success Response Data:');
        print(response.data);
        
        final signupResponse = SignupResponse.fromJson(response.data);
        print('🔑 Token: ${signupResponse.token}');
        print('👤 User: ${signupResponse.user.fullName} (${signupResponse.user.mobileNumber})');
        
        return signupResponse;
      } else {
        print('❌ Error Response: ${response.data}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Signup failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ DIO EXCEPTION:');
      print('   Message: ${e.message}');
      print('   Status Code: ${e.response?.statusCode}');
      print('   Response Data: ${e.response?.data}');
      throw e;
    } catch (e) {
      print('❌ UNEXPECTED ERROR: $e');
      rethrow;
    }
  }
}