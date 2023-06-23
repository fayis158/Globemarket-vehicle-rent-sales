import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:shimmer/shimmer.dart';
import '../more_in_tabbar.dart/inside_more/Expired_vehicle/expired_vehicle.dart';

class Alert2 extends StatelessWidget {
  const Alert2({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        TabBar(
          indicatorColor: const Color.fromARGB(255, 255, 90, 90),
          labelColor: const Color.fromARGB(255, 255, 77, 77),
          tabs: [
            Tab(text: "expvehicle".tr()),
            Tab(text: "alertmsg".tr()),
          ],
        ),
        Expanded(
            child: TabBarView(
          children: [
            Expired_vehicle(),
            const Alert(),
          ],
        ))
      ]),
    );
  }
}

class Alert extends StatefulWidget {
  const Alert({super.key});

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    alert();
  }

  alert() async {
  
    await Api.Alertmessagepage();
    setState(() {});

  }
 
  @override
  Widget build(BuildContext context) {
    return getalertmessages.isEmpty
        ? ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                  child: ListTile(),
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100);
            })
        : ListView.builder(
            itemCount: getalertmessages.length,
            itemBuilder: (context, index) {
              return getalertmessages.length == 0
                  ? Center(
                      child: Text(
                        "No Alerts Messages",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 247, 247, 247),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("${getalertmessages[index]["vehicleNo"]}"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: double.infinity,
                              child: Text(
                                "${getalertmessages[index]["message"]}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
            },
          );
  }
}
