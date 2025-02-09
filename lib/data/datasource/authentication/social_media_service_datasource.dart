import 'dart:developer';

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
  final FacebookAuth _facebookAuth;
  final GoogleSignIn _googleSignIn;

  final FirebaseAuth _auth;
  SocialMediaServiceDatasourceImpl(this._facebookAuth, this._googleSignIn, this._auth);
  @override
  Future<SocialMediaUser> loginWithFacebook() async {
    try {
      final LoginResult loginResult = await _facebookAuth.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status != LoginStatus.success) {
        throw CustomException(message: "Facebook sign-in failed");
      }

      final userData = await _facebookAuth.getUserData(
        fields: "name,email,picture.width(200).height(200)",
      );
      SocialMediaUser user = SocialMediaUser.fromFacebookJson(userData);
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
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log("message-------------------------------------------");
        throw CustomException(message: "Unexcpected error");
      }
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;

      // If the user cancels the sign-in, account will be null.
      if (user == null) throw CustomException(message: "Your sign in was canceled");

      // Create and return a GoogleUser with the required data.
      return SocialMediaUser(email: user.email, name: user.displayName ?? 'No Name', image: user.photoURL);
    } catch (error) {
      log(error.toString());
      throw CustomException(message: error.toString());
    }
  }
}
