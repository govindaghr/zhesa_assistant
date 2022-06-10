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
  });

  final int id;
  final String zhebsaWord;
  final String zPhrase;
  final String audio;
  final DateTime publishDate;

  factory Zhesa.fromJson(String str) => Zhesa.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Zhesa.fromMap(Map<String, dynamic> json) => Zhesa(
        id: json["id"],
        zhebsaWord: json["zhebsa_word"],
        zPhrase: json["z_phrase"],
        audio: json["audio"],
        publishDate: DateTime.parse(json["publish_date"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "zhebsa_word": zhebsaWord,
        "z_phrase": zPhrase,
        "audio": audio,
        "publish_date": publishDate.toIso8601String(),
      };
}
