// services/profile_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/API/Model_n_svc/Profile/profile_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class ProfileService {
  final Dio _dio;

  ProfileService({Dio? dio}) : _dio = dio ?? Dio();

  /// Fetch user profile by ID.
  Future<ApiResponse<UserProfile>> getProfile({required int userId}) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.getProfile,
        data: {'user_id': userId},
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
      // You can rethrow or handle error as needed
      throw e;
    }
  }
}


// models/api_response.dart

class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return ApiResponse<T>(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}