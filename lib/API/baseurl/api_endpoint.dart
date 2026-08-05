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

  // Instant Bookings
  static const String instantBookings = '${baseUrl}api/instant-bookings';
  static const String instantBookingsStats = '${baseUrl}api/instant-bookings/stats';

  // ========== CUSTOMER ADDRESS ==========
  static const String customerAddressBase = '${baseUrl}api/admin/customer-address';

  // Get all addresses for a customer (GET /customer-address/{customerId})
  static String customerAddresses(int customerId) => '$customerAddressBase/$customerId';

  // Add new address (POST /customer-address)
  static const String addAddress = customerAddressBase;

  // Update address (PUT /customer-address/{addressId})
  static String updateAddress(int addressId) => '$customerAddressBase/$addressId';

  // Delete address (DELETE /customer-address/{addressId})
  static String deleteAddress(int addressId) => '$customerAddressBase/$addressId';
}