import 'package:flutter/material.dart';
import 'package:pamong_selorejo/components/card_welcome.dart';
import 'package:pamong_selorejo/provider/user.dart';
import 'package:provider/provider.dart';

import '../components/button_logout.dart';
import '../components/card_input_nop.dart';
import '../components/list_verified_op.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String name = "";
    if (context.read<UserProvider>().user != null) {
      name = context.read<UserProvider>().user!.name;
    }
    return Scaffold(
      backgroundColor: Colors.grey[75],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 250, 194),
        leading: Image.asset('assets/img/logo.png'),
        actions: const [LogoutButton()],
        title: const Text(
          "Rekap PBB Selorejo",
          style: TextStyle(color: Color.fromARGB(255, 125, 157, 156)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text(
                "Selamat Datang",
                style: TextStyle(
                    color: Color.fromARGB(255, 125, 157, 156),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 160,
                child: WelcomeCard(name: name),
              ),
              const InputNOPCard(),
              const SizedBox(
                height: 10,
              ),
              const DaftarOPTerverifikasi()
            ],
          ),
        ),
      ),
    );
  }
}
