import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../database/za_darabase.dart';
import '../../model/dzongkha.dart';
import '../../model/zhebsa.dart';

class TextDetail extends StatefulWidget {
  final String searchQuery;
  const TextDetail({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<TextDetail> createState() => _TextDetailState();
}

class _TextDetailState extends State<TextDetail> {
  final DatabaseService _databaseService = DatabaseService();
  static AudioPlayer audioPlayer = AudioPlayer();

  final audioCache =
      AudioCache(prefix: 'assets/audio/', fixedPlayer: audioPlayer);

  String get sQuery => widget.searchQuery;

  _playPronunciation(fineName) async {
    await audioCache.play(fineName, mode: PlayerMode.LOW_LATENCY);

    audioPlayer.state = PlayerState.PLAYING;
  }

  late List<bool> isFavourite = [];
  late List<bool> isPlayingPronunciation = [];

  _setFaviurite(int id, int index, String tableName) async {
    var dt = DateTime.now();
    String favouriteDt = dt.toIso8601String();
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

  stopPronunciation() async {
    await audioPlayer.stop();
    for (int i = 0; i < allZhesaData.length; i++) {
      isPlayingPronunciation.add(false);
    }
    audioPlayer.state = PlayerState.STOPPED;
  }

  late int did;
  late int zid;
  List dzongkhaInput = [];
  List dzongkhaID = [];
  List allDzongkhaData = [];
  List zhesaInput = [];
  List zhesaID = [];
  List allZhesaData = [];

  @override
  void initState() {
    _zhesaText();
    _dzongkhaText();
    super.initState();
  }

  Future<void> _dzongkhaText() async {
    await _databaseService.searchDzongkha(sQuery).then((data) {
      setState(() {
        dzongkhaInput = data;
        if (dzongkhaInput.isNotEmpty) {
          for (var dzId in dzongkhaInput) {
            var dzoId = Dzongkha.fromMap(dzId);
            did = dzoId.dId;
          }
        }
      });
    });

    if (dzongkhaInput.isNotEmpty) {
      dzongkhaID.add(did);
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
          }
        });
      });
    }
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
        }
      });
    });

    if (zhesaInput.isNotEmpty) {
      zhesaID.add(zid);
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
  }

  @override
  void dispose() {
    stopPronunciation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (zhesaInput.isNotEmpty) {
      return _displayZhesa();
    } else if (dzongkhaInput.isNotEmpty) {
      return _displayDzongkha();
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  _displayZhesa() {
    if (allZhesaData.isNotEmpty) {
      return ListView.builder(
        itemCount: allZhesaData.length,
        itemBuilder: (context, index) {
          Zhebsa txtData = Zhebsa.fromMap(allZhesaData[index]);
          return Card(
            elevation: 2,
            color: Colors.white70,
            shadowColor: Colors.amber[500],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: <Widget>[
                    Center(
                      child: IconButton(
                        onPressed: () =>
                            _setFaviurite(txtData.zId, index, 'Zhebsa'),
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

  _displayDzongkha() {
    return ListView.builder(
      itemCount: allDzongkhaData.length,
      itemBuilder: (context, index) {
        Dzongkha txtData = Dzongkha.fromMap(allDzongkhaData[index]);
        return Card(
          elevation: 2,
          color: Colors.white70,
          shadowColor: Colors.amber[500],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: <Widget>[
                  Center(
                    child: IconButton(
                      onPressed: () =>
                          _setFaviurite(txtData.dId, index, 'Dzongkha'),
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
