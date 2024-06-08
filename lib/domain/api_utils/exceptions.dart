class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;
}

class NetworkException extends ApiException {
  NetworkException(String message) : super(message: message);
}

class TimeoutException extends ApiException {
  TimeoutException(String message) : super(message: message);
}

class ServerException extends ApiException {
  ServerException(String message, int? statusCode)
      : super(message: message, statusCode: statusCode);
}

class AuthenticationException extends ApiException {
  AuthenticationException(String message) : super(message: message);
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message: message);
}

class NotFoundException extends ApiException {
  NotFoundException(String message) : super(message: message);
}
