import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/Home/home.dart';
import 'package:gpsglobe/shimmer.dart';
import 'package:gpsglobe/splashscreen.dart';

class current1 extends StatefulWidget {
  const current1({super.key});

  @override
  State<current1> createState() => _current1State();
}

class _current1State extends State<current1> {
  TextEditingController _searchController = TextEditingController();
  bool empty = false;

  @override
  void initState() {
    super.initState();
    homedatacoming();
  }

  homedatacoming() async {
    Homepagedatasmap = await Api.homepagedata();
    filteredData = Homepagedatasmap;
    setState(() {});
  }

  final FocusNode _textFocusNode = FocusNode();
  List<String> Vehiclesearchlist = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color.fromARGB(255, 185, 86, 86),
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 40,
              margin:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                // color: Colors.grey[200],
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                      child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by vehicle number',
                    ),
                    onChanged: (value) {
                      // Call setState to update the UI with the filtered data
                      filteredData = Homepagedatasmap;
                      setState(() {
                        filteredData = Homepagedatasmap.where((data) =>
                            data['vehicleNo']
                                .toLowerCase()
                                .contains(value.toLowerCase())).toList();
                        empty = true;
                      });
                    },
                  )),
                ],
              ),
            ),
            Expanded(
              child: empty == false && filteredData.isEmpty
                  ? MyListView()
                  : RefreshIndicator(
                      onRefresh: () {
                        _searchController.clear();
                        return homedatacoming();
                      },
                      child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                         
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: impo2(
                              vehid: filteredData[index]["vehicleId"],
                              latitude: filteredData[index]["latitude"],
                              longitude: filteredData[index]["longitude"],
                              vid: filteredData[index]["vid"].toString(),
                              vehiclecondition:
                                  filteredData[index]["ignition"].toString() ==
                                              "Off" &&
                                          filteredData[index]["speed"] == 0
                                      ? "Stopped"
                                      : filteredData[index]["ignition"]
                                                      .toString() ==
                                                  "On" &&
                                              filteredData[index]["speed"] == 0
                                          ? "idle"
                                          : "Live",
                              todaykm: filteredData.length == todaykmlist.length
                                  ? todaykmlist[index]['totalDistance']
                                  : "Today 0 Km",
                              // Stoppage: myList1[index]['statusSince'],
                              todaykilometer:
                                  filteredData[index]["todaytotkm"].toString(),
                              colortext: filteredData[index]["status"]
                                          .toString() ==
                                      "Idle"
                                  ? Colors.yellow[800]
                                  : filteredData[index]["status"].toString() ==
                                          "Stopped"
                                      ? Colors.red
                                      : filteredData[index]["status"]
                                                  .toString() ==
                                              "Live"
                                          ? Colors.green
                                          : Colors.black,
                              batterypercentage: filteredData[index]
                                  ["battery_Percentage"],
                              ignition:
                                  filteredData[index]["ignition"].toString(),
                              vehiclenum:
                                  filteredData[index]["vehicleNo"].toString(),
                              speedkm: filteredData[index]["speed"],
                              location: filteredData[index]["finallocation"]
                                  .toString(),

                              date: filteredData[index]["date"].toString(),
                              isbatteryconnected: filteredData[index]
                                      ["isBatteryConnected"]
                                  .toString(),
                              color: filteredData[index]["status"].toString() ==
                                      "Idle"
                                  ? Colors.yellow[800]
                                  : filteredData[index]["status"].toString() ==
                                          "Stopped"
                                      ? Colors.red
                                      : filteredData[index]["status"]
                                                  .toString() ==
                                              "Live"
                                          ? Colors.green
                                          : Colors.black,
                              installationdate: filteredData[index]
                                      ["installationDate"]
                                  .toString(),
                              expiringdate:
                                  filteredData[index]["expiryDate"].toString(),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
