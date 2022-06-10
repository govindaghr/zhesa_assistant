import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'locale/locale_string.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'api/zhesa_provider.dart';

void main() => runApp(const ZhebsaApp());

class ZhebsaApp extends StatelessWidget {
  const ZhebsaApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /*Media Queary scale factor to maintain same size across different media */
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        defaultScaleFactor: MediaQuery.of(context).size.shortestSide > 600
            ? MediaQuery.of(context).size.shortestSide * 0.0018
            : 1,
      ),
      title: 'Zhesa',
      debugShowCheckedModeBanner: false,
      translations: LocaleString(),
      locale: const Locale('dz', 'BT'),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange[500],
        primaryColorLight: Colors.deepOrange[300],
        primaryColorDark: const Color(0x00c41c00),
        secondaryHeaderColor: Colors.orange[500],
        fontFamily: 'Uchen', //Jomolhari, Rinzin, Wangdi, Uchen, Joyig
        // fontFamily: 'font'.tr,
        //S — Light Orange #ffc947
        //s-Dark Oranhgr ##c66900
      ),
      home: const HomePage(),
    );
  }
}
