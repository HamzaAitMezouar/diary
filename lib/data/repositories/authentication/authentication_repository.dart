import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/data/datasource/authentication/authentication_datasource.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/params/social_media_params.dart';
import '../../../core/responses/datasource_responses.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool>> requestOtpCode(String phoneNumber);
  Future<Either<Failure, AuthResponse>> verifyOtpCode(String phoneNumber, String code);
  Future<Either<Failure, bool>> resendOtp(String phoneNumber);
  Future<Either<Failure, AuthResponse>> socialMediaLogin(SocialMediaParams params);
  Future logout();
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDatasource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});
  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> requestOtpCode(String phoneNumber) async {
    try {
      final result = await remoteDataSource.requestOtpCode(phoneNumber);
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> resendOtp(String phoneNumber) async {
    try {
      final result = await remoteDataSource.resendOtp(phoneNumber);
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> socialMediaLogin(SocialMediaParams params) async {
    try {
      final result = await remoteDataSource.socialMediaLogin(params);
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyOtpCode(String phoneNumber, String code) async {
    try {
      final result = await remoteDataSource.verifyOtpCode(phoneNumber, code);
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
