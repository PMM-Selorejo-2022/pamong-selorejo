import 'package:dio/dio.dart';
import 'package:pamong_selorejo/model/auth.dart';
import 'package:pamong_selorejo/model/user.dart';

import '../api/auth.dart';
import '../dio_exception.dart';

class AuthRepository {
  final AuthApi authApi;

  AuthRepository({required this.authApi});

  Future<Auth> loginReq(String email, String password) async {
    try {
      final response = await authApi.loginApi(email, password);
      if (response.statusCode == 200) {
        return Auth.fromJson(response.data["data"]);
      } else {
        return Auth.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<User> meReq(String token) async {
    try {
      final response = await authApi.meApi(token);
      return User.fromJson(response.data["data"]);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<String> checkReq(String token) async {
    try {
      final response = await authApi.meApi(token);
      if (response.statusCode == 200) {
        return "OK";
      } else {
        return "Not OK";
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
