class DzongkhaZhebsa {
  final int dzongkhadId;
  final int zhebsazId;
  // final int englisheId;
  final DateTime? updateTime;

  DzongkhaZhebsa({
    required this.dzongkhadId,
    required this.zhebsazId,
    this.updateTime,
  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'dzongkhadId': dzongkhadId,
      'zhebsazId': zhebsazId,
      'updateTime': updateTime?.toIso8601String(),
    };
  }

  factory DzongkhaZhebsa.fromMap(Map<String, dynamic> map) {
    return DzongkhaZhebsa(
        dzongkhadId: map['dzongkhadId']?.toInt() ?? 0,
        zhebsazId: map['zhebsazId']?.toInt() ?? 0,
        updateTime: DateTime.parse(map['updateTime'] as String)
        //map['updateTime'] ?? Null,
        );
  }

  /* String toJson() => json.encode(toMap());

  factory DzongkhaZhebsa.fromJson(String source) =>
      DzongkhaZhebsa.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() =>
      'DzongkhaZhebsa(dzongkhadId: $dzongkhadId, zhebsazId: $zhebsazId, updateTime: $updateTime)'; */
}

//SearchList Model
class SearchDataModel {
  final String sWord;
  SearchDataModel({required this.sWord});

  /* Map<String, dynamic> toMap() {
    return {
      'sWord': sWord,
    };
  } */

  factory SearchDataModel.fromMap(Map<String, dynamic> map) {
    return SearchDataModel(
      sWord: map['sWord'],
    );
  }

  /* String toJson() => json.encode(toMap());

  factory SearchDataModel.fromJson(String source) =>
      SearchDataModel.fromMap(json.decode(source)); */
}

/* class SearchDataModel {
  String sWord;
  SearchDataModel({required this.sWord});

  Map<String, dynamic> toJson() => {'sWord': sWord};

  factory SearchDataModel.fromMap(Map<String, dynamic> json) =>
      SearchDataModel(sWord: json['sWord']);

} */

//History Model
class HistoryDataModel {
  final String? hWord;
  final String? hHistory;
  HistoryDataModel({this.hWord, this.hHistory});
  factory HistoryDataModel.fromMap(Map<String, dynamic> map) {
    return HistoryDataModel(
      hWord: map['hWord'] ?? '',
      hHistory: map['hHistory'] ?? '',
    );
  }
}

//SearchList Model
class FavouriteDataModel {
  final String fWord;
  final String? fPhrase;
  final String? favouroite;
  FavouriteDataModel({required this.fWord, this.fPhrase, this.favouroite});

  factory FavouriteDataModel.fromMap(Map<String, dynamic> map) {
    return FavouriteDataModel(
      fWord: map['fWord'],
      fPhrase: map['fPhrase'] ?? '',
      favouroite: map['favouroite'] ?? '',
    );
  }

  /* String toJson() => json.encode(toMap());

  factory SearchDataModel.fromJson(String source) =>
      SearchDataModel.fromMap(json.decode(source)); */
}
