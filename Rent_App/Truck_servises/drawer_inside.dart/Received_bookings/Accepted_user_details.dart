import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Home_page/Home_page.dart';
import '../../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../../global/global.dart';
import '../../Supply/Supply.dart';

class Accepteduserdetails extends StatelessWidget {
  Accepteduserdetails(
      {super.key,
      required this.name,
      required this.mobile,
      required this.accepteddate,
      required this.whatsappnum});
  String name;
  String mobile;
  String accepteddate;
  String whatsappnum;

  void openWhatsApp() async {
    String url = 'https://wa.me/$mobile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }

  @override
  Widget build(BuildContext context) {
    showmessage() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: SizedBox(
              width: 260.0,
              height: 180.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Globe GPS",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Text(
                        "Notice : - ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const Text("Buy GPS To Access our GPS services"),
                      GestureDetector(
                        onTap: () {
                          launch("tel://87922897640");
                        },
                        child: const Text(
                          "87922897640",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          launch("tel://9148998994");
                        },
                        child: const Text(
                          "9148998994",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("--> Click --> "),
                          const SizedBox(
                            width: 9,
                          ),
                          TextButton(
                            child: const Text('Buy GPS'),
                            onPressed: () {
                              Get.back();
                              Get.to(() => const Buy_GPS());
                            },
                          ),
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Get.back();
                              // Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 36, 43),
        title: const Text("Accepted User Details"),
        actions: [
          IconButton(
              onPressed: () {
                finalUid == 0
                    ? showmessage()

                    //  showAlert(
                    //     context, 'Notice', 'Buy GPS To Access our GPS services')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TabBarDemo(),
                        ));
              },
              icon: const Icon(Icons.gps_fixed)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const More(),
                ),
              );
            },
            icon: Image.asset(
              'rentimages/cart.png',
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name : $name",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 21,
            ),
            Text(
              "Mobile Number : $mobile",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 21,
            ),
            Text(
              "Accepted Date : $accepteddate",
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130, // set the desired width
                  // set the desired height
                  child: MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      launch("tel://$mobile");
                    },
                    child: const Text(
                      "call",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                SizedBox(
                  width: 130,
                  child: MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      openWhatsApp();
                    },
                    child: const Text(
                      "WhatsApp",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
