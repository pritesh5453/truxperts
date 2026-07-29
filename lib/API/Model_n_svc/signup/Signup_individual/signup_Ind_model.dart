class SignupResponse {
  final bool success;
  final String message;
  final String token;
  final SignupUser user;

  SignupResponse({
    required this.success,
    required this.message,
    required this.token,
    required this.user,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String,
      user: SignupUser.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'token': token,
        'user': user.toJson(),
      };
}

class SignupUser {
  final int id;
  final String accountType;
  final String fullName;
  final String mobileNumber;
  final String email;

  SignupUser({
    required this.id,
    required this.accountType,
    required this.fullName,
    required this.mobileNumber,
    required this.email,
  });

  factory SignupUser.fromJson(Map<String, dynamic> json) {
    return SignupUser(
      id: json['id'] as int,
      accountType: json['account_type'] as String,
      fullName: json['full_name'] as String,
      mobileNumber: json['mobile_number'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'account_type': accountType,
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
      };
}