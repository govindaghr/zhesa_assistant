class Zhebsa {
  // static final List<String> values = [zId, zWord, zPhrase];

  final int zId;
  final String zWord;
  final String? zPhrase;
  final String? zPronunciation;
  final String? zHistory;
  final String? zFavourite; //timestamp,
  final String? zUpdateTime;

  Zhebsa({
    required this.zId,
    required this.zWord,
    this.zPhrase,
    this.zPronunciation,
    this.zHistory,
    this.zFavourite,
    this.zUpdateTime,
  });

  static Zhebsa fromJson(Map<String, Object?> json) {
    return Zhebsa(
      zId: json['zId'] as int,
      zWord: json['zWord'] as String,
      zPhrase: json['zPhrase'] as String?,
      zPronunciation: json['zPronunciation'] as String?,
      zHistory: json['zHistory'] as String?,
      zFavourite: json['zFavourite'] as String?,
      zUpdateTime: json['zUpdateTime'] as String?,
    );
  }

  Map<String, Object> toJson() {
    return {
      'zId': zId,
      'zWord': zWord,
      'zPhrase': zPhrase!,
      'zPronunciation': zPronunciation!,
      'zHistory': zHistory!,
      'zFavourite': zFavourite!,
      'zUpdateTime': zUpdateTime!,
    };
  }

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.

  @override
  String toString() =>
      'Zhebsa(zId: $zId, zWord: $zWord, zPhrase: $zPhrase, zPronunciation:$zPronunciation, zHistory: $zHistory, zFavourite: $zFavourite, zUpdateTime: $zUpdateTime)';
}
