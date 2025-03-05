import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:diary/core/errors/errors.dart';
import 'package:diary/core/helpers/secure_storage_helper.dart';
import 'package:diary/data/datasource/authentication/authentication_datasource.dart';
import 'package:diary/domain/entities/user_entity.dart';

import '../../../core/errors/exceptions.dart';
import '../../../core/params/social_media_params.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, bool>> requestOtpCode(String phoneNumber);
  Future<Either<Failure, UserEntity>> verifyOtpCode(String phoneNumber, String code);
  Future<Either<Failure, bool>> resendOtp(String phoneNumber);
  Future<Either<Failure, UserEntity>> socialMediaLogin(SocialMediaParams params);
  Future logout();
  Future addToken(String token);
}

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDatasource remoteDataSource;
  final SecureStorageHelper storageHelper;
  AuthenticationRepositoryImpl({
    required this.remoteDataSource,
    required this.storageHelper,
  });
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
  Future<Either<Failure, UserEntity>> socialMediaLogin(SocialMediaParams params) async {
    try {
      final result = await remoteDataSource.socialMediaLogin(params);
      storageHelper.saveAccessToken(result.accessToken);
      storageHelper.saveRefreshToken(result.refreshToken);
      storageHelper.saveUser(result.user.toJsonString());
      return Right(result.user.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> verifyOtpCode(String phoneNumber, String code) async {
    try {
      final result = await remoteDataSource.verifyOtpCode(phoneNumber, code);
      storageHelper.saveAccessToken(result.accessToken);
      storageHelper.saveRefreshToken(result.refreshToken);
      storageHelper.saveUser(result.user.toJsonString());
      return Right(result.user.toEntity());
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future addToken(String token) async {
    try {
      await remoteDataSource.addToken(token);
    } on CustomException catch (e) {
      log(e.message.toString());
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
