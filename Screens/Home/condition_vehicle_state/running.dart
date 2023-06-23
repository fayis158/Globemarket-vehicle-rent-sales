import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/Home/home.dart';
import 'package:gpsglobe/shimmer.dart';
import 'package:gpsglobe/splashscreen.dart';

class current2 extends StatefulWidget {
  @override
  State<current2> createState() => _current2State();
}

class _current2State extends State<current2> {
  bool empty = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    // Search2c.dispose();
  }

  @override
  void initState() {
    super.initState();
    homedatacoming();
  }

  homedatacoming() async {
    Homepagedatasmap = await Api.homepagedata();
    filteredData = Homepagedatasmap;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                        itemBuilder: (context, index) => filteredData[index]
                                    ["ignition"] ==
                                "On"
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: impo2(
                                  latitude: filteredData[index]["latitude"],
                                  longitude: filteredData[index]["longitude"],
                                  vid: filteredData[index]["vid"].toString(),
                                  // index: index,
                                  vehiclecondition: 'Live',
                                  todaykm:
                                      filteredData.length == todaykmlist.length
                                          ? todaykmlist[index]['totalDistance']
                                          : "Today 0 Km",

                                  todaykilometer: filteredData[index]
                                          ["todaytotkm"]
                                      .toString(),
                                  length: filteredData[index]["ignition"]
                                              .toString() ==
                                          "On"
                                      ? filteredData.length
                                      : 0,
                                  colortext: Colors.green,
                                  batterypercentage: filteredData[index]
                                      ["battery_Percentage"],
                                  ignition: filteredData[index]["ignition"]
                                      .toString(),
                                  vehiclenum: filteredData[index]["vehicleNo"]
                                      .toString(),
                                  speedkm: filteredData[index]["speed"],
                                  date: filteredData[index]["date"].toString(),
                                  vehid: filteredData[index]["vehicleId"],
                                  isbatteryconnected: filteredData[index]
                                          ["isBatteryConnected"]
                                      .toString(),
                                  location: filteredData[index]["finallocation"]
                                      .toString(),

                                  color: filteredData[index]["status"]
                                              .toString() ==
                                          "Idle"
                                      ? Colors.yellow[800]
                                      : filteredData[index]["status"]
                                                  .toString() ==
                                              "Live"
                                          ? Colors.green
                                          : Colors.black,
                                  installationdate: filteredData[index]
                                          ["installationDate"]
                                      .toString(),
                                  expiringdate: filteredData[index]
                                          ["expiryDate"]
                                      .toString(),
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
