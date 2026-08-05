import 'package:dio/dio.dart';
import 'my_request_model.dart';
import '../../API/baseurl/api_endpoint.dart';

class InstantBookingService {
  final Dio dio;

  InstantBookingService(this.dio);

  // ========== GET BOOKINGS ==========
  Future<InstantBookingResponse> getInstantBookings({
    required int userId,
    String? status,
  }) async {
    try {
      final query = <String, dynamic>{'user_id': userId};
      if (status != null && status.isNotEmpty) query['status'] = status;

      final response = await dio.get(
        ApiEndpoints.instantBookings,
        queryParameters: query,
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return InstantBookingResponse.fromJson(response.data);
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // ========== GET STATS ==========
  Future<StatsResponse> getInstantStats({required int userId}) async {
    try {
      final response = await dio.get(
        ApiEndpoints.instantBookingsStats,
        queryParameters: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        return StatsResponse.fromJson(response.data);
      } else {
        throw Exception('Stats API Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}