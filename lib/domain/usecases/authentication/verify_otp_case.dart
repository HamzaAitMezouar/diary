import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../entities/user_entity.dart';
import '../../repositories/authentication/authentication_repository.dart';

class VerifyOtpUseCase {
  final AuthenticationRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call(String phoneNumber, String code) {
    return repository.verifyOtpCode(phoneNumber, code);
  }
}
