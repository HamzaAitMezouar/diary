import 'dart:developer';

import 'package:diary/data/datasource/authentication/social_media_services.dart';
import 'package:diary/data/models/facebook_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/exceptions.dart';

abstract class SocialMediaServiceDatasource {
  Future<SocialMediaUser> loginWithFacebook();
  Future<SocialMediaUser> loginWithGoogle();
}

class SocialMediaServiceDatasourceImpl extends SocialMediaServiceDatasource {
  final FacebookAuthService _facebookAuthService;
  final GoogleSignInService _googleSignInService;
  final FirebaseAuthService _firebaseAuthService;

  SocialMediaServiceDatasourceImpl(
    this._facebookAuthService,
    this._googleSignInService,
    this._firebaseAuthService,
  );

  @override
  Future<SocialMediaUser> loginWithFacebook() async {
    try {
      final loginResult = await _facebookAuthService.login(['email', 'public_profile']);

      if (loginResult.status != LoginStatus.success) {
        throw CustomException(message: "Facebook sign-in failed");
      }

      final userData = await _facebookAuthService.getUserData(
        "name,email,picture.width(200).height(200)",
      );

      final user = SocialMediaUser.fromFacebookJson(userData);
      if (user.email == null) throw CustomException(message: "Email is required");

      return user;
    } catch (e) {
      log(e.toString());
      throw UnexpectedException(message: 'An error occurred: ${e.toString()}');
    }
  }

  @override
  Future<SocialMediaUser> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignInService.signIn();
      if (googleUser == null) {
        throw CustomException(message: "Unexpected error");
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuthService.signInWithCredential(credential);
      final user = userCredential.user;

      if (user == null) throw CustomException(message: "Sign-in was canceled");

      return SocialMediaUser(
        email: user.email,
        name: user.displayName ?? 'No Name',
        image: user.photoURL,
      );
    } catch (error) {
      log(error.toString());
      throw CustomException(message: error.toString());
    }
  }
}
