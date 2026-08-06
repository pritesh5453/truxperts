// services/advance_categories_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/categories/advance_category_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class AdvanceCategoriesApiService {
  final Dio _dio;

  AdvanceCategoriesApiService(this._dio) {
    // ✅ Add interceptor to attach token automatically
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await AppPreferences.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          print('🔑 Token attached to advance categories request');
        } else {
          print('⚠️ No token available for advance categories');
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          print('❌ Token expired – redirect to login?');
        }
        return handler.next(error);
      },
    ));
  }

  Future<AdvanceCategoriesResponse> getAdvanceCategories() async {
    try {
      print('🔷 GET ADVANCE CATEGORIES REQUEST');
      print('📍 URL: ${ApiEndpoints.advanceCategories}');

      final response = await _dio.get(ApiEndpoints.advanceCategories);

      print('🔶 GET ADVANCE CATEGORIES RESPONSE');
      print('📊 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ Success: Advance categories data received');
        return AdvanceCategoriesResponse.fromJson(response.data);
      } else {
        print('❌ Error Response: ${response.data}');
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