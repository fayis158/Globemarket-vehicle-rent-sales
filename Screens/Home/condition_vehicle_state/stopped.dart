import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/Home/home.dart';
import 'package:gpsglobe/splashscreen.dart';
import '../../../shimmer.dart';



class current3 extends StatefulWidget {
  const current3({super.key});

  @override
  State<current3> createState() => _current3State();
}

class _current3State extends State<current3> {
  TextEditingController _searchController = TextEditingController();
  bool empty = false;
  @override
  void dispose() {
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
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
              child:empty==false && filteredData.isEmpty
                  ? MyListView()
                  : RefreshIndicator(
                    onRefresh: () {
                      _searchController.clear();
                        return homedatacoming();
                    },
                    child: ListView.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          return filteredData[index]["ignition"].toString() == "Off"
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: impo2(
                                      latitude: filteredData[index]["latitude"],
                                      longitude: filteredData[index]
                                          ["longitude"],
                                      vid: filteredData[index]["vid"].toString(),
                                      vehiclecondition: 'Stopped',
                                      todaykm: filteredData.length ==
                                              todaykmlist.length
                                          ? todaykmlist[index]['totalDistance'].toString()
                                          : "Today 0 Km",
                                     
                                      vehid: filteredData[index]["vehicleId"],
                                      todaykilometer: filteredData[index]
                                          ["todaytotkm"].toString(),
                                      // todaystoppage: filteredData[index]["todaykm"],
                                      colortext: filteredData[index]
                                                      ["ignition"].toString() ==
                                                  "On" &&
                                              filteredData[index]["speed"].toString() == 0
                                          ? Colors.yellow[800]
                                          : Colors.red,
                                      batterypercentage: filteredData[index]
                                          ["battery_Percentage"],
                                      ignition: filteredData[index]["ignition"].toString(),
                                      vehiclenum: filteredData[index]
                                          ["vehicleNo"].toString(),
                                      date: filteredData[index]["date"].toString(),
                                      speedkm: filteredData[index]["speed"],
                                      isbatteryconnected: filteredData[index]
                                          ["isBatteryConnected"].toString(),
                                      location: filteredData[index]
                                          ["finallocation"].toString(),
                                      
                                      color: filteredData[index]["status"].toString() ==
                                              "No GPS"
                                          ? Colors.black
                                          : Colors.red,
                                           installationdate: filteredData[index]["installationDate"].toString(),
                                            expiringdate:filteredData[index]["expiryDate"].toString() ,
                                          ),

                                )
                              : const SizedBox();
                        }),
                  ),
            ),
          ],
        ));
  }
}
