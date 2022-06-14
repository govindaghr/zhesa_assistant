import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zhebsa_assistant/database/za_darabase.dart';
import 'package:zhebsa_assistant/pages/components/custom_search.dart';
import 'package:zhebsa_assistant/pages/components/view_zhebsa_of_day.dart';
import 'package:zhebsa_assistant/model/zhebsa.dart';

class SearchIcon extends StatefulWidget {
  const SearchIcon({Key? key}) : super(key: key);

  @override
  State<SearchIcon> createState() => _SearchIconState();
}

class _SearchIconState extends State<SearchIcon> {
  final DatabaseService _databaseService = DatabaseService();

  var allData = [];
  var searchHistory = [];
  var wod = '';
  var phrase = '';

  _loadData() async {
    await _databaseService.populateSearch().then((data) {
      setState(() {
        for (int i = 0; i < data.length; i++) {
          allData.add(data[i]['sWord']);
        }
      });
    });

    await _databaseService.populateHistory().then((data) {
      setState(() {
        for (int i = 0; i < data.length; i++) {
          searchHistory.add(data[i]['hWord']);
        }
      });
    });

    await _databaseService.showWordOfDay().then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          Zhebsa txtData = Zhebsa.fromMap(value[i]);
          wod = txtData.zWord;
          phrase = txtData.zPhrase!;
        }
      });
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () => showSearch(
                      context: context,
                      delegate: CustomSearch(allData, searchHistory)),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 9.5, top: 1.6),
                        child: Icon(
                          Icons.search_sharp,
                          color: Colors.deepOrange,
                          size: 30.0,
                        ),
                      ),
                      Text(
                        "འཚོལ།/Search",
                        style: Theme.of(context).textTheme.bodyText2?.merge(
                              const TextStyle(
                                  color: Colors.deepOrange, fontSize: 16.0),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'wordOfTheDay'.tr,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ZhebsaOfDayDetail(searchQuery: wod),
                        ),
                      ),
                      title: Text(wod),
                      subtitle: SelectableText(
                        phrase,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Please Install Dzongkha Keyboard to search. Tap on the word while searching',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
