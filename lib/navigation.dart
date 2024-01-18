import 'package:flutter/material.dart';
import 'package:pamong_selorejo/screen/home.dart';
import 'package:pamong_selorejo/screen/list.dart';
import 'package:pamong_selorejo/screen/verifiy_op.dart';
import 'package:pamong_selorejo/screen/signin.dart';
import 'package:pamong_selorejo/screen/splashscreen.dart';

class Navigation {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/': (context) => const SplashScreen(),
    '/home': (context) => const HomeScreen(),
    '/sign-in': (context) => const SignInScreen(),
    '/scan': (context) => const VerifyOPScreen(),
    '/list': (context) => const ListScreen(),
  };
}
