import 'package:dio/dio.dart';

import '../constant/endpoint.dart';
import '../dio_client.dart';

class AuthApi {
  final DioClient dioClient;

  AuthApi({required this.dioClient});

  Future<Response> loginApi(String user, String password) async {
    try {
      final Response response =
          await dioClient.post(Endpoints.auth + '/login', data: {
        'login': user,
        'password': password,
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> meApi(String token) async {
    try {
      final Response response = await dioClient.post(Endpoints.auth + "/me",
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
