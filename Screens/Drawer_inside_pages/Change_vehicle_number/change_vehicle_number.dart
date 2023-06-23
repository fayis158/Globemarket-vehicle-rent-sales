import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Change_vehicle_number/Change_here.dart';
import 'package:gpsglobe/Screens/Home_page/Drawer/Drawermain.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:gpsglobe/global/global.dart';

List<String> dropdownlist = [];

class Change_vehicle_number extends StatefulWidget {
  const Change_vehicle_number({super.key});

  @override
  State<Change_vehicle_number> createState() => _Change_vehicle_numberState();
}

class _Change_vehicle_numberState extends State<Change_vehicle_number> {
  String _searchQuery = '';

// Declare a function to filter the Homepagedatasmap list based on the search query
  List _filterList(String query) {
    return Homepagedatasmap.where((map) {
      return map['vehicleNo'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filterList(_searchQuery);
    return Scaffold(
        floatingActionButton: const Floatingaction_button(),
        drawer: const Drawer(
          backgroundColor: Colors.black,
          child: Drawermain(),
        ),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.green,
          title: Text(
            "Home".tr(),
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  //  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Material(
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(Icons.search, color: Colors.grey),
                          Expanded(
                            child: TextField(
                              // textAlign: TextAlign.center,
                              decoration: const InputDecoration.collapsed(
                                hintText: ' Search Vehicle',
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
        body: Column(
          children: [
            const marquee(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Change_v_no(
                    vid: filteredList[index]["vid"],
                    date: filteredList[index]["date"],
                    vehiclenum: filteredList[index]["vehicleNo"],
                    vehid: filteredList[index]["vehicleId"],
                    statuscolor: filteredList[index]["status"],
                    ignition:filteredList[index]["ignition"],

                  );
                },
              ),
            ),
          ],
        ));
  }
}

class Change_v_no extends StatelessWidget {
  var vehiclenum;
  var date;
  var vid;
  var vehid;
  var statuscolor;
  var ignition;
  Change_v_no(
      {super.key,
      required this.vehiclenum,
      required this.date,
      required this.vid,
      required this.vehid,
      required this.statuscolor,
     required this.ignition });

  vehiclelist() async {
    Vehicllistmap = await Api.getvehiclelist();

    for (var i = 0; i < Vehicllistmap.length; i++) {
      vehiclenamelist.add(Vehicllistmap[i]["vehicle"]);
    }
    dropdownlist = vehiclenamelist.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => MyHomePage(),
              // ));
              vehiclelist();

              Change(
                vid: vid,
                control: vehiclenum,
              ).navigateTo(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 241, 241),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: const Offset(-6.0, -6.0),
                    blurRadius: 16.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(6.0, 6.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  vehid == 8
                                      ? Image.asset(
                                          "images/Bull.png",
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                          height: 40,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
                                  vehid == 16
                                      ? Image.asset(
                                          "images/jc.png",
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                          height: 28,
                                        )
                                      : const SizedBox(),
                                  vehid == 10
                                      ? FaIcon(
                                          FontAwesomeIcons.tractor,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 7
                                      ? Image.asset(
                                          "images/van.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 6
                                      ? Image.asset(
                                          "images/jeep.png",
                                          height: 30,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 11
                                      ? Image.asset(
                                          "images/rolller.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 12
                                      ? Image.asset(
                                          "images/tipper.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 13
                                      ? Image.asset(
                                          "images/hitachi1.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 14
                                      ? Image.asset(
                                          "images/tanker.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 15
                                      ? Image.asset(
                                          "images/grader.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 17
                                      ? Image.asset(
                                          "images/crane.png",
                                          height: 50,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  vehid == 4
                                      ? Image.asset(
                                          "images/bike.png",
                                          height: 30,
                                          color: statuscolor == "Stopped"
                                              ? Colors.red
                                              : statuscolor == "Live"
                                                  ? Colors.green
                                                  : statuscolor == "Idle"
                                                      ? Colors.yellow[800]
                                                      : statuscolor == "No GPS"
                                                          ? Colors.black
                                                          : Colors.blue,
                                        )
                                      : const SizedBox(),
                                  Icon(
                                    vehid == 1
                                        ? CupertinoIcons.car_detailed
                                        : vehid == 2
                                            ? FontAwesomeIcons.truck
                                            : vehid == 3
                                                ? Icons.directions_bus_rounded
                                                : vehid == 5
                                                    ? HumanitarianIcons
                                                        .ambulance
                                                    : vehid == 9
                                                        ? Icons.man
                                                        : null,
                                    color: statuscolor == "Stopped"
                                        ? Colors.red
                                        : statuscolor == "Live"
                                            ? Colors.green
                                            : statuscolor == "Idle"
                                                ? Colors.yellow[800]
                                                : statuscolor == "No GPS"
                                                    ? Colors.black
                                                    : Colors.blue,
                                    size: vehid == 1 ||
                                            vehid == 2 ||
                                            vehid == 3 ||
                                            vehid == 5 ||
                                            vehid == 9
                                        ? 30
                                        : 0,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        vehiclenum,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Text(date),
                                      Text(
                                        vid,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 1),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                      child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:  [
                          Text(
                            ignition.toString(),
                            style: const TextStyle(color: Colors.green),
                          ),
                          const Text("Ignition"),
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
