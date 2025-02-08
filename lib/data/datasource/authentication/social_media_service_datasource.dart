import 'package:diary/data/models/facebook_user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../../../core/errors/exceptions.dart';

abstract class SocialMediaServiceDatasource {
  Future<SocialMediaUser> loginWithFacebook();
}

class SocialMediaServiceDatasourceImpl extends SocialMediaServiceDatasource {
  final FacebookAuth _facebookAuth;
  SocialMediaServiceDatasourceImpl(this._facebookAuth);
  @override
  Future<SocialMediaUser> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status != LoginStatus.success) {
        throw CustomException(message: "Facebook sign-in failed");
      }
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200).height(200)",
      );
      SocialMediaUser user = SocialMediaUser.fromFacebookJson(userData);
      if (user.email == null) throw CustomException(message: "Email is required");
      return user;
    } catch (e) {
      throw UnexpectedException(message: 'An error occurred: ${e.toString()}');
    }
  }
}
