import 'package:diary/core/DI/dio_provider.dart';
import 'package:diary/core/DI/exception_handler_provider.dart';
import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/datasource/authentication/authentication_datasource.dart';
import 'package:diary/data/datasource/authentication/social_media__datasource.dart';
import 'package:diary/data/datasource/authentication/social_media_services.dart';
import 'package:diary/domain/repositories/authentication/social_media_repository.dart';
import 'package:diary/domain/usecases/authentication/facebook_login.dart';
import 'package:diary/domain/usecases/authentication/google_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/repositories/authentication/authentication_repository.dart';
import '../../../domain/usecases/authentication/logout_case.dart';
import '../../../domain/usecases/authentication/request_otp_case.dart';
import '../../../domain/usecases/authentication/resend_otp_case.dart';
import '../../../domain/usecases/authentication/social_media_login_case.dart';
import '../../../domain/usecases/authentication/verify_otp_case.dart';

final authDatasourceProvider = Provider<AuthenticationDatasource>(
  (ref) => AuthenticationDatasourceImpl(ref.watch(publicDioProvider), ref.watch(exceptionsHandlerProvider)),
);
final authRepositoryProvider = Provider<AuthenticationRepository>(
  (ref) => AuthenticationRepositoryImpl(
    remoteDataSource: ref.watch(authDatasourceProvider),
    storageHelper: ref.watch(secureStorageHelperProvider),
  ),
);

final requestOtpUseCaseProvider = Provider<RequestOtpUseCase>(
  (ref) => RequestOtpUseCase(ref.watch(authRepositoryProvider)),
);

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.watch(authRepositoryProvider)),
);

final resendOtpUseCaseProvider = Provider<ResendOtpUseCase>(
  (ref) => ResendOtpUseCase(ref.watch(authRepositoryProvider)),
);

final socialMediaLoginUseCaseProvider = Provider<SocialMediaLoginUseCase>(
  (ref) => SocialMediaLoginUseCase(ref.watch(authRepositoryProvider)),
);

final logoutUseCaseProvider = Provider<LogOutUseCase>(
  (ref) => LogOutUseCase(ref.watch(authRepositoryProvider)),
);

// social media services
final facebookAuthProvider = Provider<FacebookAuth>(
  (ref) => FacebookAuth.i,
);
final googleSignInProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(
    scopes: ['email', "displayName", "photoUrl"],
  ),
);
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final googlesigninServiceProvider = Provider<GoogleSignInService>((ref) {
  final googleSignin = ref.watch(googleSignInProvider);
  return GoogleSignInServiceImpl(googleSignin);
});
final facebookigninServiceProvider = Provider<FacebookAuthService>((ref) {
  final facebookservice = ref.watch(facebookAuthProvider);
  return FacebookAuthServiceImpl(facebookservice);
});
final firebaseloginServiceProvider = Provider<FirebaseAuthService>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return FirebaseAuthServiceImpl(firebaseAuth);
});
final socialMediaDatasourceProvider = Provider<SocialMediaServiceDatasource>((ref) {
  final facebookAuth = ref.watch(facebookigninServiceProvider);
  final googlesigninService = ref.watch(googlesigninServiceProvider);

  final firebaseAuth = ref.watch(firebaseloginServiceProvider);

  return SocialMediaServiceDatasourceImpl(facebookAuth, googlesigninService, firebaseAuth);
});

final socialMediaServiceRepositoryProvider = Provider<SocialMediaServiceRepository>((ref) {
  return SocialMediaServiceRepositoryImpl(ref.watch(socialMediaDatasourceProvider));
});

final loginWithGoogleUseCaseProvider = Provider<LoginWithGoogleUsecase>((ref) {
  return LoginWithGoogleUsecase(ref.watch(socialMediaServiceRepositoryProvider));
});

final loginWithFacebookUseCaseProvider = Provider<LoginWithFacebookUseCase>((ref) {
  return LoginWithFacebookUseCase(ref.watch(socialMediaServiceRepositoryProvider));
});
