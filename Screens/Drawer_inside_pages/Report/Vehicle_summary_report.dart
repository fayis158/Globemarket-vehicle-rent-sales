import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/splashscreen.dart';

import '../../../Api/api.dart';

class Vehicle_summary_report extends StatefulWidget {
  @override
  State<Vehicle_summary_report> createState() => _Vehicle_summary_reportState();
}

class _Vehicle_summary_reportState extends State<Vehicle_summary_report> {
  // const Vehicle_on_off_count({super.key});
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
    Api.vehiclesummaryreport(
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
        title: Text("vehicleSummaryr".tr()),
        actions: [
          vehiclesummaryreportlist.length != 0
              ? IconButton(
                  onPressed: () {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
                    final formattedDate2 =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
                    Api.emailsenddocument(
                        selectedVId, "4", formattedDate, formattedDate2, "0");
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
                                  "${datetime.day}/${datetime.month}/${datetime.year}  ${datetime.hour}: ${datetime.minute}",
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
                                  "${datetime2.day}/${datetime2.month}/${datetime2.year}  ${datetime2.hour}: ${datetime2.minute}",
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
                                vehiclesummaryreportlist.clear();
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
                              Api.vehiclesummaryreport(
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
                  child: vehiclesummaryreportlist.isEmpty
                      ? ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return const SizedBox();
                          },
                        )
                      : ListView.builder(
                          itemCount: vehiclesummaryreportlist.length,
                          itemBuilder: (context, index) {
                            Duration _parseDuration(String durationString) {
                              List<String> parts = durationString.split(':');
                              int hours = int.parse(parts[0]);
                              int minutes = int.parse(parts[1]);
                              int seconds = int.parse(parts[2]);
                              return Duration(
                                  hours: hours,
                                  minutes: minutes,
                                  seconds: seconds);
                            }

                            Duration totalDuration = Duration.zero;
                            Duration totalDurationtravel = Duration.zero;
                            Duration totaldurationstoppage = Duration.zero;

                            for (int i = 0; i <= index; i++) {
                              String durationString =
                                  vehiclesummaryreportlist[i]["idelTime"] ==
                                          null
                                      ? "0 m"
                                      : vehiclesummaryreportlist[i]["idelTime"];

                              String timeString = durationString;
                              List<String> timeParts = timeString.split(" ");
                              int timeValue = int.parse(timeParts[0]);
                              Duration duration2 = Duration(minutes: timeValue);
                              String formattedTime = duration2
                                  .toString()
                                  .split('.')
                                  .first
                                  .padLeft(8, "0");
                              var formattedTimeduration = formattedTime;

                              Duration duration =
                                  _parseDuration(formattedTimeduration);
                              totalDuration += duration;
                            }
                            String formattedidletime =
                                totalDuration.toString().split('.').first;

                            //totaltravel tym
                            // var traveltime2 = "00:00:00";
                            var traveltime2;

                            for (int i = 0; i <= index; i++) {
                              if (vehiclesummaryreportlist.isNotEmpty &&
                                  vehiclesummaryreportlist[i]["travelTime"] !=
                                      null) {
                                var timeString = vehiclesummaryreportlist[i]
                                            ["travelTime"] ==
                                        null
                                    ? "00:00:00"
                                    : vehiclesummaryreportlist[i]["travelTime"];
                                List<String> timeParts = timeString.split(' ');

                                int hours = 0;
                                int minutes = 0;

                                for (int i = 0; i < timeParts.length; i += 2) {
                                  if (timeParts[i + 1] == "h") {
                                    hours = int.parse(timeParts[i]);
                                  } else if (timeParts[i + 1] == "m") {
                                    minutes = int.parse(timeParts[i]);
                                  }
                                }

                                Duration duration =
                                    Duration(hours: hours, minutes: minutes);
                                traveltime2 = duration
                                    .toString()
                                    .split('.')
                                    .first
                                    .padLeft(8, "0");
                                var formattedTimedurationtravel = traveltime2;

                                Duration durationtravel =
                                    _parseDuration(formattedTimedurationtravel);
                                totalDurationtravel += durationtravel;
                              }
                            }
                            String totaltraveltym =
                                totalDurationtravel.toString().split('.').first;

                            //total stoppage time
                            var stoppagetime;

                            for (int i = 0; i <= index; i++) {
                              if (vehiclesummaryreportlist.isNotEmpty &&
                                  vehiclesummaryreportlist[i]["stopageTime"] !=
                                      null) {
                                var timeString = vehiclesummaryreportlist[i]
                                            ["stopageTime"] ==
                                        null
                                    ? "00:00:00"
                                    : vehiclesummaryreportlist[i]
                                        ["stopageTime"];
                                List<String> timeParts = timeString.split(' ');

                                int hours = 0;
                                int minutes = 0;

                                for (int i = 0; i < timeParts.length; i += 2) {
                                  if (timeParts[i + 1] == "h") {
                                    hours = int.parse(timeParts[i]);
                                  } else if (timeParts[i + 1] == "m") {
                                    minutes = int.parse(timeParts[i]);
                                  }
                                }

                                Duration duration =
                                    Duration(hours: hours, minutes: minutes);
                                stoppagetime = duration
                                    .toString()
                                    .split('.')
                                    .first
                                    .padLeft(8, "0");
                                var formattedTimedurationstopped = stoppagetime;

                                Duration durationtravel = _parseDuration(
                                    formattedTimedurationstopped);
                                totaldurationstoppage += durationtravel;
                              }
                            }
                            String totalstoppagetym = totaldurationstoppage
                                .toString()
                                .split('.')
                                .first;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  vehiclesummary(
                                    vehiclenum: vehiclesummaryreportlist[index]
                                        ["vehicleNo"],
                                    startdate: vehiclesummaryreportlist[index]
                                            ["startDate"] ??
                                        "",
                                    fromlocation:
                                        vehiclesummaryreportlist[index]
                                                ["startLocation"] ??
                                            "",
                                    endlocation: vehiclesummaryreportlist[index]
                                            ["endLocation"] ??
                                        "",
                                    enddate: vehiclesummaryreportlist[index]
                                            ["lastDate"] ??
                                        "",
                                    distanceinkm:
                                        vehiclesummaryreportlist[index]
                                                ["distance_km"] ??
                                            "",
                                    // idletime: vehiclesummaryreportlist[index]
                                    //         ["idelTime"] ??
                                    //     "0 m",
                                    totalidletime: formattedidletime,
                                    traveltime: vehiclesummaryreportlist[index]
                                            ["travelTime"] ??
                                        "",
                                    totaltraveltime: totaltraveltym.toString(),
                                    stopagetime: vehiclesummaryreportlist[index]
                                            ["stopageTime"] ??
                                        "",
                                    totalstopagetime: totalstoppagetym,
                                    maxspeed: vehiclesummaryreportlist[index]
                                                ["maxSpeed"] ==
                                            null
                                        ? ""
                                        : vehiclesummaryreportlist[index]
                                                ["maxSpeed"]
                                            .toString(),
                                    overspeedcount:
                                        vehiclesummaryreportlist[index]
                                                ["overSpeedCount"] ??
                                            "",
                                    date: vehiclesummaryreportlist[index]
                                            ["reportDate"] ??
                                        "",

                                    //2nd try

                                    // vehiclenum: vehiclesummaryreportlist[index]
                                    //         ["vehicleNo"] ??
                                    //     "",
                                    // startdate: vehiclesummaryreportlist[index]
                                    //             ["startDate"] ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["startDate"]
                                    //         .toString(),
                                    // fromlocation:
                                    //     vehiclesummaryreportlist[index]
                                    //                     ["startLocation"]
                                    //                 .toString() ==
                                    //             "null"
                                    //         ? ""
                                    //         : vehiclesummaryreportlist[index]
                                    //                 ["startLocation"]
                                    //             .toString(),
                                    // endlocation: vehiclesummaryreportlist[index]
                                    //                 ["endLocation"]
                                    //             .toString() ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["endLocation"]
                                    //         .toString(),
                                    // enddate: vehiclesummaryreportlist[index]
                                    //                 ["lastDate"]
                                    //             .toString() ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["lastDate"]
                                    //         .toString(),
                                    // distanceinkm:
                                    //     vehiclesummaryreportlist[index]
                                    //                     ["distance_km"]
                                    //                 .toString() ==
                                    //             "null"
                                    //         ? ""
                                    //         : vehiclesummaryreportlist[index]
                                    //                 ["distance_km"]
                                    //             .toString(),
                                    idletime: vehiclesummaryreportlist[index]
                                                    ["idelTime"]
                                                .toString() ==
                                            "null"
                                        ? "0 m"
                                        : vehiclesummaryreportlist[index]
                                            ["idelTime"],
                                    // totalidletime: "1",
                                    // traveltime: vehiclesummaryreportlist[index]
                                    //                 ["travelTime"]
                                    //             .toString() ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["travelTime"]
                                    //         .toString(),
                                    // totaltraveltime: "2",
                                    // stopagetime: vehiclesummaryreportlist[index]
                                    //                 ["stopageTime"]
                                    //             .toString() ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["stopageTime"]
                                    //         .toString(),
                                    // totalstopagetime: "3",
                                    // maxspeed: vehiclesummaryreportlist[index]
                                    //             ["maxSpeed"] ==
                                    //         null
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["maxSpeed"]
                                    //         .toString(),
                                    // overspeedcount:
                                    //     vehiclesummaryreportlist[index]
                                    //                     ["overSpeedCount"]
                                    //                 .toString() ==
                                    //             "null"
                                    //         ? ""
                                    //         : vehiclesummaryreportlist[index]
                                    //                 ["overSpeedCount"]
                                    //             .toString(),
                                    // date: vehiclesummaryreportlist[index]
                                    //                 ["reportDate"]
                                    //             .toString() ==
                                    //         "null"
                                    //     ? ""
                                    //     : vehiclesummaryreportlist[index]
                                    //             ["reportDate"]
                                    //         .toString(),
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

class vehiclesummary extends StatefulWidget {
  String vehiclenum;
  String startdate;
  String fromlocation;
  String endlocation;
  String enddate;
  String distanceinkm;
  String idletime;
  String totalidletime;
  String traveltime;
  String totaltraveltime;
  String stopagetime;
  String totalstopagetime;
  String maxspeed;
  String overspeedcount;
  String date;

  vehiclesummary(
      {super.key,
      required this.vehiclenum,
      required this.startdate,
      required this.date,
      required this.distanceinkm,
      required this.enddate,
      required this.endlocation,
      required this.fromlocation,
      required this.idletime,
      required this.maxspeed,
      required this.overspeedcount,
      required this.stopagetime,
      required this.totalidletime,
      required this.totalstopagetime,
      required this.totaltraveltime,
      required this.traveltime});

  @override
  State<vehiclesummary> createState() => _vehiclesummaryState();
}

class _vehiclesummaryState extends State<vehiclesummary> {
  // var traveltime2 = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cvonvert();
    // converttraveltot(widget.traveltime);
  }

  cvonvert() {
    if (widget.idletime != null) {
      int durationInSeconds =
          int.parse(widget.idletime.replaceAll(RegExp('[^0-9]'), '')) *
              60; // Convert to seconds
      Duration duration =
          Duration(seconds: durationInSeconds); // Create a Duration object
      String formattedDuration = duration
          .toString()
          .split('.')
          .first
          .padLeft(8, "0"); // Format the Duration object to HH:MM:SS
      
      widget.idletime = formattedDuration;
    } else {
      widget.idletime = "";
    }
  }


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
                const Text(":"),
                Text(widget.vehiclenum)
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
                      "startdate".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.startdate)
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  height: height(context) * 0.05,
                  width: width(context) * 0.4,
                  // color: Colors.red,
                  child: SizedBox(
                      width: width(context) * 0.4,
                      child: Text(
                        "fromlocation".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                    height: height(context) * 0.05, child: const Text(":")),
                SizedBox(
                    height: height(context) * 0.05,
                    width: width(context) * 0.4,
                    // color: Colors.red,
                    child: Text(widget.fromlocation))
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
                      "enddate".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.enddate)
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  height: height(context) * 0.05,
                  width: width(context) * 0.4,
                  // color: Colors.red,
                  child: SizedBox(
                      width: width(context) * 0.4,
                      child: Text(
                        "endloc".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(
                    height: height(context) * 0.05, child: const Text(":")),
                SizedBox(
                    height: height(context) * 0.05,
                    width: width(context) * 0.4,
                    // color: Colors.red,
                    child: Text(widget.endlocation))
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
                      "distanceinkms".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.distanceinkm)
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
                      "idletime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.idletime)
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
                      "totalidletime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.totalidletime)
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
                      "traveltime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.traveltime)
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
                      "totaltraveltime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.totaltraveltime)
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
                      "stoppagetime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.stopagetime)
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
                      "totalstoppagetime".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.totalstopagetime)
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
            // Row(
            //   children: [
            //     Container(
            //         width: width(context) * 0.4,
            //         child: Text(
            //           "totalduration".tr(),
            //           style: TextStyle(fontWeight: FontWeight.bold),
            //         )),
            //     const Text(":"),
            //     const Text("05:15:00")
            //   ],
            // ),
            // SizedBox(
            //   height: height(context) * 0.01,
            // ),
            Row(
              children: [
                SizedBox(
                    width: width(context) * 0.4,
                    child: Text(
                      "maxspeed".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.maxspeed)
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
                      "overspeedcount".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.overspeedcount)
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
                const Text(":"),
                Text(widget.date)
              ],
            ),
            SizedBox(
              height: height(context) * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
