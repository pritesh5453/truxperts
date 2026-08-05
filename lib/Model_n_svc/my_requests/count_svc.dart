// // Service class me yeh method add karo
// import 'package:dio/dio.dart';
// import 'package:truxperts/API/Model_n_svc/my_requests/my_request_svc.dart';
// import 'package:truxperts/API/baseurl/api_endpoint.dart';
// import 'package:truxperts/API/baseurl/dio_client.dart';

// Future<StatsResponse> getInstantStats({required int userId}) async {
//   try {
//     final response = await dio.get(
//       '${ApiEndpoints.baseUrl}api/instant-bookings/stats',
//       queryParameters: {'user_id': userId},
//     );

//     if (response.statusCode == 200) {
//       return StatsResponse.fromJson(response.data);
//     } else {
//       throw Exception('Stats API Error: ${response.statusCode}');
//     }
//   } on DioException catch (e) {
//     throw Exception('Dio error: ${e.message}');
//   } catch (e) {
//     throw Exception('Unexpected error: $e');
//   }
// }