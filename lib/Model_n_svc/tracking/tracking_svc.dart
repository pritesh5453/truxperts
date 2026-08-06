// services/tracking_svc.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/tracking/tracking_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class InstantTrackingService {
  final Dio _dio;

  InstantTrackingService(this._dio) {
    // Add token interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AppPreferences.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  /// Fetch tracking details for a specific instant booking
  Future<InstantTrackingResponse> fetchTracking({
    required int bookingId,
    required int userId,
  }) async {
    try {
      final String url = '${ApiEndpoints.instantBookings}/$bookingId';
      final queryParams = {'user_id': userId.toString()};

      print('🔷 FETCH TRACKING REQUEST');
      print('📍 URL: $url');
      print('📦 Query: $queryParams');

      final response = await _dio.get(
        url,
        queryParameters: queryParams,
      );

      print('🔶 TRACKING RESPONSE');
      print('📊 Status: ${response.statusCode}');
      print('📦 Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['success'] == true) {
          return InstantTrackingResponse.fromJson(data);
        } else {
          throw Exception(data['message'] ?? 'Failed to fetch tracking details');
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      print('❌ DIO EXCEPTION:');
      print('   Message: ${e.message}');
      if (e.response != null) {
        print('   Status: ${e.response?.statusCode}');
        print('   Data: ${e.response?.data}');
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      print('❌ UNEXPECTED ERROR: $e');
      rethrow;
    }
  }
}