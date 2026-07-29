class LoginResponse {
  final bool success;
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'token': token,
        'user': user.toJson(),
      };
}

class User {
  final int id;
  final String accountType;
  final String fullName;
  final String mobileNumber;
  final String email;
  final String location;
  final String latitude;
  final String longitude;

  User({
    required this.id,
    required this.accountType,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      accountType: json['account_type'] as String,
      fullName: json['full_name'] as String,
      mobileNumber: json['mobile_number'] as String,
      email: json['email'] as String,
      location: json['location'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_type': accountType,
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
        'location': location,
        'latitude': latitude,
        'longitude': longitude,
      };
}