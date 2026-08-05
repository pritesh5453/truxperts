// services/advance_categories_service.dart
import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/categories/advance_category_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class AdvanceCategoriesApiService {
  final Dio _dio;

  AdvanceCategoriesApiService(this._dio);

  Future<AdvanceCategoriesResponse> getAdvanceCategories() async {
    try {
      final response = await _dio.get(ApiEndpoints.advanceCategories);

      if (response.statusCode == 200) {
        return AdvanceCategoriesResponse.fromJson(response.data);
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