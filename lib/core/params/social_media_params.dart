import 'dart:convert';

class SocialMediaParams {
  SocialMediaParams({required this.email, required this.name, this.image, required this.provider});
  final String email;
  final String name;
  final String? image;
  final String provider;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "provider": provider,
      if (image != null) "image": image, // Only include image if it's not null
    };
  }

  /// Convert the object to a JSON string
  String toJsonString() => json.encode(toJson());
}
