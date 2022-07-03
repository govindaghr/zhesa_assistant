import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zhebsa_assistant/pages/load_favourite.dart';
import 'search_icon.dart';
import 'about_us.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'drawer/drawer_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool isSwitched = false;

  updateLanguage(bool val) {
    Locale locale;
    if (val) {
      locale = const Locale('en', 'US');
    } else {
      locale = const Locale('dz', 'BT');
    }
    Get.updateLocale(locale);
  }

  Future<void> share() async {
    await Share.share(
      'https://play.google.com/store/apps/details?id=com.zhesa.zhebsa_assistant',
      subject: 'Zhesa Learning App',
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarTextStyle: const TextStyle(fontWeight: FontWeight.bold),
        title: Center(
          child: Text(
            'title'.tr,
          ),
        ),
        actions: [
          FlutterSwitch(
            width: 80.0,
            height: 35.0,
            value: isSwitched,
            // valueFontSize: 14,
            activeText: "DZO",
            inactiveText: "ENG",
            inactiveColor: Colors.red.shade600,
            activeColor: Colors.red,
            showOnOff: true,
            onToggle: (val) {
              setState(() {
                isSwitched = val;
                updateLanguage(isSwitched);
              });
            },
          ),
          IconButton(
            onPressed: share,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const MyHeaderDrawer(),
            const SizedBox(
              height: 20.0,
            ),
            ListTile(
              title: Text('favourite'.tr),
              leading: Icon(
                Icons.favorite_border,
                color: Colors.red[500],
              ),
              onTap: () {
                _tabController.index = 0;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('search'.tr),
              leading: Icon(
                Icons.search_rounded,
                color: Colors.red[500],
              ),
              onTap: () {
                _tabController.index = 1;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('about'.tr),
              leading: Icon(
                Icons.info_outline,
                color: Colors.red[500],
              ),
              onTap: () {
                _tabController.index = 2;
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('share'.tr),
              leading: Icon(
                Icons.share,
                color: Colors.red[500],
              ),
              onTap: () {
                share();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.zero,
        height: 70,
        decoration: BoxDecoration(
          // color: Theme.of(context).cardColor,
          color: Colors.amber.shade50,
          // color: Colors.black12,
          border: Border.all(
            color: Colors.amber.shade100,
            // color: Colors.white30,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Center(
          child: TabBar(
            indicatorColor: Colors.orange.shade800,
            indicatorWeight: 3.0,
            labelColor: Colors.deepOrange,
            unselectedLabelColor: Colors.black54,
            labelStyle: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
            controller: _tabController,
            tabs: <Widget>[
              Tab(
                iconMargin: EdgeInsets.zero,
                icon: const Icon(Icons.favorite_outline),
                text: 'favourite'.tr,
              ),
              Tab(
                iconMargin: EdgeInsets.zero,
                icon: const Icon(Icons.search_outlined),
                text: 'search'.tr,
              ),
              Tab(
                iconMargin: EdgeInsets.zero,
                icon: const Icon(Icons.info_outline),
                text: 'about'.tr,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(controller: _tabController, children: const <Widget>[
        // FavouritePage(),
        Favourite(),
        SearchIcon(),
        AboutUs(),
      ]),
    );
  }
}
