class Dzongkha {
  final int dId;
  final String dWord;
  final String? dPhrase;
  final String? dHistory;
  final String? dFavourite; //timestamp,
  final DateTime dUpdateTime;

  Dzongkha({
    required this.dId,
    required this.dWord,
    this.dPhrase,
    this.dHistory,
    this.dFavourite,
    required this.dUpdateTime,
  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'dId': dId,
      'dWord': dWord,
      'dPhrase': dPhrase,
      'dHistory': dHistory,
      'dFavourite': dFavourite,
      'dUpdateTime': dUpdateTime.toIso8601String(),
    };
  }

  factory Dzongkha.fromMap(Map<String, dynamic> map) {
    return Dzongkha(
      dId: map['dId']?.toInt() ?? 0,
      dWord: map['dWord'] ?? '',
      dPhrase: map['dPhrase'] ?? '',
      dHistory: map['dHistory'] ?? '',
      dFavourite: map['dFavourite'] ?? '',
      dUpdateTime: DateTime.parse(map['dUpdateTime'] as String),
    );
  }

  /* String toJson() => json.encode(toMap());

  factory Dzongkha.fromJson(String source) =>
      Dzongkha.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() =>
      'Dzongkha(dId: $dId, dWord: $dWord, dPhrase: $dPhrase, dHistory: $dHistory, dFavourite: $dFavourite, dUpdateTime: $dUpdateTime)'; */
}
