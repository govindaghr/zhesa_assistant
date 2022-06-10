// To parse this JSON data, do
//
//     final zhesa = zhesaFromMap(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

class Zhesa {
  Zhesa({
    required this.id,
    required this.zhebsaWord,
    required this.zPhrase,
    required this.audio,
    required this.publishDate,
    required this.phelkay,
  });

  final int id;
  final String zhebsaWord;
  final String zPhrase;
  final String audio;
  final DateTime publishDate;
  final List<Phelkay> phelkay;

  factory Zhesa.fromJson(String str) => Zhesa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Zhesa.fromMap(Map<String, dynamic> json) => Zhesa(
        id: json["id"],
        zhebsaWord: json["zhebsa_word"],
        zPhrase: json["z_phrase"],
        audio: json["audio"],
        publishDate: DateTime.parse(json["publish_date"]),
        phelkay:
            List<Phelkay>.from(json["phelkay"].map((x) => Phelkay.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "zhebsa_word": zhebsaWord,
        "z_phrase": zPhrase,
        "audio": audio,
        "publish_date": publishDate.toIso8601String(),
        "phelkay": List<dynamic>.from(phelkay.map((x) => x.toMap())),
      };
}

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
