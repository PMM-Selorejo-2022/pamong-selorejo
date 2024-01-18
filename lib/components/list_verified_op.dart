import 'package:flutter/material.dart';
import 'package:pamong_selorejo/components/network.dart';
import 'package:pamong_selorejo/model/resident_v2.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/repo/resident.dart';
import '../provider/user.dart';

class DaftarOPTerverifikasi extends StatefulWidget {
  const DaftarOPTerverifikasi({Key? key}) : super(key: key);

  @override
  State<DaftarOPTerverifikasi> createState() => _DaftarOPTerverifikasiState();
}

class _DaftarOPTerverifikasiState extends State<DaftarOPTerverifikasi> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daftar Objek Pajak",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 125, 157, 156)),
            ),
            onPressed: () {
              yearPicker(context);
            },
            child: Text(
              _selectedDate.year.toString(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<List<Datum>>(
            future: getAllResidentByPamong(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If we got an error
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      '${snapshot.error} occurred',
                      style: const TextStyle(fontSize: 18),
                    ),
                  );

                  // if we got our data
                } else if (snapshot.hasData) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("Data Kosong"),
                    );
                  }
                  List<Datum> list = snapshot.data!.reversed.toList();
                  return Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              list[index].namaWp,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          );
                        }),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  void yearPicker(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Year"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              selectedDate: _selectedDate,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedDate = dateTime;
                });
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  Future<List<Datum>> getAllResidentByPamong(BuildContext context) async {
    try {
      ResidentRepository repo = Network().residentRepository();

      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token")!;

      return await repo.dataAllResidentByPamongReq(
          context.read<UserProvider>().user!.id, _selectedDate.year, token);
    } catch (e) {
      return [];
    }
  }
}
