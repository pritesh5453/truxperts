// API/Model_n_svc/Profile/edit_profile_svc.dart
import 'package:dio/dio.dart';
import 'package:truxperts/API/Model_n_svc/Profile/profile_model.dart';
import 'package:truxperts/API/Model_n_svc/Profile/profile_svc.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class EditProfileService {
  final Dio _dio;

  EditProfileService({Dio? dio}) : _dio = dio ?? Dio();

  /// Update user profile.
  Future<ApiResponse<UserProfile>> updateProfile({
    required int userId,
    required String fullName,
    required String mobileNumber,
    required String email,
    required String location,
    required String city,
    required String state,
  }) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateProfile,
        data: {
          'user_id': userId,
          'full_name': fullName,
          'mobile_number': mobileNumber,
          'email': email,
          'location': location,
          'city': city,
          'state': state,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ApiResponse<UserProfile>.fromJson(
          response.data,
          (json) => UserProfile.fromJson(json),
        );
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      throw e;
    }
  }
}