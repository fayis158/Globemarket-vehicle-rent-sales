import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/splashscreen.dart';


// class Travel_report extends StatefulWidget {
//   @override
//   State<Travel_report> createState() => _Travel_reportState();
// }

// class _Travel_reportState extends State<Travel_report> {
//   // const Travel_report({super.key});
//   bool hideshow = true;
//   List<String> days = ['KL18AA0001', 'KL18AA0002', 'KL18AA0003', '2656'];
//   String selectedDrop = 'KL18AA0001';
//   DateTime datetime = DateTime(2022, 11, 23, 5, 30);
//   DateTime datetime2 = DateTime(2022, 11, 23, 5, 30);

//   String selectedDrop2 = '5 Min';
//   List<String> time = [
//     '5 Min',
//     '10 Min',
//     '15 Min',
//     '30 Min',
//     '45 Min',
//     " 1 Hr",
//     '2 Hrs',
//     '3 Hrs',
//     '4 Hrs',
//     '5 Hrs and above'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final hours = datetime.hour.toString().padLeft(2, "0");
//     final minutes = datetime.minute.toString().padLeft(2, "0");

//     return Scaffold(
//       floatingActionButton: const Floatingaction_button(),
//       appBar: AppBar(
//         title:  Text("travelr".tr()),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(Icons.home))
//         ],
//       ),
//       body: Column(
//         children: [
//           SizedBox(
//             height: hideshow ? null : 0,
//             width: double.infinity,
//             // color: Color.fromARGB(255, 115, 113, 255),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       width: width(context),
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                         ),
//                         child: DropdownButtonFormField<String>(
//                             // isDense: false,
//                             enableFeedback: false,
//                             // dropdownColor: Colors.green,
//                             value: selectedDrop,
//                             items: days.map((e) {
//                               return DropdownMenuItem(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedDrop = e;
//                                     });
//                                   },
//                                   value: e,
//                                   child: Text(e));
//                             }).toList(),
//                             onChanged: (val) {}),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: height(context) * 0.01,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Column(
//                       children: [
//                       Container(
//                           width: width(context)*0.5,
//                            child: Text("startdatetime".tr(),
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 98, 145, 98),
//                                   fontWeight: FontWeight.bold)),
//                          ),
//                         MaterialButton(
//                           minWidth: width(context) * 0.5,
//                           height: 55,
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           onPressed: pickDateTime,
//                           child: Text(
//                             "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}",
//                             style: const TextStyle(
//                                 color: Color.fromARGB(255, 22, 21, 21)),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           width: width(context)*0.5,
//                            child: Text("enddatetime".tr(),
//                               style: TextStyle(
//                                   color: Color.fromARGB(255, 98, 145, 98),
//                                   fontWeight: FontWeight.bold)),
//                          ),
//                         MaterialButton(
//                           minWidth: width(context) * 0.5,
//                           height: 55,
//                           color: const Color.fromARGB(255, 255, 255, 255),
//                           onPressed: pickDateTime2,
//                           child: Text(
//                             "${datetime2.year}/ ${datetime2.month}/${datetime2.day}   ${datetime2.hour}: ${datetime2.minute}",
//                             style: const TextStyle(
//                                 color: Color.fromARGB(255, 22, 21, 21)),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 // SizedBox(height: 6,),
//                 Row(
//                   children: [
//                     Container(
//                       color: Colors.white,
//                       width: width(context) * 0.5,
//                       height: 50,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                         ),
//                         child: DropdownButtonFormField<String>(
//                             // isDense: false,
//                             enableFeedback: false,
//                             // dropdownColor: Colors.green,
//                             value: selectedDrop2,
//                             items: time.map((e) {
//                               return DropdownMenuItem(
//                                   onTap: () {
//                                     setState(() {
//                                       selectedDrop2 = e;
//                                     });
//                                   },
//                                   value: e,
//                                   child: Text(e));
//                             }).toList(),
//                             onChanged: (val) {}),
//                       ),
//                     ),
//                     MaterialButton(
//                       minWidth: width(context) * 0.5,
//                       height: 55,
//                       color: const Color.fromARGB(255, 141, 247, 255),
//                       child: const Text(
//                         "OK",
//                         style: TextStyle(fontSize: 19),
//                       ),
//                       onPressed: () {
//                         if (datetime2.isBefore(datetime)) {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text("error"),
//                                 content: Text(
//                                     "Start Date can't be greater than End Date"),
//                               );
//                             },
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           MaterialButton(
//             minWidth: 28,
//             height: 30,
//             color:
//                 hideshow ? Colors.red : const Color.fromARGB(255, 8, 177, 65),
//             child: hideshow
//                 ?  Text(
//                     "hideinputarea".tr(),
//                     style: TextStyle(color: Colors.white),
//                   )
//                 :  Text(
//                     "showinputarea".tr(),
//                     style: TextStyle(color: Colors.white),
//                   ),
//             onPressed: () {
//               setState(() {
//                 hideshow = !hideshow;
//               });
//             },
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 22,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Travel(),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future pickDateTime2() async {
//     DateTime? date = await pickDate();
//     if (date == null) return;
//     TimeOfDay? time = await pickTime();
//     if (time == null) return;

//     final newdateTime = DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//     setState(() {
//       this.datetime2 = newdateTime;
//         if (datetime2.isBefore(datetime)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: Text("error"),
//               content: Text("msgabtsedate".tr()),
//             );
//           },
//         );
//       }
//     });
//   }

//   Future pickDateTime() async {
//     DateTime? date = await pickDate();
//     if (date == null) return;
//     TimeOfDay? time = await pickTime();
//     if (time == null) return;

//     final newdateTime = DateTime(
//       date.year,
//       date.month,
//       date.day,
//       time.hour,
//       time.minute,
//     );
//     setState(() {
//       this.datetime = newdateTime;
//     });
//   }

//   Future<DateTime?> pickDate() => showDatePicker(
//       context: context,
//       initialDate: datetime,
//       firstDate: DateTime(1900),
//       lastDate: DateTime(2100));
//   Future<TimeOfDay?> pickTime() => showTimePicker(
//       context: context,
//       initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));
// }

//

class Travel_report extends StatefulWidget {
  @override
  State<Travel_report> createState() => _Travel_reportState();
}

class _Travel_reportState extends State<Travel_report> {
  // const Idle_report({super.key});
  bool hideshow = true;
  String? selectedDrop;
  late DateTime datetime;
  DateTime datetime2 = DateTime.now();

  String? selectedVId;
  List<String> vehiclenum = [];
  TextEditingController durationcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    vidfordropdown();
    DateTime now = DateTime.now();
    DateTime todayStart = DateTime(now.year, now.month, now.day, 0, 0, 0, 0);
    datetime = todayStart;
  }

  tryag() {
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
    final formattedDate2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
    Api.travelreport(
        selectedVId, formattedDate, formattedDate2, durationcontroller);
  }

  vidfordropdown() {
    for (var i = 0; i < Homepagedatasmap.length; i++) {
      vehiclenum.add(Homepagedatasmap[i]["vehicleNo"]);
     
    }
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
    // final hours = datetime.hour.toString().padLeft(2, "0");
    // final minutes = datetime.minute.toString().padLeft(2, "0");

    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      appBar: AppBar(
        title: Text("travelr".tr()),
        actions: [
          travelreportlist.length != 0
              ? IconButton(
                  onPressed: () {
                    final formattedDate =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
                    final formattedDate2 =
                        DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
                    Api.emailsenddocument(selectedVId, "2", formattedDate,
                        formattedDate2, durationcontroller);
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
                          Container(
                            width: MediaQuery.of(context).size.width * 0.33,
                            height: 55,
                            child: TextFormField(
                              controller: durationcontroller,
                              decoration: const InputDecoration(
                                hintText: 'Enter the duration',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              setState(() {
                                travelreportlist.clear();
                              });
                            },
                            minWidth: width(context) * 0.33,
                            height: 55,
                            color: const Color.fromARGB(255, 240, 107, 107),
                            child: const Text("Clear"),
                          ),
                          MaterialButton(
                            minWidth: width(context) * 0.34,
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

                              Api.travelreport(selectedVId, formattedDate,
                                  formattedDate2, durationcontroller);
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
                    itemCount: travelreportlist.length,
                    itemBuilder: (context, index) {
                      Duration totalDuration = Duration.zero;
                      Duration _parseDuration(String durationString) {
                        List<String> parts = durationString.split(':');
                        int hours = int.parse(parts[0]);
                        int minutes = int.parse(parts[1]);
                        int seconds = int.parse(parts[2]);
                        return Duration(
                            hours: hours, minutes: minutes, seconds: seconds);
                      }

                      for (int i = 0; i <= index; i++) {
                        String durationString =
                            travelreportlist[i]["tripDuration"];
                        List<String> timeList = durationString.split(" ");
                        int hours = int.parse(timeList[0]);
                        int minutes = int.parse(timeList[2]);

                        // calculate the duration in seconds
                        int durationInSeconds =
                            (hours * 60 * 60) + (minutes * 60);

                        // create a Duration object from the duration in seconds
                        Duration duration44 =
                            Duration(seconds: durationInSeconds);

                        // format the duration string as "hh:mm:ss"
                        String durationString44 =
                            duration44.toString().split(".")[0];

                        Duration duration = _parseDuration(durationString44);
                        totalDuration += duration;
                      }

                      String formattedDurationtotal =
                          totalDuration.toString().split('.').first;

                      //total km

                      double totalkm = 0.00;

                      for (int i = 0; i <= index; i++) {
                        //
                        var distanceinkm = travelreportlist[i]["distenceinKM"];
                       

                        double? num = double.tryParse(
                            distanceinkm.replaceAll("Km", "").trim());
                      

                        // double num1 = double.parse(
                        //     distanceinkm.replaceAll("km", "").trim());
                        
                        totalkm += num as double;
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Travel(
                              vehiclenum: travelreportlist[index]["vehicleNo"],
                              travelfrom: travelreportlist[index]["travelFrom"],
                              travelto: travelreportlist[index]["travelTill"],
                              locationname: travelreportlist[index]
                                  ["startLocation"],
                              duration: travelreportlist[index]["tripDuration"],
                              totalduration: formattedDurationtotal,
                              distance: travelreportlist[index]["distenceinKM"],
                              totaldistance: totalkm.toString(),
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

class Travel extends StatefulWidget {
  String vehiclenum;
  String travelfrom;
  String travelto;
  String locationname;
  String duration;
  String totalduration;
  String distance;
  String totaldistance;
  Travel(
      {super.key,
      required this.vehiclenum,
      required this.travelto,
      required this.travelfrom,
      required this.locationname,
      required this.duration,
      required this.totalduration,
      required this.distance,
      required this.totaldistance});

  @override
  State<Travel> createState() => _TravelState();
}

class _TravelState extends State<Travel> {
  String formattedTimeduration = "00";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formattedTimeduration = convertTimeToDuration(widget.duration);
    // convertTimeToDuration(widget.duration);
  }

  convertTimeToDuration(var timeString) {
    // split the time string into hours and minutes
    List<String> timeList = timeString.split(" ");
    int hours = int.parse(timeList[0]);
    int minutes = int.parse(timeList[2]);

    // calculate the duration in seconds
    int durationInSeconds = (hours * 60 * 60) + (minutes * 60);

    // create a Duration object from the duration in seconds
    Duration duration = Duration(seconds: durationInSeconds);

    // format the duration string as "hh:mm:ss"
    String durationString = duration.toString().split(".")[0];
    formattedTimeduration = durationString;
  

    // return the duration string
    return durationString;
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
                Container(
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
                Container(
                    width: width(context) * 0.4,
                    child: Text(
                      "travelfrom".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.travelfrom)
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
                      "travelto".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.travelto)
              ],
            ),
            SizedBox(
              height: height(context) * 0.005,
            ),
            Row(
              children: [
                Container(
                  height: height(context) * 0.08,
                  width: width(context) * 0.4,
                  // color: Colors.red,
                  child: Container(
                      width: width(context) * 0.4,
                      child: Text(
                        "locatonname".tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                Container(
                    height: height(context) * 0.08, child: const Text(":")),
                Container(
                    height: height(context) * 0.08,
                    width: width(context) * 0.4,
                    // color: Colors.red,
                    child: Text(widget.locationname))
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
                      "duration".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(formattedTimeduration)
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
                      "totalduration".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.totalduration)
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
                      "distance".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.distance)
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
                      "totaldistance".tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                const Text(":"),
                Text(widget.totaldistance)
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
