import 'package:dio/dio.dart';
import 'package:truxperts/API/baseurl/api_endpoint.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ),
);