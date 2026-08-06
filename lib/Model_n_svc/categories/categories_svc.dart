// services/categories_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class CategoriesApiService {
  final Dio _dio;

  CategoriesApiService(this._dio) {
    // ✅ Add interceptor to automatically attach token to every request
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Get token from SharedPreferences
        final token = await AppPreferences.getToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          print('🔑 Token attached to request');
        } else {
          print('⚠️ No token available');
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        // Optional: handle token expiry globally
        if (error.response?.statusCode == 401) {
          print('❌ Token expired or invalid – redirect to login?');
          // You can emit an event to logout user here
        }
        return handler.next(error);
      },
    ));
  }

  Future<CategoriesResponse> getCategories() async {
    try {
      print('🔷 GET CATEGORIES REQUEST');
      print('📍 URL: ${ApiEndpoints.categories}');

      final response = await _dio.get(ApiEndpoints.categories);

      print('🔶 GET CATEGORIES RESPONSE');
      print('📊 Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('✅ Success: Data received');
        // ✅ If you want to see full response, uncomment:
        // print('📦 Data: ${response.data}');
        return CategoriesResponse.fromJson(response.data);
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