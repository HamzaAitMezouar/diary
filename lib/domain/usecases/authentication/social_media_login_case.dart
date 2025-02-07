import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../../core/params/social_media_params.dart';
import '../../../core/responses/datasource_responses.dart';
import '../../repositories/authentication/authentication_repository.dart';

class SocialMediaLoginUseCase {
  final AuthenticationRepository repository;

  SocialMediaLoginUseCase(this.repository);

  Future<Either<Failure, AuthResponse>> call(SocialMediaParams params) {
    return repository.socialMediaLogin(params);
  }
}
