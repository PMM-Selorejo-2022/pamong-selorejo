// To parse this JSON data, do
//
//     final residentTwo = residentTwoFromJson(jsonString);

import 'dart:convert';

ResidentTwo residentTwoFromJson(String str) =>
    ResidentTwo.fromJson(json.decode(str));

String residentTwoToJson(ResidentTwo data) => json.encode(data.toJson());

class ResidentTwo {
  ResidentTwo({
    required this.data,
  });

  List<Datum> data;

  factory ResidentTwo.fromJson(Map<String, dynamic> json) => ResidentTwo(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.no,
    required this.nop,
    required this.tahun,
    required this.namaWp,
    required this.tanggal,
    required this.bakuSppt,
    required this.denda,
    required this.pbbDibayar,
    required this.status,
  });

  int no;
  String nop;
  String tahun;
  String namaWp;
  String tanggal;
  String bakuSppt;
  String denda;
  String pbbDibayar;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        no: json["NO"],
        nop: json["NOP"],
        tahun: json["TAHUN"],
        namaWp: json["NAMA_WP"],
        tanggal: json["TANGGAL"],
        bakuSppt: json["BAKU_SPPT"],
        denda: json["DENDA"],
        pbbDibayar: json["PBB_DIBAYAR"],
        status: json["STATUS"],
      );

  Map<String, dynamic> toJson() => {
        "NO": no,
        "NOP": nop,
        "TAHUN": tahun,
        "NAMA_WP": namaWp,
        "TANGGAL": tanggal,
        "BAKU_SPPT": bakuSppt,
        "DENDA": denda,
        "PBB_DIBAYAR": pbbDibayar,
        "STATUS": status,
      };
}
