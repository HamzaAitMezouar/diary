class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  ServerException({this.message, this.statusCode});
}

class CacheException implements Exception {}

class DecodeException implements Exception {}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  NetworkException({required this.message, this.statusCode});
}

class TimeoutException implements Exception {
  final String message;
  final int? statusCode;

  TimeoutException({required this.message, this.statusCode});
}

class BackendException implements Exception {
  final String message;
  final int? statusCode;

  BackendException({required this.message, this.statusCode});
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException({required this.message});
}

class CustomException implements Exception {
  final String message;

  CustomException({required this.message});
}
