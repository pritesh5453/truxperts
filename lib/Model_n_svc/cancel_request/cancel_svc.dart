// services/cancel_booking_svc.dart
import 'package:dio/dio.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/Model_n_svc/cancel_request/cancel_request_model.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class CancelBookingService {
  final Dio _dio;

  CancelBookingService(this._dio) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AppPreferences.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print('🔑 Token attached: ${token != null}');
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
          print('❌ Unauthorized - token might be expired');
        }
        return handler.next(error);
      },
    ));
  }

  /// Cancel an instant booking using PATCH method
  Future<void> cancelBooking({
    required int bookingId,
    required CancelBookingRequest request,
  }) async {
    try {
      final String url = ApiEndpoints.cancelInstantBooking(bookingId);
      
      print('🔷 CANCEL BOOKING REQUEST');
      print('📍 URL: $url');
      print('📦 Method: PATCH');
      print('📦 Body: ${request.toJson()}');

      // 🔥 Use PATCH method
      final response = await _dio.patch(
        url,
        data: request.toJson(),
      );

      print('🔶 CANCEL BOOKING RESPONSE');
      print('📊 Status: ${response.statusCode}');
      print('📦 Data: ${response.data}');

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['success'] == true) {
          print('✅ Booking cancelled successfully');
          return;
        } else {
          throw Exception(data['message'] ?? 'Failed to cancel booking');
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
        if (e.response?.data is Map) {
          final errorData = e.response?.data as Map;
          print('   Server Message: ${errorData['message'] ?? errorData['error']}');
        }
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      print('❌ UNEXPECTED ERROR: $e');
      rethrow;
    }
  }
}