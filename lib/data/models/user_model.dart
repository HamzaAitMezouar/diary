import 'dart:convert';

enum Provider { google, facebook, github, email }

class UserModel {
  final String id;
  final String? email;
  final String? phone;
  final String? password;
  final String? name;
  final String? otp;
  final DateTime? otpExpiration;
  final Provider? provider;
  final String? image;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;

  UserModel({
    required this.id,
    this.email,
    this.phone,
    this.password,
    this.name,
    this.otp,
    this.otpExpiration,
    this.provider,
    this.image,
    this.isActive = true,
    this.isVerified = false,
    required this.createdAt,
  });

  /// Factory constructor to create a `User` from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      name: json["name"],
      otp: json["otp"],
      otpExpiration: json["otpExpiration"] != null ? DateTime.parse(json["otpExpiration"]) : null,
      provider: json["provider"] != null ? Provider.values.firstWhere((e) => e.name == json["provider"]) : null,
      image: json["image"],
      isActive: json["isActive"] ?? true,
      isVerified: json["isVerified"] ?? false,
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  /// Convert a `User` object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "password": password,
      "name": name,
      "otp": otp,
      "otpExpiration": otpExpiration?.toIso8601String(),
      "provider": provider?.name,
      "image": image,
      "isActive": isActive,
      "isVerified": isVerified,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  /// Convert to JSON string
  String toJsonString() => json.encode(toJson());

  /// Factory method to create a `User` from a JSON string
  factory UserModel.fromJsonString(String jsonString) => UserModel.fromJson(json.decode(jsonString));
}
