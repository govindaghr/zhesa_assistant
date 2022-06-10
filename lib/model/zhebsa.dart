class Zhebsa {
  // static final List<String> values = [zId, zWord, zPhrase];

  final int zId;
  final String zWord;
  final String? zPhrase;
  final String? zPronunciation;
  final String? zHistory;
  final String? zFavourite; //timestamp,
  final DateTime zUpdateTime;

  Zhebsa({
    required this.zId,
    required this.zWord,
    this.zPhrase,
    this.zPronunciation,
    this.zHistory,
    this.zFavourite,
    required this.zUpdateTime,
  });

  factory Zhebsa.fromMap(Map<String, dynamic> map) {
    return Zhebsa(
      zId: map['zId']?.toInt() ?? 0,
      zWord: map['zWord'] ?? '',
      zPhrase: map['zPhrase'] ?? '',
      zPronunciation: map['zPronunciation'] ?? '',
      zHistory: map['zHistory'] ?? '',
      zFavourite: map['zFavourite'] ?? '',
      zUpdateTime: DateTime.parse(map['zUpdateTime'] as String),
    );
  }

  // Convert a Zhebsa into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'zId': zId,
      'zWord': zWord,
      'zPhrase': zPhrase,
      'zPronunciation': zPronunciation,
      'zHistory': zHistory,
      'zFavourite': zFavourite,
      'zUpdateTime': zUpdateTime.toIso8601String(),
    };
  }

  Map<String, dynamic> toMapFavourite() {
    return {
      'zId': zId,
      'zFavourite': zFavourite,
    };
  }

  /* String toJson() => json.encode(toMap());
  factory Zhebsa.fromJson(String source) => Zhebsa.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() =>
      'Zhebsa(zId: $zId, zWord: $zWord, zPhrase: $zPhrase, zPronunciation:$zPronunciation, zHistory: $zHistory, zFavourite: $zFavourite, zUpdateTime: $zUpdateTime)';
       */
}

//ZhebsaWordOfDay Model
class ZhebsaWordOfDay {
  late final int wodID;
  late final String wodDay;
  ZhebsaWordOfDay({required this.wodID, required this.wodDay});

  factory ZhebsaWordOfDay.fromMap(Map<String, dynamic> map) {
    return ZhebsaWordOfDay(wodID: map['wodID'], wodDay: map['wodDay']);
  }

  Map<String, dynamic> toMap() {
    return {'wodID': wodID, 'wodDay': wodDay};
  }

  /* String toJson() => json.encode(toMap());

  factory ZhebsaWordOfDay.fromJson(String source) =>
      ZhebsaWordOfDay.fromMap(json.decode(source)); */
}
