// services/advance_subcategories_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/categories/categories_model.dart';
import 'package:truxperts/Model_n_svc/categories/subcategory/subcategories_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class AdvanceSubcategoriesApiService {
  final Dio _dio;

  AdvanceSubcategoriesApiService(this._dio);

  Future<SubcategoriesResponse> getAdvanceSubcategories(int categoryId) async {
    try {
      final response = await _dio.get(ApiEndpoints.advanceSubcategories(categoryId));

      if (response.statusCode == 200) {
        return SubcategoriesResponse.fromJson(response.data);
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