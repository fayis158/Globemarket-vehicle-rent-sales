import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/splashscreen.dart';


class geofence_alert_report extends StatefulWidget {
  @override
  State<geofence_alert_report> createState() => _geofence_alert_reportState();
}

class _geofence_alert_reportState extends State<geofence_alert_report> {
  // const geofence_alert_report({super.key});
  bool hideshow = true;
  // List<String> days = ['KL18AA0001', 'KL18AA0002', 'KL18AA0003', '2656'];
  String? selectedDrop;
  late DateTime datetime;
  DateTime datetime2 = DateTime.now();
  List<String> vehiclenum = [];

  @override
  void initState() {
    super.initState();
    vidfordropdown();
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    datetime = todayStart;
  }

  String? selectedVId;
// String selectedVehicleId2 = Homepagedatasmap.firstWhere((vehicle) => vehicle['vehicle_number'] == selectedDrop)['vid'];

  vidfordropdown() {
    for (var i = 0; i < Homepagedatasmap.length; i++) {
      vehiclenum.add(Homepagedatasmap[i]["vehicleNo"]);
      
    }
  }

  tryag() {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
    final formattedDate2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
    Api.geofencereport(
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
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final hours = datetime.hour.toString().padLeft(2, "0");
    final minutes = datetime.minute.toString().padLeft(2, "0");

    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      appBar: AppBar(
        title: Text("geofencealertr".tr()),
        actions: [
          geofencereportlist.length != 0
              ? IconButton(
                  onPressed: () {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
                    final formattedDate2 =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
                    Api.emailsenddocument(
                        selectedVId, "7", formattedDate, formattedDate2, "0");
                    showHelloWorldDialog(context, email["summaryData"]);
                  },
                  icon: const Icon(Icons.download))
              : const SizedBox(),
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
                              Container(
                                width: width(context) * 0.5,
                                child: Text(" startdatetime".tr(),
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
                              Container(
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
                                  "${datetime2.day}/${datetime2.month}/${datetime2.year}  ${datetime2.hour}: ${datetime2.minute}",
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 22, 21, 21)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                geofencereportlist.clear();
                              });
                            },
                            minWidth: width(context) / 2,
                            height: 55,
                            child: const Text("Clear"),
                            color: const Color.fromARGB(255, 240, 107, 107),
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

                              Api.geofencereport(
                                selectedVId,
                                formattedDate,
                                formattedDate2,
                              );
                              setState(() {
                                tryag();
                              });

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
                              //        setState(() {
                              //   hideshow = !hideshow;
                              // });
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
                  child: ListView.builder(
                    itemCount: geofencereportlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Daywise(
                              vehiclenum: geofencereportlist[index]
                                  ["vehicleNo"],
                              geofenceName: geofencereportlist[index]
                                  ["geofenceName"],
                              inTime: geofencereportlist[index]["inTime"],
                              outTime: geofencereportlist[index]["outTime"],
                              location: geofencereportlist[index]["location"],
                              duration: geofencereportlist[index]["duriation"],
                            )
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

class Daywise extends StatelessWidget {
  String vehiclenum;
  String geofenceName;
  String inTime;
  String outTime;
  String location;
  String duration;

  Daywise(
      {super.key,
      required this.vehiclenum,
      required this.geofenceName,
      required this.inTime,
      required this.outTime,
      required this.location,
      required this.duration});

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
                  Container(
                      width: width(context) * 0.4,
                      child: Text(
                        "vehiclenumber".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(vehiclenum)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  Container(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Geo fence name",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(geofenceName)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  Container(
                      width: width(context) * 0.4,
                      child: Text(
                        "location".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(location)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  Container(
                      width: width(context) * 0.4,
                      child: const Text(
                        "InTime",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(inTime)
                ],
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Row(
                children: [
                  Container(
                      width: width(context) * 0.4,
                      child: const Text(
                        "OutTime",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(outTime)
                ],
              ),
              Row(
                children: [
                  Container(
                      width: width(context) * 0.4,
                      child: const Text(
                        "Duration",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(duration)
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
