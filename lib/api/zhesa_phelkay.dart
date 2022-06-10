// To parse this JSON data, do
//
//     final zhesaPhelkay = zhesaPhelkayFromMap(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

class ZhesaPhelkay {
  ZhesaPhelkay({
    required this.id,
    required this.phelkay,
  });

  final int id;
  final List<int> phelkay;

  factory ZhesaPhelkay.fromJson(String str) =>
      ZhesaPhelkay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZhesaPhelkay.fromMap(Map<String, dynamic> json) => ZhesaPhelkay(
        id: json["id"],
        phelkay: List<int>.from(json["phelkay"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "phelkay": List<dynamic>.from(phelkay.map((x) => x)),
      };
}
