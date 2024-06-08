import 'package:dio/dio.dart';
import 'package:hello/domain/api_utils/api_error_handler.dart';
import 'package:hello/domain/api_utils/logging_inteceptor.dart';
import 'package:hello/domain/api_utils/retry_intercepton.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;
  final String _refreshTokenUrl = '/auth/refresh';

  static const String _baseUrl = 'http://localhost:3000';

  static const String _ipAddress = 'http://192.168.100.7:3000';

  static const String _ip2 = 'http://192.168.1.15:3000';

  ApiService([baseUrl = _ip2])
      : _dio = Dio(
          BaseOptions(
              baseUrl: baseUrl,
              connectTimeout: const Duration(seconds: 120),
              receiveTimeout: const Duration(seconds: 120),
              sendTimeout: const Duration(minutes: 2),
              receiveDataWhenStatusError: true,
              responseType: ResponseType.json,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Credentials": true,
                "Access-Control-Allow-Headers":
                    "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
                "Access-Control-Allow-Methods":
                    'POST, GET, OPTIONS, PUT, DELETE',
              }),
        ) {
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    _dio.interceptors.add(RetryInterceptor(dio: _dio));

    _dio.interceptors.add(LoggingInterceptor(dio: _dio));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add common headers or tokens here
        options.headers['Authorization'] = 'Bearer your_api_token';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // Handle common response behavior
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        // Handle common error behavior
        if (e.response?.statusCode == 401 && _shouldRetry(e)) {
          // Attempt to refresh the token
          RequestOptions requestOptions = e.requestOptions;
          try {
            await _refreshToken();
            requestOptions.headers['Authorization'] = 'Bearer new_api_token';
            final cloneReq = await _dio.request(
              requestOptions.path,
              options: Options(
                method: requestOptions.method,
                headers: requestOptions.headers,
              ),
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters,
            );
            return handler.resolve(cloneReq);
          } on DioException catch (e) {
            return handler.next(e);
          }
        } else {
          ApiErrorHandler.handle(e); // I think error here
        }

        /// <------ Error Here
        // return handler.next(
        //     ApiErrorHandler.handle(e)); // Handle error using ApiErrorHandler
      },
    ));
  }

  Future<void> _refreshToken() async {
    // Implement your token refresh logic here.
    // This typically involves making a POST request to the refresh token endpoint
    // and updating the stored tokens.
    try {
      final response = await _dio.post(_refreshTokenUrl, data: {
        'refresh_token': 'your_refresh_token',
      });

      // Extract the new token from the response and store it
      String newToken = response.data['access_token']; // token
      // Update the authorization header for subsequent requests
      _dio.options.headers['Authorization'] = 'Bearer $newToken';

      // You might also want to update the refresh token
      // String newRefreshToken = response.data['refresh_token'];
      // Store the new refresh token securely
    } on DioException catch (e) {
      // Handle error during token refresh
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Response> getRequest(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Response> postRequest(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Response> putRequest(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Response> deleteRequest(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw ApiErrorHandler.handle(e);
    }
  }

  Future<Response> patchRequest(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response;
    } on DioException catch (e) {
      // Handle DioException
      throw ApiErrorHandler.handle(e);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.unknown;
  }
}
