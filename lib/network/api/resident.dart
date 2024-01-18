import 'package:dio/dio.dart';

import '../constant/endpoint.dart';
import '../dio_client.dart';

class ResidentApi {
  final DioClient dioClient;

  ResidentApi({required this.dioClient});

  Future<Response> verificationApi(int id, String token) async {
    try {
      final Response response = await dioClient.put(
          Endpoints.admin + '/resident/updateVerified',
          data: {"id": id, "verified": true},
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> dataResidentByNOPApi(String nop, String token) async {
    try {
      final Response response = await dioClient.get(
          Endpoints.admin + '/resident/getResidentByNOP',
          queryParameters: {'nop': nop},
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> dataAllResidentByPamongApi(
      int id, int year, String token) async {
    try {
      final Response response = await dioClient.get(
          Endpoints.admin + '/resident/getResidentByVerifiedTax',
          queryParameters: {'user_id': id, 'year': year},
          options: Options(headers: {"Authorization": "bearer " + token}));
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
