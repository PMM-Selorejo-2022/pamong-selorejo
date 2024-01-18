import 'package:pamong_selorejo/model/detail_verif.dart';

class VerifiedResident {
  VerifiedResident({
    required this.resident,
    required this.detailVerif,
  });

  Resident resident;
  DetailVerif detailVerif;

  factory VerifiedResident.fromJson(Map<String, dynamic> json) =>
      VerifiedResident(
        resident: Resident.fromJson(json),
        detailVerif: DetailVerif.fromJson(json["detail_verif"]),
      );

  Map<String, dynamic> toJson() => {
        "resident": resident.toJson(),
        "detail_verif": detailVerif.toJson(),
      };
}

class Resident {
  Resident(
      {required this.id,
      required this.tahun,
      required this.kec,
      required this.kel,
      required this.blok,
      required this.urut,
      required this.nama,
      required this.jalanWp,
      required this.rtWp,
      required this.rwWp,
      required this.kelurahanWp,
      required this.jalanOp,
      required this.rtOp,
      required this.rwOp,
      required this.noPersilSppt,
      required this.luasBumi,
      required this.luasBng,
      required this.ketetapan,
      required this.isVerif});

  int id;
  String tahun;
  String kec;
  String kel;
  String blok;
  String urut;
  String nama;
  String jalanWp;
  String rtWp;
  String rwWp;
  String kelurahanWp;
  String jalanOp;
  String rtOp;
  String rwOp;
  String noPersilSppt;
  String luasBumi;
  String luasBng;
  String ketetapan;
  bool isVerif;

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        id: json["id"],
        tahun: json["tahun"],
        kec: json["kec"],
        kel: json["kel"],
        blok: json["blok"],
        urut: json["urut"],
        nama: json["nama"],
        jalanWp: json["jalan_wp"],
        rtWp: json["rt_wp"],
        rwWp: json["rw_wp"],
        kelurahanWp: json["kelurahan_wp"],
        jalanOp: json["jalan_op"],
        rtOp: json["rt_op"],
        rwOp: json["rw_op"],
        noPersilSppt: json["no_persil_sppt"],
        luasBumi: json["luas_bumi"],
        luasBng: json["luas_bng"],
        ketetapan: json["ketetapan"],
        isVerif: json["is_verif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tahun": tahun,
        "kec": kec,
        "kel": kel,
        "blok": blok,
        "urut": urut,
        "nama": nama,
        "jalan_wp": jalanWp,
        "rt_wp": rtWp,
        "rw_wp": rwWp,
        "kelurahan_wp": kelurahanWp,
        "jalan_op": jalanOp,
        "rt_op": rtOp,
        "rw_op": rwOp,
        "no_persil_sppt": noPersilSppt,
        "luas_bumi": luasBumi,
        "luas_bng": luasBng,
        "ketetapan": ketetapan,
        "is_verif": isVerif
      };
}
