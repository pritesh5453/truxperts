// services/categories_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class CategoriesApiService {
  final Dio _dio;

  // Constructor sirf Dio lega (endpoint hum bahar se bhejenge)
  CategoriesApiService(this._dio);

  Future<CategoriesResponse> getCategories() async {
    try {
      // 🔥 ApiEndpoints.categories ko yahan use karo
      final response = await _dio.get(ApiEndpoints.categories);

      if (response.statusCode == 200) {
        return CategoriesResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      rethrow;
    }
  }
}
