import '../../data/models/user_model.dart';

class UserEntity {
  final String id;
  final String? email;
  final String? phone;
  final String? name;
  final SocialMediaProvider? provider;
  final String? image;
  final bool isActive;
  final bool isVerified;
  final DateTime createdAt;

  UserEntity({
    required this.id,
    this.email,
    this.phone,
    this.name,
    this.provider,
    this.image,
    this.isActive = true,
    this.isVerified = false,
    required this.createdAt,
  });

  UserModel toModel() {
    return UserModel(
      id: id,
      email: email,
      phone: phone,
      name: name,
      provider: provider,
      image: image,
      isActive: isActive,
      isVerified: isVerified,
      createdAt: createdAt,
    );
  }
}
