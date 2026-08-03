// services/post_screen/post_svc.dart
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:truxperts/API/Model_n_svc/post_screen/post_model.dart';
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

      // Add all text fields – convert everything to string safely
      request.toJson().forEach((key, value) {
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

      final response = await _dio.post(
        ApiEndpoints.instantBookings,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Safe parsing with try-catch
        try {
          return InstantBookingResponse.fromJson(response.data);
        } catch (e) {
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
      // Print detailed error
      print('DioError: ${e.message}');
      if (e.response != null) {
        print('Response data: ${e.response?.data}');
        print('Response status: ${e.response?.statusCode}');
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }
}