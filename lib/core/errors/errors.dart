class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({required super.errorMessage});
}

class CostumeFailure extends Failure {
  CostumeFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}

class PermissionFailure extends Failure {
  PermissionFailure({required super.errorMessage});
}
