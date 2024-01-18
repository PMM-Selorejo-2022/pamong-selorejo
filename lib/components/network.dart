import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pamong_selorejo/network/repo/auth.dart';
import 'package:pamong_selorejo/network/repo/resident.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/resident.dart';
import '../network/api/auth.dart';
import '../network/api/resident.dart';
import '../network/dio_client.dart';
import '../provider/resident.dart';

class Network {
  AuthRepository authRepository() {
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AuthApi authApi = AuthApi(dioClient: dioClient);
    AuthRepository repo = AuthRepository(authApi: authApi);
    return repo;
  }

  ResidentRepository residentRepository() {
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    ResidentApi residentApi = ResidentApi(dioClient: dioClient);
    ResidentRepository repo = ResidentRepository(residentApi: residentApi);
    return repo;
  }

  Future<Resident?> getDataNOP(BuildContext context, String nop) async {
    try {
      ResidentRepository repo = Network().residentRepository();
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")!;
      Resident dataResident = await repo.dataResidentByNOPReq(nop, token);
      context.read<ResidentProvider>().removeResident();
      context.read<ResidentProvider>().removeNOP();
      context.read<ResidentProvider>().addResident(dataResident);
      context.read<ResidentProvider>().addNOP(nop);
      return dataResident;
    } catch (e) {
      return null;
    }
  }
}
