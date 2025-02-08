import 'package:dartz/dartz.dart';
import 'package:diary/data/models/facebook_user.dart';
import 'package:diary/domain/repositories/authentication/social_media_service.dart';

import '../../../core/errors/errors.dart';

class LoginWithFacebookUseCase {
  final SocialMediaServiceRepository repository;

  LoginWithFacebookUseCase(this.repository);

  Future<Either<Failure, SocialMediaUser>> call() {
    return repository.loginWithFacebook();
  }
}
