class SocialMediaUser {
  final String? name;
  final String? email;
  final String? image;

  SocialMediaUser({
    this.name,
    this.email,
    this.image,
  });

  factory SocialMediaUser.fromFacebookJson(Map<String, dynamic> json) {
    return SocialMediaUser(
      name: json["name"],
      email: json["email"],
      image: json["picture"]?["data"]?["url"],
    );
  }
}
