import 'package:dartz/dartz.dart';
import 'package:diary/data/models/facebook_user.dart';

import '../../../core/errors/errors.dart';
import '../../../core/errors/exceptions.dart';
import '../../../data/datasource/authentication/social_media_service_datasource.dart';

abstract class SocialMediaServiceRepository {
  Future<Either<Failure, SocialMediaUser>> loginWithFacebook();
  Future<Either<Failure, SocialMediaUser>> loginWitnGoogle();
  Future<Either<Failure, SocialMediaUser>> loginWithApple();
}

class SocialMediaServiceRepositoryImpl extends SocialMediaServiceRepository {
  final SocialMediaServiceDatasource _mediaServiceDatasource;
  SocialMediaServiceRepositoryImpl(this._mediaServiceDatasource);
  @override
  Future<Either<Failure, SocialMediaUser>> loginWithApple() {
    // TODO: implement loginWithApple
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, SocialMediaUser>> loginWithFacebook() async {
    try {
      final result = await _mediaServiceDatasource.loginWithFacebook();
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }

  @override
  Future<Either<Failure, SocialMediaUser>> loginWitnGoogle() async {
    try {
      final result = await _mediaServiceDatasource.loginWithGoogle();
      return Right(result);
    } on CustomException catch (e) {
      return Left(CostumeFailure(errorMessage: e.message));
    } on UnexpectedException catch (e) {
      return Left(UnexpectedFailure(errorMessage: e.message));
    }
  }
}
