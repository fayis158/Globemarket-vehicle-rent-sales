import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/splashscreen.dart';


class Vehicle_on_off_count extends StatefulWidget {
  @override
  State<Vehicle_on_off_count> createState() => _Vehicle_on_off_countState();
}

class _Vehicle_on_off_countState extends State<Vehicle_on_off_count> {
  // const Vehicle_on_off_count({super.key});
  bool hideshow = true;

  String? selectedDrop;
  late DateTime datetime;
  DateTime datetime2 = DateTime.now();

  String? selectedVId;
  List<String> vehiclenum = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vidfordropdown();
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    datetime = todayStart;
  }

  vidfordropdown() {
    for (var i = 0; i < Homepagedatasmap.length; i++) {
      vehiclenum.add(Homepagedatasmap[i]["vehicleNo"]);

    }
  }

  tryag() {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
    final formattedDate2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
    Api.vehicleonoffcount(
      selectedVId,
      formattedDate,
      formattedDate2,
    );
  }

  void showHelloWorldDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  int totalgeoincount = 0;
  int totalgeooutcount = 0;
  int totalignitiononcount = 0;
  int totalignitionoffcount = 0;
  List outputList = [];

  @override
  Widget build(BuildContext context) {
    final hours = datetime.hour.toString().padLeft(2, "0");
    final minutes = datetime.minute.toString().padLeft(2, "0");
    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      appBar: AppBar(
        title: Text("vehicleonoffcountr".tr()),
        actions: [
          vehicleonoffcountlist.length != 0
              ? IconButton(
                  onPressed: () {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
                    final formattedDate2 =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);

                    Api.emailsenddocument(
                        selectedVId, "8", formattedDate, formattedDate2, "0");

                    showHelloWorldDialog(context, email["summaryData"]);
                  },
                  icon: Icon(Icons.download))
              : SizedBox(),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.home))
        ],
      ),
      body: FutureBuilder(
        future: tryag(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            // Return the UI for the page here
            return Column(
              children: [
                SizedBox(
                  height: hideshow ? null : 0,
                  width: double.infinity,
                  // color: Color.fromARGB(255, 115, 113, 255),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: width(context),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: DropdownButtonFormField<String>(
                                  // isDense: false,
                                  enableFeedback: false,
                                  // dropdownColor: Colors.green,
                                  value: selectedDrop,
                                  items: vehiclenum.map((e) {
                                    return DropdownMenuItem(
                                        onTap: () {
                                          setState(() {
                                            selectedDrop = e;
                                            selectedVId =
                                                Homepagedatasmap.firstWhere(
                                                    (vehicle) =>
                                                        vehicle['vehicleNo'] ==
                                                        selectedDrop)['vid'];
                                          });
                                        },
                                        value: e,
                                        child: Text(e));
                                  }).toList(),
                                  onChanged: (val) {}),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(context) * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              SizedBox(
                                width: width(context) * 0.5,
                                child: Text("startdatetime".tr(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 98, 145, 98),
                                        fontWeight: FontWeight.bold)),
                              ),
                              MaterialButton(
                                minWidth: width(context) * 0.5,
                                height: 55,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                onPressed: pickDateTime,
                                child: Text(
                                  "${datetime.day}/${datetime.month}/${datetime.year}   ${datetime.hour}: ${datetime.minute}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 22, 21, 21)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                //  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                width: width(context) * 0.5,
                                child: Text("enddatetime".tr(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 98, 145, 98),
                                        fontWeight: FontWeight.bold)),
                              ),
                              MaterialButton(
                                minWidth: width(context) * 0.5,
                                height: 55,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                onPressed: pickDateTime2,
                                child: Text(
                                  "${datetime2.day}/${datetime2.month}/${datetime2.year}   ${datetime2.hour}: ${datetime2.minute}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 22, 21, 21)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // SizedBox(height: 6,),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                vehicleonoffcountlist.clear();
                              });
                            },
                            minWidth: width(context) / 2,
                            height: 55,
                            child: Text("Clear"),
                            color: Color.fromARGB(255, 240, 107, 107),
                          ),
                          MaterialButton(
                            minWidth: width(context) / 2,
                            height: 55,
                            color: const Color.fromARGB(255, 141, 247, 255),
                            child: const Text(
                              "Search",
                              style: TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              

                              final formattedDate =
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(datetime);
                              final formattedDate2 =
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(datetime2);
                              Api.vehicleonoffcount(
                                selectedVId,
                                formattedDate,
                                formattedDate2,
                              );

                              setState(() {
                                // geoin();
                                tryag();
                              });
                              // getcount();
                              if (datetime2.isBefore(datetime)) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const AlertDialog(
                                      title: Text("error"),
                                      content: Text(
                                          "Start Date can't be greater than End Date"),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 28,
                  height: 30,
                  color: hideshow
                      ? Colors.red
                      : const Color.fromARGB(255, 8, 177, 65),
                  child: hideshow
                      ? Text(
                          "hideinputarea".tr(),
                          style: const TextStyle(color: Colors.white),
                        )
                      : Text(
                          "showinputarea".tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    setState(() {
                      hideshow = !hideshow;
                    });
                  },
                ),
                Expanded(
                  child:
                      //  ListView.builder(
                      //   itemCount: outputList.length,
                      //   itemBuilder: (context, index) {
                      //     return ListTile(
                      //       title: Text(
                      //           "vehicle count: ${outputList[index]["vehicle count"]}, total count: ${outputList[index]["total count"]}"),
                      //     );
                      //   },
                      // ),
                      vehicleonoffcountlist.isEmpty
                          ? ListView.builder(
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return SizedBox();
                              },
                            )
                          : ListView.builder(
                              itemCount: vehicleonoffcountlist.length,
                              itemBuilder: (context, index) {
                                int totalgeoincount = 0;
                                for (int i = 0; i <= index; i++) {
                                  totalgeoincount += vehicleonoffcountlist[i]
                                      ["geoFenceInCount"] as int;
                                }

                                int totalgeooutcount = 0;
                                for (int i = 0; i <= index; i++) {
                                  totalgeooutcount += vehicleonoffcountlist[i]
                                      ["geoFenceOutCount"] as int;
                                }

                                int totalignitiononcount = 0;
                                for (int i = 0; i <= index; i++) {
                                  totalignitiononcount +=
                                      vehicleonoffcountlist[i]
                                          ["ignitionOnCount"] as int;
                                }

                                int totalignitionoffcount = 0;
                                for (int i = 0; i <= index; i++) {
                                  totalignitionoffcount +=
                                      vehicleonoffcountlist[i]
                                          ["ignitionOffCount"] as int;
                                }

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Vehicle_on_off(
                                        vehiclenumber:
                                            vehicleonoffcountlist[index]
                                                ["vehicleNo"],
                                        geoincount: vehicleonoffcountlist[index]
                                            ["geoFenceInCount"],
                                        totalgeoincount: totalgeoincount,
                                        geooutcount:
                                            vehicleonoffcountlist[index]
                                                ["geoFenceOutCount"],
                                        totalgeooutcount: totalgeooutcount,
                                        ignitiononcount:
                                            vehicleonoffcountlist[index]
                                                ["ignitionOnCount"],
                                        totalignitiononcount:
                                            totalignitiononcount,
                                        ignitionoffcount:
                                            vehicleonoffcountlist[index]
                                                ["ignitionOffCount"],
                                        totalignitionoffcount:
                                            totalignitionoffcount,
                                        date: vehicleonoffcountlist[index]
                                            ["date"],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  Future pickDateTime2() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newdateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.datetime2 = newdateTime;
      if (datetime2.isBefore(datetime)) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("error"),
              content: Text("msgabtsedate".tr()),
            );
          },
        );
      }
    });
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newdateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.datetime = newdateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));
}

