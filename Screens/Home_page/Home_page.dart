import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Alertpage/Alert_page.dart';
import 'package:gpsglobe/Screens/Home/home.dart';
import 'package:gpsglobe/Screens/Home_page/Drawer/Drawermain.dart';
import 'package:gpsglobe/Screens/more_in_tabbar.dart/More.dart';
import 'package:gpsglobe/Screens/notification.dart/notification.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/splashscreen.dart';
import '../../Birdviewmain/googlemapscreen.dart';
import '../../main.dart';
import '../Gps_payment/Gps_payment1.dart';

List advertaisment = [];
List homepagedataslist = [];
List todaykilom = [];
bool loaded = false;

class TabBarDemo extends StatefulWidget {
  TabBarDemo({
    Key? key,
    this.userid,
  }) : super(key: key);
  final int? userid;
  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  bool isloading = false;
  String? formattedDateTime2;

  homedatacoming() async {
    filteredData = await Api.homepagedata();
    Homepagedatasmap = await Api.homepagedata();
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    String formattedTime = now.toString().split(' ')[1].split('.')[0];
    String formattedDateTime = "$formattedDate $formattedTime";
    formattedDateTime2 = formattedDateTime;
    transaction(formattedDateTime2);
    homedatacoming();
  }

  transaction(var date) {
    Api.transactionsuccess(date);
    setState(() {
      isloading = true;
    });
  }

  buildLanguageDialog1(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: const Text('Choose Your Language'),
            content: SizedBox(
                height: 300,
                width: width(context),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('en', 'US'));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("English")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('hi', 'IN'));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("हिंदी  (Hindi)")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('kn', 'IN'));

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("ಕನ್ನಡ  (Kannada)")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('ta', 'IN'));

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("தமிழ்  (Tamil)")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('gu', 'IN'));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("ગુજરાતી  (Gujarathi)")),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            context.setLocale(const Locale('mr', 'IN'));
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TabBarDemo(),
                            ));
                          });
                        },
                        child: const Text("मराठी  (Marathi)")),
                  ],
                )),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Colors.black,
          child: Drawermain(),
        ),
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSwatch()
                          .copyWith(secondary: Colors.white)),
                  child: const marquee(),
                ),
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.2,
                      child: Text(finalUserName,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const GoogleMapScreenBirdView()));
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 43, 25, 63),
                        size: 35,
                      )),
                  IconButton(
                      onPressed: () {
                        buildLanguageDialog1(context);
                      },
                      icon: const Icon(
                        Icons.language,
                        color: Color.fromARGB(255, 36, 43, 71),
                        size: 33,
                      )),
                  Row(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const notificationclass(),
                            )),
                            child: SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Image.asset(
                                "images/bell1.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: AppBar(
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                elevation: 0,
                bottom: const TabBar(
                  // controller: ,
                  tabs: [
                    Tab(
                        icon: Icon(
                      Icons.home,
                      color: Color.fromARGB(255, 33, 2, 43),
                      size: 35,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.add_alert_rounded,
                      color: Color.fromARGB(255, 33, 2, 43),
                      size: 35,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.currency_rupee,
                      color: Color.fromARGB(255, 33, 2, 43),
                      size: 35,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.shopping_cart,
                      color: Color.fromARGB(255, 33, 2, 43),
                      size: 32,
                    )),
                  ],
                ), // TabBar
              ),
            ), // AppBar
            body: const TabBarView(
              children: [
                Home(),
                Alert2(),
                Gps_payments_pending(),
                More(),
              ],
            ), // TabBarView
          ), // Scaffold
        ), // DefaultTabController
        floatingActionButton: const Floatingaction_button(),
      ),
    ); // MaterialApp
  }
}
