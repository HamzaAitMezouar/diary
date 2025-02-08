import 'dart:convert';

import 'package:diary/data/models/user_model.dart';

class SocialMediaParams {
  SocialMediaParams({required this.email, required this.name, this.image, required this.provider});
  final String email;
  final String name;
  final String? image;
  final SocialMediaProvider provider;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "provider": provider.name,
      if (image != null) "image": image, // Only include image if it's not null
    };
  }

  /// Convert the object to a JSON string
  String toJsonString() => json.encode(toJson());
}
