import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pamong_selorejo/provider/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../model/user.dart';
import '../network/api/auth.dart';
import '../network/dio_client.dart';
import '../network/repo/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), (() async {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString("token") != null) {
        Dio dio = Dio();
        DioClient dioClient = DioClient(dio);
        AuthApi authApi = AuthApi(dioClient: dioClient);
        AuthRepository repo = AuthRepository(authApi: authApi);
        try {
          await repo.checkReq(prefs.getString("token")!);
          User user = await repo.meReq(prefs.getString("token")!);
          context.read<UserProvider>().addUser(user);
          Navigator.pushReplacementNamed(context, '/home');
        } catch (e) {
          Navigator.pushReplacementNamed(context, '/sign-in');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/sign-in');
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/img/logo.png',
            height: 100,
            width: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Pamong Desa Selorejo",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ));
  }
}
