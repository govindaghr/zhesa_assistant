import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:zhebsa_assistant/database/za_darabase.dart';
import 'package:dio/dio.dart';

class ZhesaAPIProvider {
  // Response response;
  var dio = Dio();
  static final DatabaseService _databaseService = DatabaseService();
  Future<List> getAllZhesa() async {
    final db = await _databaseService.database;
    var url = "http://zhebsa.herokuapp.com/webapp/zhebsa";
    Response response = await dio.get(url);
    if (response.statusCode == 200) {
      var zhesa = response.data;
      for (int i = 0; i < zhesa.length; i++) {
        var pubdate = zhesa[i]['publish_date'];
        var zhesaID = zhesa[i]['id'];
        var zWord = zhesa[i]['zhebsa_word'];
        var zPhrase = zhesa[i]['z_phrase'];
        var audio = zhesa[i]['audio'];

        String pronunciation = audio.substring(audio.lastIndexOf("/") + 1);

        var zhesaList = await db
            .query('Zhebsa', where: 'zID = ?', whereArgs: [zhesa[i]['id']]);
        // print(zhesaList[i]['zUpdateTime']);
        if (zhesaList.isNotEmpty) {
          var zhesaSame = await db.query('Zhebsa',
              where: 'zID = ? AND zUpdateTime = ?',
              whereArgs: ['$zhesaID', '$pubdate']);
          if (zhesaSame.isNotEmpty) {
            // String file = 'assets/audio.mp3';
            //////////////////////////////////////////////
            /*  bool hasPermission = await _requestWritePermission();
            if (!hasPermission) print('permission denied');
            await dio.download(audio, getFilePath(file)); */
            downloadFile(audio, pronunciation);
            print('No Change $zhesaSame');
          } else {
            /* await db.rawUpdate('UPDATE Zhebsa SET zWord = ?, zPhrase = ?, zUpdateTime = ?, zPeonunciation = ? WHERE zId = ?',
                [zWord, zPhrase, pubdate, audio, zhesaID]); */
            downloadFile(audio, pronunciation);
            await db.rawUpdate(
                'UPDATE Zhebsa SET zWord = ?, zPhrase = ?, zUpdateTime = ?, zPronunciation = ? WHERE zId = ?',
                [zWord, zPhrase, pubdate, pronunciation, zhesaID]);
            print('update $zhesaList');
          }
          // await db.rawQuery('SELECT zID FROM Zhebsa WHERE zID = $zhesaID AND zUpdateTime = "$pubdate"');
          // print(zhesaSame);
        } else {
          print('Insert data $zhesaID');
        }
        // print(zhesa[i]['id']);
      }

      /* var zhesaList = await db.rawQuery(
          'SELECT zID FROM Zhebsa WHERE ZID NOT IN(SELECT wodID FROM ZhebsaWordOfDay)');
      print(zhesaList[0]); */
      return (response.data as List).map((zhesa) {
        // print('Inserting $zhesa');
        // DBProvider.db.createEmployee(Employee.fromJson(employee));
      }).toList();
    } else {
      return [];
    }
    // return 0;
  }

  /* Future<dynamic> readFileAsync(String filePath) async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    File file = File('$directory/$filePath');
    print(file);

    // String xmlString = await rootBundle.loadString(filePath);
    // print(xmlString);
    // await Directory(dirname(filePath));
    // return parseXml(xmlString);
    // final Directory root = findRoot(await getApplicationDocumentsDirectory());
    // final path = join(root, filePath);
    // print('$root$filePath');
    // print(filePath);
    // print(path);
    return (file);
  } */

  Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/assets/audio/$uniqueFileName';

    return path;
  }

  /* Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
  } */

  /*  Future<dynamic> downloadFile(String url) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    var request = await dio.get(
      url,
    );
    var bytes = await request.bodyBytes; //close();
    await file.writeAsBytes(bytes);
    print(file.path);
  } */

  /* Future<bool> _requestPermissions() async {
    var permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }

    return permission == PermissionStatus.granted;
  } */

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future downloadFile(audio, fileName) async {
    try {
      Dio dio = Dio();

      // String fileName = audio.substring(audio.lastIndexOf("/") + 1);

      var savePath = await getFilePath(fileName);
      await dio.download(audio, savePath);
      print(fileName);
      print(savePath);
    } catch (e) {
      print(e.toString());
    }
  }

  /* Future<String> getFilePath(uniqueFileName) async {
    String path = '';

    Directory dir = await getApplicationDocumentsDirectory();

    path = '${dir.path}/$uniqueFileName';

    return path;
  } */

}
