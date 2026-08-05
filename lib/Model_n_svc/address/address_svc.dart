import 'package:dio/dio.dart';
import 'package:truxperts/Model_n_svc/address/address_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

class AddressService {
  final Dio dio;

  AddressService(this.dio);

  // ==================== GET ALL ADDRESSES ====================
  Future<List<Address>> getAddresses(int customerId) async {
    try {
      final response = await dio.get(
        ApiEndpoints.customerAddresses(customerId),
      );
      _logResponse(response);
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List data = response.data['data'] ?? [];
        return data.map((json) => Address.fromJson(json)).toList();
      } else {
        throw Exception(response.data['message'] ?? 'Failed to fetch addresses');
      }
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  // ==================== ADD NEW ADDRESS ====================
  Future<int> addAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await dio.post(
        ApiEndpoints.addAddress,
        data: addressData,
      );
      _logResponse(response);
      
      // ✅ Check if response is valid
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data is Map && data['success'] == true) {
          // ✅ Return address_id if present
          if (data.containsKey('address_id')) {
            return data['address_id'] as int;
          } else {
            // If no address_id but success is true, return 0 (or throw)
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
      final response = await dio.put(
        ApiEndpoints.updateAddress(addressId),
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
      final response = await dio.delete(
        ApiEndpoints.deleteAddress(addressId),
      );
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