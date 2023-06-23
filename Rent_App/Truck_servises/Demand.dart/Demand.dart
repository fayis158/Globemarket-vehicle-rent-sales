import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../Screens/Home_page/Home_page.dart';
import '../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../global/global.dart';
import '../Drawers/Drawers_for_rent.dart/Drawer_for_Rent.dart';
import '../ScrolldrowpdownLoading.dart';
import 'required.dart';

class Demand extends StatefulWidget {
  @override
  State<Demand> createState() => _DemandState();
}

class _DemandState extends State<Demand> {
  // const booking({super.key});

  bool state = true;

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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                    //  launch("tel://$numberfastag");
                    // SizedBox(
                    //   width: 90,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [],
                    //   ),
                    // ),
                    // const Text(
                    //   "",
                    //   style: TextStyle(fontSize: 15.0),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerForRentPage(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        title: const Text("Demand"),
        actions: [
          IconButton(
              onPressed: () {
                finalUid == 0
                    ? showmessage()
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
      body: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    // width: 150,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          // color: Colors.grey.withOpacity(0.5),
                          color: state == true
                              ? const Color.fromARGB(255, 3, 53, 171)
                                  .withOpacity(0.5)
                              : const Color.fromARGB(255, 161, 163, 162)
                                  .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            // selectedDropdownItem = "0";
                            state = true;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            primary: state == true
                                ? const Color.fromARGB(255, 11, 71, 82)
                                : Colors.grey, // Button background color
                            onPrimary: Colors.black, // Button text color
                          ),
                          child: Text(
                            'Travellers',
                            style: TextStyle(
                                color: state == true
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: state == false
                              ? const Color.fromARGB(255, 18, 25, 144)
                                  .withOpacity(0.5)
                              : const Color.fromARGB(255, 161, 163, 162)
                                  .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            // selectedDropdownItem = "0";
                            state = false;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            primary: state == false
                                ? const Color.fromARGB(255, 11, 71, 82)
                                : const Color.fromARGB(255, 180, 179,
                                    179), // Button background color
                            onPrimary: Colors.black, // Button text color
                          ),
                          child: Text(
                            'Transporters',
                            style: TextStyle(
                                color: state == false
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          state
              ? ScrollableDropdown(
                  onItemSelected: (item) {
                    setState(() {
                      // selectedDropdownItem = item;
                      // print("myb $selectedDropdownItem");
                    });
                  },
                )
              : ScrollableDropdownloading(
                  onItemSelected: (p0) {
                    setState(() {
                      // selectedDropdownItem = p0;
                      // print("myb $selectedDropdownItem");
                    });
                  },
                ),
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, index) {
                return const Required_vehicle();
              },
            ),
          ),
        ],
      ),
    );
  }
}
