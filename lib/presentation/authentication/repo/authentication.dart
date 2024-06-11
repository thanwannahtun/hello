import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hello/core/utils/env.dart';
import 'package:hello/domain/api_utils/api_error_handler.dart';
// import 'package:hello/data/database/crud_table.dart';
import 'package:hello/domain/api_utils/api_service.dart';
import 'package:hello/utils/share_preference.dart';

class AuthenticationRepo {
  // final CRUDTable _crudTable = CRUDTable.instance;

  final ApiService _apiService = ApiService();

  static final AuthenticationRepo _instance = AuthenticationRepo._();

  AuthenticationRepo._();

  factory AuthenticationRepo() {
    return _instance;
  }

  FutureOr<String> signIn(
      {required String email, required String password}) async {
    var data = {'email': email, 'password': password};
    try {
      Response response = await _apiService.postRequest('/auth/sign_in', data);
      await SharePreference.instance
          .setString(Env.accessToken, response.data['token']);
      print('token -------------------------- ${response.data['token']}');
      return response.data['token'];
    } on DioException catch (e) {
      return ApiErrorHandler.handle(e).message;
    }
  }

  FutureOr<String> singUp(
      {required String username,
      required String email,
      required String password}) async {
    var data = {'email': email, 'password': password, 'name': username};
    try {
      Response response = await _apiService.postRequest('/auth/sign_up', data);

      await SharePreference.instance
          .setString(Env.accessToken, response.data['accessToken']);
      await SharePreference.instance
          .setString(Env.refreshToken, response.data['refreshToken']);
      return response.data['token'];
    } on DioException catch (e) {
      return ApiErrorHandler.handle(e).message;
    }
  }

  Future<bool> signOut() async {
    return await SharePreference.instance.remove(Env.accessToken) &&
        await SharePreference.instance.remove(Env.refreshToken);
  }
}