class Vehicle_on_off extends StatelessWidget {
  String vehiclenumber;
  int geoincount;
  int geooutcount;
  int ignitiononcount;
  int ignitionoffcount;
  String date;
  int totalgeoincount;
  int totalgeooutcount;
  int totalignitiononcount;
  int totalignitionoffcount;
  Vehicle_on_off(
      {super.key,
      required this.vehiclenumber,
      required this.geoincount,
      required this.geooutcount,
      required this.ignitiononcount,
      required this.ignitionoffcount,
      required this.date,
      required this.totalgeoincount,
      required this.totalgeooutcount,
      required this.totalignitiononcount,
      required this.totalignitionoffcount});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: height(context) * 0.3,
      width: width(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 114, 114, 114).withOpacity(0.1),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: const Color.fromARGB(255, 121, 121, 121).withOpacity(0.4),
            offset: const Offset(6.0, 6.0),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: Text(
                        "vehiclenumber".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(vehiclenumber)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Geo-Fence-In Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(geoincount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Total Geo-Fence-In Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(totalgeoincount.toString())
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Geo-Fence-Out Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(geooutcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Total Geo-Fence-Out Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(totalgeooutcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Ignition-On Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(ignitiononcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Total Ignition-On Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(totalignitiononcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Ignition-Off Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(ignitionoffcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Total Ignition-Off Count",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(totalignitionoffcount.toString())
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  SizedBox(
                      width: width(context) * 0.4,
                      child: Text(
                        "date".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(": "),
                  Text(date)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
            ]),
      ),
    );
  }
}
