// models/user_profile.dart

class UserProfile {
  final int id;
  final String accountType;
  final String mobileNumber;
  final String email;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String fullName;
  final String location;
  final String? city;    // nullable
  final String? state;   // nullable
  final String latitude;
  final String longitude;

  UserProfile({
    required this.id,
    required this.accountType,
    required this.mobileNumber,
    required this.email,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.fullName,
    required this.location,
    this.city,
    this.state,
    required this.latitude,
    required this.longitude,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    // Extract city/state from location if not directly provided
    String? city = json['city'] as String?;
    String? state = json['state'] as String?;
    final location = json['location'] as String? ?? '';

    if (city == null && state == null && location.isNotEmpty) {
      final parts = location.split(',').map((s) => s.trim()).toList();
      if (parts.length == 2) {
        city = parts[0];
        state = parts[1];
      } else {
        city = location; // fallback
        state = '';
      }
    }

    return UserProfile(
      id: json['id'] as int,
      accountType: json['account_type'] as String? ?? 'individual',
      mobileNumber: json['mobile_number'] as String? ?? '',
      email: json['email'] as String? ?? '',
      status: json['status'] as String? ?? 'active',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      fullName: json['full_name'] as String? ?? '',
      location: location,
      city: city ?? '',
      state: state ?? '',
      latitude: json['latitude'] as String? ?? '0.0',
      longitude: json['longitude'] as String? ?? '0.0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_type': accountType,
      'mobile_number': mobileNumber,
      'email': email,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'full_name': fullName,
      'location': location,
      'city': city,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}