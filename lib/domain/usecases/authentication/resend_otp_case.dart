import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../repositories/authentication/authentication_repository.dart';

class ResendOtpUseCase {
  final AuthenticationRepository repository;

  ResendOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call(String phoneNumber) {
    return repository.resendOtp(phoneNumber);
  }
}
