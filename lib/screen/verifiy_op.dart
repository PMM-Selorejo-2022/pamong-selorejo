import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pamong_selorejo/model/resident.dart';
import 'package:pamong_selorejo/provider/resident.dart';
import 'package:provider/provider.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/api/resident.dart';
import '../network/dio_client.dart';
import '../network/repo/resident.dart';

class VerifyOPScreen extends StatefulWidget {
  const VerifyOPScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOPScreen> createState() => _VerifyOPScreenState();
}

class _VerifyOPScreenState extends State<VerifyOPScreen> {
  @override
  Widget build(BuildContext context) {
    String nop = context.watch<ResidentProvider>().nop;
    Resident? dataResident = context.watch<ResidentProvider>().resident!;
    TextEditingController nama = TextEditingController(text: dataResident.nama);
    MoneyMaskedTextController pajak = MoneyMaskedTextController(
        leftSymbol: "Rp.",
        initialValue: double.parse(dataResident.ketetapan),
        thousandSeparator: ".",
        decimalSeparator: ",");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Rekap PBB Selorejo",
          style: TextStyle(color: Color.fromARGB(255, 125, 157, 156)),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 250, 194),
        leading: Image.asset('assets/img/logo.png'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, '/home');
              },
              child: const Text(
                "Kembali",
                style: TextStyle(color: Color.fromARGB(255, 125, 157, 156)),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Center(
            child: Text(
              "Verifikasi Data",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Color.fromARGB(255, 125, 157, 156)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Data Objek Pajak",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Nama",
          ),
          TextField(
            controller: nama,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Ketetapan"),
          TextField(
            controller: pajak,
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 125, 157, 156))),
                onPressed: () async {
                  Dio dio = Dio();
                  DioClient dioClient = DioClient(dio);
                  ResidentApi residentApi = ResidentApi(dioClient: dioClient);
                  ResidentRepository repo =
                      ResidentRepository(residentApi: residentApi);
                  final prefs = await SharedPreferences.getInstance();
                  String token = prefs.getString("token")!;
                  int id = context.read<ResidentProvider>().resident!.id;
                  await repo.verificationReq(id, token);
                  showMessage("Verifikasi berhasil!");
                  // Navigator.pop(context, '/home');
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Verifikasi",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ]),
      ),
    ));
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Pesan"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context, '/home');
                },
              )
            ],
          );
        });
  }
}
