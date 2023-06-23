import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/splashscreen.dart';

class Distance_periodic_report extends StatefulWidget {
  @override
  State<Distance_periodic_report> createState() =>
      _Distance_periodic_reportState();
}

class _Distance_periodic_reportState extends State<Distance_periodic_report> {
  // const Distance_periodic_report({super.key});
  bool hideshow = true;

  String? selectedDrop;

  late DateTime datetime;
  DateTime datetime2 = DateTime.now();

  String? selectedVId;
  List<String> vehiclenum = [];

  @override
  void initState() {

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
    Api.distanceperiodicreport(
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


  @override
  Widget build(BuildContext context) {
    final hours = datetime.hour.toString().padLeft(2, "0");
    final minutes = datetime.minute.toString().padLeft(2, "0");
    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      appBar: AppBar(
        title: Text("distanceperiodicr".tr()),
        actions: [
           distanceperiodicreportlist.length!=0?   IconButton(onPressed: () {
             final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
                    final formattedDate2 =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
             Api.emailsenddocument(selectedVId, "10", formattedDate,
                        formattedDate2, "0");
                    showHelloWorldDialog(context, email["summaryData"]);

          }, icon: const Icon(Icons.download)):const SizedBox(),
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
                              Container(
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
                                distanceperiodicreportlist.clear();
                              });
                            },
                            minWidth: width(context) / 2,
                            height: 55,
                            color: const Color.fromARGB(255, 240, 107, 107),
                            child: const Text("Clear"),
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
                                  DateFormat('yyyy-MM-dd 00:00:00')
                                      .format(datetime);
                              final formattedDate2 =
                                  DateFormat('yyyy-MM-dd HH:mm:ss')
                                      .format(datetime2);
                              Api.distanceperiodicreport(
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
                    itemCount: distanceperiodicreportlist.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            periodic(
                              vehiclenumber: distanceperiodicreportlist[index]
                                  ["vehilceNo"],
                              fromdate: distanceperiodicreportlist[index]
                                  ["fromDate"],
                              todate: distanceperiodicreportlist[index]
                                  ["toDate"],
                              distance: distanceperiodicreportlist[index]
                                  ["distence"],
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

class periodic extends StatelessWidget {
  String vehiclenumber;
  String fromdate;
  String todate;
  String distance;
  periodic(
      {super.key,
      required this.vehiclenumber,
      required this.fromdate,
      required this.todate,
      required this.distance});

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
                  Text(vehiclenumber)
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
                        "fromdate".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(fromdate)
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
                        "todate".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(todate)
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
                        "distanceinkms".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                  const Text(":"),
                  Text(distance)
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
