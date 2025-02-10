import 'package:dartz/dartz.dart';
import 'package:diary/data/models/facebook_user.dart';
import 'package:diary/domain/repositories/authentication/social_media_repository.dart';

import '../../../core/errors/errors.dart';

class LoginWithGoogleUsecase {
  final SocialMediaServiceRepository repository;

  LoginWithGoogleUsecase(this.repository);

  Future<Either<Failure, SocialMediaUser>> call() {
    return repository.loginWitnGoogle();
  }
}
