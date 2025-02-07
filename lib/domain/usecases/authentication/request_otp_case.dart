import 'package:dartz/dartz.dart';

import '../../../core/errors/errors.dart';
import '../../repositories/authentication/authentication_repository.dart';

class RequestOtpUseCase {
  final AuthenticationRepository repository;

  RequestOtpUseCase(this.repository);

  Future<Either<Failure, bool>> call(String phoneNumber) {
    return repository.requestOtpCode(phoneNumber);
  }
}
