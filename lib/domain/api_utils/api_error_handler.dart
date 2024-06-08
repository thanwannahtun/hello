import 'package:dio/dio.dart';
import 'package:hello/domain/api_utils/exceptions.dart';

class ApiErrorHandler {
  static ApiException handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return ApiException(message: "Request to API was cancelled");
      case DioExceptionType.connectionTimeout:
        return TimeoutException("Connection timeout with API server");
      case DioExceptionType.sendTimeout:
        return TimeoutException("Send timeout in connection with API server");
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
            "Receive timeout in connection with API server");
      case DioExceptionType.badResponse:
        return _handleHttpResponse(error);
      case DioExceptionType.unknown:
        if (error.message?.contains("SocketException") ?? false) {
          return NetworkException("No Internet connection");
        }
        return ApiException(message: "Unexpected error occurred");
      default:
        return ApiException(message: "Unexpected error occurred");
    }
  }

  static ApiException _handleHttpResponse(DioException error) {
    switch (error.response?.statusCode) {
      case 400:
        return BadRequestException(
            "Bad request: ${error.response?.data['message'] ?? 'Invalid request'}");
      case 401:
      case 403:
        return AuthenticationException(
            "Unauthorized: ${error.response?.data['message'] ?? 'Access denied'}");
      case 404:
        return NotFoundException(
            "Not found: ${error.response?.data['message'] ?? 'Resource not found'}");
      case 500:
      default:
        return ServerException(
            "Server error: ${error.response?.data['message'] ?? 'Internal server error'}",
            error.response?.statusCode);
    }
  }
}
