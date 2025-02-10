import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FacebookAuthService {
  Future<LoginResult> login(List<String> permissions);
  Future<Map<String, dynamic>> getUserData(String fields);
}

abstract class GoogleSignInService {
  Future<GoogleSignInAccount?> signIn();
}

abstract class FirebaseAuthService {
  Future<UserCredential> signInWithCredential(AuthCredential credential);
}

class FacebookAuthServiceImpl implements FacebookAuthService {
  final FacebookAuth _facebookAuth;

  FacebookAuthServiceImpl(this._facebookAuth);

  @override
  Future<LoginResult> login(List<String> permissions) {
    return _facebookAuth.login(permissions: permissions);
  }

  @override
  Future<Map<String, dynamic>> getUserData(String fields) {
    return _facebookAuth.getUserData(fields: fields);
  }
}

class GoogleSignInServiceImpl implements GoogleSignInService {
  final GoogleSignIn _googleSignIn;

  GoogleSignInServiceImpl(this._googleSignIn);

  @override
  Future<GoogleSignInAccount?> signIn() {
    return _googleSignIn.signIn();
  }
}

class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _auth;

  FirebaseAuthServiceImpl(this._auth);

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) {
    return _auth.signInWithCredential(credential);
  }
}
