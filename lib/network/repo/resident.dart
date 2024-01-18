import 'package:dio/dio.dart';
import 'package:pamong_selorejo/model/detail_verif.dart';
import 'package:pamong_selorejo/model/resident.dart';
import 'package:pamong_selorejo/model/resident_v2.dart';
import 'package:pamong_selorejo/network/api/resident.dart';

import '../dio_exception.dart';

class ResidentRepository {
  final ResidentApi residentApi;

  ResidentRepository({required this.residentApi});

  Future<DetailVerif> verificationReq(int id, String token) async {
    try {
      final response = await residentApi.verificationApi(id, token);
      if (response.statusCode == 200) {
        return DetailVerif.fromJson(response.data["data"]);
      } else {
        return DetailVerif.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<Resident> dataResidentByNOPReq(String nop, String token) async {
    try {
      final response = await residentApi.dataResidentByNOPApi(nop, token);
      if (response.statusCode == 200) {
        return Resident.fromJson(response.data["data"]);
      } else {
        return Resident.fromJson(response.data);
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<Datum>> dataAllResidentByPamongReq(
      int id, int year, String token) async {
    try {
      final response =
          await residentApi.dataAllResidentByPamongApi(id, year, token);
      if (response.statusCode == 200) {
        return ResidentTwo.fromJson(response.data).data;
      } else {
        return ResidentTwo.fromJson(response.data).data;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
