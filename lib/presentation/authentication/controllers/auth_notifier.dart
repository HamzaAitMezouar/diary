import 'package:dartz/dartz.dart';
import 'package:diary/core/DI/storage_provider.dart';
import 'package:diary/data/models/facebook_user.dart';
import 'package:diary/data/models/user_model.dart';
import 'package:diary/domain/entities/user_entity.dart';
import 'package:diary/domain/usecases/authentication/facebook_login.dart';
import 'package:diary/domain/usecases/authentication/google_login.dart';
import 'package:diary/domain/usecases/authentication/resend_otp_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/errors.dart';
import '../../../core/params/social_media_params.dart';
import '../../../domain/usecases/authentication/request_otp_case.dart';
import '../../../domain/usecases/authentication/verify_otp_case.dart';
import '../../../domain/usecases/authentication/social_media_login_case.dart';
import '../../../domain/usecases/authentication/logout_case.dart';
import 'auth_providers.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RequestOtpUseCase requestOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final SocialMediaLoginUseCase socialMediaLoginUseCase;
  final LogOutUseCase logOutUseCase;
  final LoginWithFacebookUseCase loginWithFacebookUseCase;
  final LoginWithGoogleUsecase loginWithGoogleUsecase;
  final Ref ref;
  AuthNotifier({
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.socialMediaLoginUseCase,
    required this.logOutUseCase,
    required this.loginWithFacebookUseCase,
    required this.loginWithGoogleUsecase,
    required this.resendOtpUseCase,
    required this.ref,
  }) : super(AuthInitial()) {
    // Set an initial loading state
    _initialize(); // Call the async method
  }
  _initialize() async {
    String? userString = await ref.read(secureStorageHelperProvider).getUserString();
    if (userString == null) {
      state = Unauthenticated();
      return;
    }
    state = Authenticated(UserModel.fromJsonString(userString).toEntity());
  }

  Future<void> requestOtp(String phoneNumber) async {
    state = PhoneAuthLoading();
    Either<Failure, bool> result = await requestOtpUseCase(phoneNumber);
    state = result.fold(
      (failure) => AuthError(failure.errorMessage),
      (success) => success ? SendOtpSuccess() : AuthError("Something went wrong"),
    );
  }

  Future<void> resendOtp(String phoneNumber) async {
    state = PhoneAuthLoading();
    Either<Failure, bool> result = await resendOtpUseCase(phoneNumber);
    state = result.fold(
      (failure) => AuthError(failure.errorMessage),
      (success) => success ? SendOtpSuccess() : AuthError("Something went wrong"),
    );
  }

  Future<void> verifyOtp(String phoneNumber, String code) async {
    state = PhoneAuthLoading();
    Either<Failure, UserEntity> result = await verifyOtpUseCase(phoneNumber, code);
    state = result.fold(
      (failure) => AuthError(failure.errorMessage),
      (user) => Authenticated(user),
    );
  }

  Future<Either<Failure, SocialMediaUser>> _loginWithProvider(SocialMediaProvider provider) async {
    switch (provider) {
      case SocialMediaProvider.facebook:
        return await loginWithFacebookUseCase();
      case SocialMediaProvider.google:
        return await loginWithGoogleUsecase();

      default:
        return Left(UnexpectedFailure(errorMessage: "Unsupported provider"));
    }
  }

  Future<void> socialMediaLogin(SocialMediaProvider provider) async {
    state = SocialMediaLoading(provider: provider);
    SocialMediaUser? socialMediaUser;

    Either<Failure, SocialMediaUser> facebookresult = await _loginWithProvider(provider);
    facebookresult.fold((l) => state = AuthError(l.errorMessage), (r) => socialMediaUser = r);
    if (socialMediaUser == null) return;
    SocialMediaParams params = SocialMediaParams(
        email: socialMediaUser!.email!,
        name: socialMediaUser?.name ?? "",
        provider: provider,
        image: socialMediaUser?.image);
    Either<Failure, UserEntity> result = await socialMediaLoginUseCase(params);
    state = result.fold(
      (failure) => AuthError(failure.errorMessage),
      (user) => Authenticated(user),
    );
  }

  Future<void> logout() async {
    state = LogoutLoadingLoading();
    //Either<Failure, bool> result = await logOutUseCase();
    await ref.read(secureStorageHelperProvider).clearTokens();
    state = Unauthenticated();

    /// = result.fold((failure) => AuthError(failure.errorMessage), (_) {
    //  return
    //});
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    requestOtpUseCase: ref.watch(requestOtpUseCaseProvider),
    verifyOtpUseCase: ref.watch(verifyOtpUseCaseProvider),
    socialMediaLoginUseCase: ref.watch(socialMediaLoginUseCaseProvider),
    logOutUseCase: ref.watch(logoutUseCaseProvider),
    resendOtpUseCase: ref.watch(resendOtpUseCaseProvider),
    loginWithFacebookUseCase: ref.watch(loginWithFacebookUseCaseProvider),
    loginWithGoogleUsecase: ref.watch(loginWithGoogleUseCaseProvider),
    ref: ref,
  );
});
