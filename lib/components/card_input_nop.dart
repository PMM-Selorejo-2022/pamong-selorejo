import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pamong_selorejo/components/card_main_menu.dart';
import 'package:pamong_selorejo/components/network.dart';
// import 'package:pamong_selorejo/components/permission.dart';
import 'package:pamong_selorejo/model/resident.dart';

class InputNOPCard extends StatefulWidget {
  const InputNOPCard({Key? key}) : super(key: key);

  @override
  State<InputNOPCard> createState() => _InputNOPCardState();
}

class _InputNOPCardState extends State<InputNOPCard> {
  final String _scanBarcode = 'Unknown';
  final TextEditingController _nop = TextEditingController(text: "080002");
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Input NOP",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: const TextStyle(fontSize: 18),
                  controller: _nop,
                  decoration: const InputDecoration(labelText: "Masukkan NOP"),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 125, 157, 156)),
                  ),
                  onPressed: () async {
                    // await getDataNOPFromInput(context);
                    Resident? data =
                        await Network().getDataNOP(context, _nop.text);
                    if (data == null) {
                      showMessage("NOP tidak ditemukan!!");
                    } else {
                      debugPrint("verifiedd : " + data.isVerif.toString());
                      if (data.isVerif == false) {
                        Navigator.pushNamed(context, '/scan');
                      } else if (data.isVerif == true) {
                        showMessage("Data sudah terverifikasi!");
                      }
                    }
                  },
                  child: const Icon(Icons.search))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: CardMainMenu(
                  icon: Image.asset("assets/img/scan.PNG"),
                  title: "Scan",
                ),
                onTap: () async {
                  // bool permission =
                  //     await PermissionRequest().permissionCamera();
                  // if (permission == true) {

                  // }
                  String bar = await scanBarcodeNormal();
                  Resident? data = await Network().getDataNOP(context, bar);
                  if (data == null) {
                    showMessage("NOP tidak ditemukan!!");
                  } else {
                    debugPrint("verifiedd : " + data.isVerif.toString());
                    if (data.isVerif == false) {
                      Navigator.pushNamed(context, '/scan');
                    } else if (data.isVerif == true) {
                      showMessage("Data sudah terverifikasi!");
                    }
                  }
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      debugPrint("this is barcode : " + barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    // if (!mounted) return;
    return barcodeScanRes;
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
