// To parse this JSON data, do
//
//     final phelkay = phelkayFromMap(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

class Phelkay {
  Phelkay({
    required this.id,
    required this.phelkayWord,
    required this.pPhrase,
    required this.publishDate,
  });

  final int id;
  final String phelkayWord;
  final String pPhrase;
  final DateTime publishDate;

  factory Phelkay.fromJson(String str) => Phelkay.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Phelkay.fromMap(Map<String, dynamic> json) => Phelkay(
        id: json["id"],
        phelkayWord: json["phelkay_word"],
        pPhrase: json["p_phrase"],
        publishDate: DateTime.parse(json["publish_date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "phelkay_word": phelkayWord,
        "p_phrase": pPhrase,
        "publish_date": publishDate.toIso8601String(),
      };
}
