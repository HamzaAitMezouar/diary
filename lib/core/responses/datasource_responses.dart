import 'dart:convert';

import 'package:diary/data/models/user_model.dart';

class AuthResponse {
  final UserModel user;
  final String accessToken;
  final String refreshToken;
  AuthResponse({required this.accessToken, required this.refreshToken, required this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json["user"]),
      accessToken: json["accesstoken"], // Ensure correct key name from API
      refreshToken: json["refreshToken"],
    );
  }

  /// Convert to JSON (if needed for sending data)
  Map<String, dynamic> toJson() {
    return {
      "user": user.toJson(),
      "accesstoken": accessToken,
      "refreshToken": refreshToken,
    };
  }

  /// Convert JSON string to `SocialMediaAuthResponse`
  factory AuthResponse.fromJsonString(String jsonString) => AuthResponse.fromJson(json.decode(jsonString));
}
