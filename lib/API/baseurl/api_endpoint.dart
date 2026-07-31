// API/baseurl/api_endpoint.dart
class ApiEndpoints {
  static const String baseUrl = 'https://api.aakarcanvassing.com/';

  // Auth
  static const String login = '${baseUrl}api/auth/login';
  static const String signup = '${baseUrl}api/auth/signup';

  // Profile
  static const String getProfile = '${baseUrl}api/auth/profile/get';
  static const String updateProfile = '${baseUrl}api/auth/profile/update';
}