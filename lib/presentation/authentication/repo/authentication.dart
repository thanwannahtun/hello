import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hello/core/utils/env.dart';
import 'package:hello/domain/api_utils/api_error_handler.dart';
// import 'package:hello/data/database/crud_table.dart';
import 'package:hello/domain/api_utils/api_service.dart';
import 'package:hello/domain/api_utils/exceptions.dart';
import 'package:hello/utils/share_preference.dart';

class AuthenticationRepo {
  // final CRUDTable _crudTable = CRUDTable.instance;

  final ApiService _apiService = ApiService();

  static final AuthenticationRepo _instance = AuthenticationRepo._();

  AuthenticationRepo._();

  factory AuthenticationRepo() {
    return _instance;
  }

  FutureOr<void> signIn(
      {required String email, required String password}) async {
    var data = {'email': email, 'password': password};

    Response response = await _apiService.postRequest('/auth/sign_in', data);
    if (response.data['accessToken'] == null &&
        response.data['refreshToken'] == null) {
      throw ApiException(message: 'Fail to signup');
    }

    await SharePreference.instance
        .setString(Env.accessToken, response.data['accessToken']);
    print('token -------------------------- ${response.data['accessToken']}');
    // return response.data['accessToken'];
  }

  FutureOr<void> singUp(
      {required String username,
      required String email,
      required String password}) async {
    var data = {'email': email, 'password': password, 'name': username};
    Response response = await _apiService.postRequest('/auth/sign_up', data);

    if (response.data['accessToken'] == null &&
        response.data['refreshToken'] == null) {
      throw ApiException(message: 'Fail to signup');
    }

    await SharePreference.instance
        .setString(Env.accessToken, response.data['accessToken']);
    await SharePreference.instance
        .setString(Env.refreshToken, response.data['refreshToken']);
    // return response.data['token'];
  }

  Future<bool> signOut() async {
    return await SharePreference.instance.remove(Env.accessToken) &&
        await SharePreference.instance.remove(Env.refreshToken);
  }
}
