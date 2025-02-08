import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../../core/params/social_media_params.dart';
import '../../entities/user_entity.dart';
import '../../repositories/authentication/authentication_repository.dart';

class SocialMediaLoginUseCase {
  final AuthenticationRepository repository;

  SocialMediaLoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(SocialMediaParams params) {
    return repository.socialMediaLogin(params);
  }
}
