import 'dart:convert';

DetailVerif residentFromJson(String str) =>
    DetailVerif.fromJson(json.decode(str));

String residentToJson(DetailVerif data) => json.encode(data.toJson());

class DetailVerif {
  DetailVerif({
    required this.id,
    required this.year,
    required this.residentId,
    required this.userId,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  dynamic year;
  int residentId;
  int userId;
  dynamic verified;
  DateTime createdAt;
  dynamic updatedAt;

  factory DetailVerif.fromJson(Map<String, dynamic> json) => DetailVerif(
        id: json["id"],
        year: json["year"],
        residentId: json["resident_id"],
        userId: json["user_id"],
        verified: json["verified"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "resident_id": residentId,
        "user_id": userId,
        "verified": verified,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt,
      };
}
