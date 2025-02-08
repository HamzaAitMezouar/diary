import '../../repositories/authentication/authentication_repository.dart';

class LogOutUseCase {
  final AuthenticationRepository repository;

  LogOutUseCase(this.repository);

  Future call() {
    return repository.logout();
  }
}
