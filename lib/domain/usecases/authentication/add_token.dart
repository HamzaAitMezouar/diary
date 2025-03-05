import '../../repositories/authentication/authentication_repository.dart';

class AddTokenUseCase {
  final AuthenticationRepository repository;

  AddTokenUseCase(this.repository);

  Future call(String token) {
    return repository.addToken(token);
  }
}
