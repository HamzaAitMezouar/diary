import '../../repositories/authentication/authentication_repository.dart';

class LogOutUseCase {
  final AuthenticationRepository repository;

  LogOutUseCase(this.repository);

  Future call(String phoneNumber, String code) {
    return repository.logout();
  }
}
