import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/address/address_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'package:truxperts/utils/sharedPreference/apppreference.dart';

class AddressService {
  final Dio dio;

  AddressService(this.dio);

  // ==================== GET ALL ADDRESSES ====================
  Future<List<Address>> getAddresses(int customerId) async {
    try {
      // ✅ Add token if available
      final token = await AppPreferences.getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final url = ApiEndpoints.customerAddresses(customerId);
      print('🔍 GET Addresses URL: $url');
      print('🔍 Headers: ${dio.options.headers}');

      final response = await dio.get(url);
      _logResponse(response);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => Address.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch addresses');
      }
    } on DioException catch (e) {
      // 🔥 Detailed error log
      print('❌ Dio error: ${e.message}');
      if (e.response != null) {
        print('   Status: ${e.response?.statusCode}');
        print('   Data: ${e.response?.data}');
        print('   Headers: ${e.response?.headers}');
      }
      throw _handleDioError(e);
    }
  }

  // ==================== ADD NEW ADDRESS ====================
  Future<int> addAddress(Map<String, dynamic> addressData) async {
    try {
      // ✅ Add token if available
      final token = await AppPreferences.getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      print('📤 POST Address URL: ${ApiEndpoints.addAddress}');
      print('📤 Body: $addressData');

      final response = await dio.post(
        ApiEndpoints.addAddress,
        data: addressData,
      );
      _logResponse(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is Map && data['success'] == true) {
          if (data.containsKey('address_id')) {
            return data['address_id'] as int;
          } else {
            return 0;
          }
        } else {
          throw Exception(data['message'] ?? 'Failed to add address');
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // ==================== UPDATE ADDRESS ====================
  Future<void> updateAddress(int addressId, Map<String, dynamic> addressData) async {
    try {
      final token = await AppPreferences.getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final url = ApiEndpoints.updateAddress(addressId);
      print('📤 PUT Address URL: $url');
      print('📤 Body: $addressData');

      final response = await dio.put(
        url,
        data: addressData,
      );
      _logResponse(response);

      if (response.statusCode == 200 && response.data['success'] == true) {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update address');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ==================== DELETE ADDRESS ====================
  Future<void> deleteAddress(int addressId) async {
    try {
      final token = await AppPreferences.getToken();
      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      }

      final url = ApiEndpoints.deleteAddress(addressId);
      print('🗑️ DELETE Address URL: $url');

      final response = await dio.delete(url);
      _logResponse(response);

      if (response.statusCode == 200 && response.data['success'] == true) {
        return;
      } else {
        throw Exception(response.data['message'] ?? 'Failed to delete address');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ==================== HELPERS ====================
  void _logResponse(Response response) {
    print('📡 Address API Response:');
    print('  Status: ${response.statusCode}');
    print('  Data: ${response.data}');
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'] as String;
      }
      return 'Server error: ${e.response?.statusCode}';
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timeout. Please check your internet.';
    } else {
      return 'Unexpected error: ${e.message}';
    }
  }
}