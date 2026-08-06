// services/post_screen/post_svc.dart
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truxperts/Model_n_svc/post_screen/post_model.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';
import 'dart:io';

class InstantBookingApiService {
  final Dio _dio;

  InstantBookingApiService(this._dio);

  Future<InstantBookingResponse> createInstantBooking(
    InstantBookingRequest request,
    List<XFile> images,
  ) async {
    try {
      final formData = FormData();

      // ✅ Print request payload for debugging
      final Map<String, dynamic> payload = request.toJson();
      print('📤 Instant Booking Request Payload:');
      payload.forEach((key, value) {
        print('   $key: $value');
      });

      // Add all text fields
      payload.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      // Add images as files
      for (int i = 0; i < images.length; i++) {
        final file = File(images[i].path);
        final multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: 'image_$i.jpg',
        );
        formData.files.add(MapEntry('images', multipartFile));
      }

      // ✅ Print request URL
      final String url = ApiEndpoints.instantPost;
      print('🌐 POST URL: $url');

      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // ✅ Print response details
      print('📡 Response Status: ${response.statusCode}');
      print('📡 Response Data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          return InstantBookingResponse.fromJson(response.data);
        } catch (e) {
          print('❌ Failed to parse response: $e');
          throw Exception('Failed to parse response: $e');
        }
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Status Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      // ✅ Full error logging
      print('❌ DioError: ${e.message}');
      if (e.response != null) {
        print('   Status: ${e.response?.statusCode}');
        print('   Headers: ${e.response?.headers}');
        print('   Data: ${e.response?.data}');
        if (e.response?.data is Map) {
          print('   Message: ${(e.response?.data as Map)['message']}');
        }
      } else if (e.error != null) {
        print('   Error: ${e.error}');
      }
      print('   StackTrace: ${e.stackTrace}');
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      print('❌ Unexpected error: $e');
      rethrow;
    }
  }
}