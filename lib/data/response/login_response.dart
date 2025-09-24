import 'package:garage/data/models/profile.dart';
import 'package:garage/data/models/user.dart';

class LoginResponse {
  LoginResponse({
    this.accessToken,
    this.user,
    this.profile,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    accessToken: json['accessToken'] as String?,
    user: json['user'] == null
        ? null
        : User.fromMap(json['user'] as Map<String, dynamic>),
    profile: json['profile'] == null
        ? null
        : Profile.fromMap(json['profile'] as Map<String, dynamic>),
  );

  final String? accessToken;
  final User? user;
  final Profile? profile;
}
