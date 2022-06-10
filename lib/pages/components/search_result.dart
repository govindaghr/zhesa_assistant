import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:zhebsa_assistant/model/dzongkha.dart';
import 'package:zhebsa_assistant/model/zhebsa.dart';

import '../../database/za_darabase.dart';

class SearchResults extends StatefulWidget {
  final String searchQuery;
  const SearchResults({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final DatabaseService _databaseService = DatabaseService();
  static AudioPlayer audioPlayer = AudioPlayer();

  final audioCache =
      AudioCache(prefix: 'assets/audio/', fixedPlayer: audioPlayer);

  String get sQuery => widget.searchQuery;

  _playPronunciation(fineName) async {
    await audioCache.play(
      fineName,
      mode: PlayerMode.LOW_LATENCY,
    ); //stayAwake: false
    audioPlayer.state = PlayerState.PLAYING;
  }

  stopPronunciation() async {
    await audioPlayer.stop();
    for (int i = 0; i < allZhesaData.length; i++) {
      isPlayingPronunciation.add(false);
    }
    audioPlayer.state = PlayerState.STOPPED;
  }

  // bool isFavourite = false;
  // bool isPlayingPronunciation = false;
  late List<bool> isFavourite = [];
  late List<bool> isPlayingPronunciation = [];
  var dt = DateTime.now().toIso8601String();

  _setFaviurite(int id, int index, String tableName) async {
    String favouriteDt = dt;
    isFavourite[index] ? favouriteDt = '' : favouriteDt = favouriteDt;
    if (tableName == 'Zhebsa') {
      _databaseService.updateFavourite(id, favouriteDt, tableName);
    } else if (tableName == 'Dzongkha') {
      _databaseService.updateFavourite(id, favouriteDt, tableName);
    }
    setState(() {
      isFavourite[index] = !isFavourite[index];
    });
  }

  late int did;
  late int zid;
  List dzongkhaInput = [];
  List dzongkhaID = [];
  List allDzongkhaData = [];
  List zhesaInput = [];
  List zhesaID = [];
  List allZhesaData = [];

  Future<void> _dzongkhaText() async {
    await _databaseService.searchDzongkha(sQuery).then((data) {
      setState(() {
        dzongkhaInput = data;
        if (dzongkhaInput.isNotEmpty) {
          for (var dzId in dzongkhaInput) {
            var dzoId = Dzongkha.fromMap(dzId);
            did = dzoId.dId;
          }
          _databaseService.updateHistory(did, dt, 'Dzongkha');
        }
      });
    });

    if (dzongkhaInput.isNotEmpty) {
      List zhID = [];
      await _databaseService.getZhebsaSearchId(did).then((value) {
        zhID.addAll(value);
        setState(() {
          zhesaID = zhID;
        });
      });
    }

    await _databaseService.getZhebsaSearch(zhesaID).then((value) {
      setState(() {
        allZhesaData = value;
        for (int i = 0; i < allZhesaData.length; i++) {
          Zhebsa txtData = Zhebsa.fromMap(allZhesaData[i]);
          if (txtData.zFavourite == '') {
            isFavourite.add(false);
          } else {
            isFavourite.add(true);
          }
          isPlayingPronunciation.add(false);
        }
      });
    });
  }

  Future<void> _zhesaText() async {
    await _databaseService.searchZhesaWord(sQuery).then((value) {
      setState(() {
        zhesaInput = value;
        if (zhesaInput.isNotEmpty) {
          for (var zhId in zhesaInput) {
            var zheId = Zhebsa.fromMap(zhId);
            zid = zheId.zId;
          }
          _databaseService.updateHistory(zid, dt, 'Zhebsa');
        }
      });
    });

    if (zhesaInput.isNotEmpty) {
      List dzID = [];
      await _databaseService.getDzongkhaSearchId(zid).then((value) {
        dzID.addAll(value);
        setState(() {
          dzongkhaID = dzID;
        });
      });

      await _databaseService.getDzongkhaSearch(dzongkhaID).then((value) {
        setState(() {
          allDzongkhaData = value;
          for (int i = 0; i < allDzongkhaData.length; i++) {
            Dzongkha txtData = Dzongkha.fromMap(allDzongkhaData[i]);
            if (txtData.dFavourite == '') {
              isFavourite.add(false);
            } else {
              isFavourite.add(true);
            }
            // isPlayingPronunciation.add(false);
          }
        });
      });
    }
  }

  @override
  void initState() {
    _zhesaText();
    _dzongkhaText();
    super.initState();
  }

  @override
  void dispose() {
    stopPronunciation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dzongkhaInput.isNotEmpty) {
      return _displayZhesa();
    } else if (zhesaInput.isNotEmpty) {
      return _displayDzongkha();
    } else {
      return _displayNUll();
    }
  }

  _displayNUll() {
    return const Center(
      child: Text('No Data'),
    );
  }

  Widget _displayZhesa() {
    if (allZhesaData.isNotEmpty) {
      return ListView.builder(
        itemCount: allZhesaData.length,
        itemBuilder: (context, index) {
          Zhebsa txtData = Zhebsa.fromMap(allZhesaData[index]);
          return Card(
            elevation: 10,
            color: Colors.white70,
            shadowColor: Colors.amber[500],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.orange[400],
                    border: Border.all(
                      color: Colors.amber.shade100,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      sQuery,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Center(
                      child: IconButton(
                        onPressed: () =>
                            _setFaviurite(txtData.zId, index, 'Zhebsa'),

                        /*  setState(() {
                          isFavourite[index] = !isFavourite[index];
                        }), */
                        icon: Icon(
                          isFavourite[index]
                              ? Icons.favorite_sharp
                              : Icons.favorite_border_sharp,
                          size: 30.0,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('ཞེ་ས།'),
                        subtitle: Text(txtData.zWord), //ཞེ་སའི་ཚིག
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {
                          if (txtData.zPronunciation != '') {
                            //check if audio exist
                            isPlayingPronunciation[index]
                                ? stopPronunciation()
                                : _playPronunciation(
                                    '${txtData.zPronunciation}');
                            setState(() {
                              isPlayingPronunciation[index] =
                                  !isPlayingPronunciation[index];
                            });

                            audioPlayer.onPlayerCompletion.listen((event) {
                              setState(() {
                                isPlayingPronunciation[index] = false;
                              });
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pronunciation not found'),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          isPlayingPronunciation[index]
                              ? Icons.stop_circle_outlined
                              : Icons.volume_up,
                          size: 50.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: ListTile(
                    title: const Text('དཔེར་བརྗོད།'),
                    subtitle: SelectableText('${txtData.zPhrase}'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const Text('No Data');
    }
  }

  Widget _displayDzongkha() {
    return ListView.builder(
      itemCount: allDzongkhaData.length,
      itemBuilder: (context, index) {
        Dzongkha txtData = Dzongkha.fromMap(allDzongkhaData[index]);
        return Card(
          elevation: 10,
          color: Colors.white70,
          shadowColor: Colors.amber[500],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.orange[400],
                  border: Border.all(
                    color: Colors.amber.shade100,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    sQuery,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Center(
                    child: IconButton(
                      onPressed: () =>
                          _setFaviurite(txtData.dId, index, 'Dzongkha'),
                      /* setState(() {
                        isFavourite[index] = !isFavourite[index];
                      }), */
                      icon: Icon(
                        isFavourite[index]
                            ? Icons.favorite_sharp
                            : Icons.favorite_border_sharp,
                        size: 30.0,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('ཕལ་སྐད།།'),
                      subtitle: Text(txtData.dWord), //ཞེ་སའི་ཚིག
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 30.0),
                child: ListTile(
                  title: const Text('དཔེར་བརྗོད།'),
                  subtitle: SelectableText('${txtData.dPhrase}'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
