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
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      token: json['token'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
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
  final String? fullName;
  final String? mobileNumber;
  final String? email;
  final String? location;
  final String? city;
  final String? state;
  final String? latitude;
  final String? longitude;
  final String? businessName;
  final String? ownerName;
  final String? serviceType;
  final String? verificationStatus;

  User({
    required this.id,
    required this.accountType,
    this.fullName,
    this.mobileNumber,
    this.email,
    this.location,
    this.city,
    this.state,
    this.latitude,
    this.longitude,
    this.businessName,
    this.ownerName,
    this.serviceType,
    this.verificationStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      accountType: json['account_type'] as String? ?? 'individual',
      fullName: json['full_name'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      email: json['email'] as String?,
      location: json['location'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      businessName: json['business_name'] as String?,
      ownerName: json['owner_name'] as String?,
      serviceType: json['service_type'] as String?,
      verificationStatus: json['verification_status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_type': accountType,
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
        'location': location,
        'city': city,
        'state': state,
        'latitude': latitude,
        'longitude': longitude,
        'business_name': businessName,
        'owner_name': ownerName,
        'service_type': serviceType,
        'verification_status': verificationStatus,
      };
}