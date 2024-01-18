// To parse this JSON data, do
//
//     final dataResident = dataResidentFromJson(jsonString);

import 'dart:convert';

import 'package:pamong_selorejo/model/resident.dart';

DataResident dataResidentFromJson(String str) =>
    DataResident.fromJson(json.decode(str));

String dataResidentToJson(DataResident data) => json.encode(data.toJson());

class DataResident {
  DataResident({
    required this.data,
  });

  List<VerifiedResident> data;

  factory DataResident.fromJson(Map<String, dynamic> json) => DataResident(
        data: List<VerifiedResident>.from(
            json["data"].map((x) => VerifiedResident.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
