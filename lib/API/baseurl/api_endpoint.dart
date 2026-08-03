// API/baseurl/api_endpoint.dart
class ApiEndpoints {
  static const String baseUrl = 'https://api.aakarcanvassing.com/';

  // Auth
  static const String login = '${baseUrl}api/auth/login';
  static const String signup = '${baseUrl}api/auth/signup';

  // Profile
  static const String getProfile = '${baseUrl}api/auth/profile/get';
  static const String updateProfile = '${baseUrl}api/auth/profile/update';

  // Categories
  static const String categories = '${baseUrl}api/categories';
  static const String advanceCategories = '${baseUrl}api/advance_category';

  // Subcategories
  static String subcategories(int categoryId) =>
      '${baseUrl}api/categories/$categoryId/subcategories';
  static String advanceSubcategories(int categoryId) =>
      '${baseUrl}api/advance_category/$categoryId/subcategories';

  // ✅ Instant Bookings (New)
  static const String instantBookings = '${baseUrl}api/instant-bookings/instant_Post';

}