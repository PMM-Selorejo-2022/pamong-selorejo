import 'package:flutter/material.dart';
import 'package:pamong_selorejo/navigation.dart';
import 'package:pamong_selorejo/provider/resident.dart';
import 'package:pamong_selorejo/provider/user.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => ResidentProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Pamong Selorejo',
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(primaryColor: const Color.fromARGB(255, 255, 250, 194)),
        initialRoute: '/',
        routes: Navigation.routes);
  }
}
