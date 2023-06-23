import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Constant.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../Screens/Home_page/Home_page.dart';
import '../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../global/global.dart';
import '../Drawers/Drawers_for_rent.dart/Drawer_for_Rent.dart';

class Sales extends StatefulWidget {
  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  // const  ({super.key});
  String _selectedVehicle = "Truck";

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
          title: const Text("Vehicle for sale"),
          actions: [
            IconButton(
                onPressed: () {
                  finalUid == 0
                      ?  showmessage()
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TabBarDemo(),
                          ));
                },
                icon:const Icon(Icons.gps_fixed)),
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
            DropdownButton<String>(
              alignment: AlignmentDirectional.topEnd,
              value: _selectedVehicle,
              icon: const Icon(Icons.arrow_drop_down_outlined),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (newvalue) {
                setState(() {
                  _selectedVehicle = newvalue!;
                });
              },
              items: <String>[
                'Truck',
                'Car',
                'Bicycle',
                'Bus',
                'container',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: <Widget>[
                      Icon(value == "Car"
                          ? Icons.directions_car
                          : value == "Bicycle"
                              ? Icons.directions_bike
                              : value == "Bus"
                                  ? Icons.directions_bus
                                  : value == "Truck"
                                      ? FontAwesomeIcons.truck
                                      : Icons.train),
                      const SizedBox(width: 10),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Sales_vehicle();
                },
              ),
            ),
          ],
        ));
  }
}

class Sales_vehicle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => const Supply_container(),
        // ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
                height: 200,
                width: width(context),
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(10, 10),
                      blurRadius: 10,
                      spreadRadius: -5,
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-10, -10),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                  color: const Color.fromARGB(152, 192, 216, 245),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 1, bottom: 16, top: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      "Manjunath s ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                MaterialButton(
                                  color: Colors.green,
                                  height: 30,
                                  minWidth: 60,
                                  onPressed: () {
                                    launch("tel://$numberaccrelated");
                                  },
                                  child: const Text(
                                    "Call",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    // color: Colors.red,
                                    height: 40,
                                    width: 66,
                                    child: Image.asset(
                                      "images/car245.png",
                                      fit: BoxFit.fill,
                                    )),
                                const Icon(
                                  Icons.whatsapp,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: width(context) * 0.06,
                                )
                              ],
                            ),
                            // const Icon(FontAwesomeIcons.truck,size: 30,),
                            Row(
                              children: const [
                                Text(
                                  "Tempo ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("   Diesel"),
                                Text("   2012"),
                              ],
                            ),
                            Row(
                              children: const [
                                Text("Status :  "),
                                Text(
                                  "Available",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                Text("Date :  "),
                                Text(
                                  "12/02/2022",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      // color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rs : 450000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 7, 156)),
                            ),
                            const Text(
                              "New Delhi , Delhi, India",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "1000000 Kms",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Icon(
                                  Icons.share,
                                  color: Colors.green,
                                ),
                                Column(
                                  children: const [
                                    Icon(
                                      Icons.share,
                                      color: Colors.green,
                                    ),
                                    Text("Gps")
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
