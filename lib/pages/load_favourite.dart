import 'package:flutter/material.dart';
import 'package:zhebsa_assistant/database/za_darabase.dart';
import 'package:zhebsa_assistant/model/dzongkha_zhebsa.dart';

import '../database/za_darabase.dart';
import 'components/view_zhebsa_of_day.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  final DatabaseService _databaseService = DatabaseService();

  Future<List<FavouriteDataModel>> _getFavourite() async {
    return await _databaseService.showFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavouriteDataModel>>(
      future: _getFavourite(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final zhesa = snapshot.data![index];
              return _buildFavourite(zhesa, context);
            },
          );
        } else {
          return const Center(
            child: Text('No Favourites'),
          );
        }
      },
    );
  }

  Widget _buildFavourite(FavouriteDataModel zhesa, BuildContext context) {
    return Card(
      elevation: 2,
      child: SizedBox(
        width: double.infinity,
        child: ListTile(
          // leading: FlutterLogo(size: 56.0),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ZhebsaOfDayDetail(searchQuery: zhesa.fWord),
            ),
          ).then((value) {
            setState(() {});
          }),
          leading: const Icon(
            Icons.favorite,
            color: Colors.redAccent,
          ),
          // trailing: const Icon(Icons.more_vert),
          title: Text(
            zhesa.fWord,
            /* textScaleFactor: screenWidth * 0.002, */
          ),
          subtitle: Text(
            '${zhesa.fPhrase}',
            /* textScaleFactor: screenWidth * 0.002, */
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          // tileColor: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
