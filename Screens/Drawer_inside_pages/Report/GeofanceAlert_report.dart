// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:globegps/Api/api.dart';
// import 'package:globegps/Constant.dart';
// import 'package:globegps/Screens/Home_page/Home_page.dart';

// // class Geofence_alert_report extends StatefulWidget {
// //   @override
// //   State<Geofence_alert_report> createState() => _Geofence_alert_reportState();
// // }

// // class _Geofence_alert_reportState extends State<Geofence_alert_report> {
// //   // const Geofence_alert_report({super.key});
// //   bool hideshow = true;
// //   List<String> days = ['KL18AA0001', 'KL18AA0002', 'KL18AA0003', '2656'];
// //   String selectedDrop = 'KL18AA0001';
// //   DateTime datetime = DateTime(2022, 11, 23, 5, 30);
// //   DateTime datetime2 = DateTime(2022, 11, 23, 5, 30);

// //   @override
// //   Widget build(BuildContext context) {
// //     final hours = datetime.hour.toString().padLeft(2, "0");
// //     final minutes = datetime.minute.toString().padLeft(2, "0");
// //     return Scaffold(
// //       floatingActionButton: const Floatingaction_button(),
// //       appBar: AppBar(
// //         title:  Text("geofencealertr".tr()),
// //         actions: [
// //           IconButton(
// //               onPressed: () {
// //                 Navigator.of(context).pop();
// //               },
// //               icon: const Icon(Icons.home))
// //         ],
// //       ),
// //       body: Column(
// //         children: [
// //           SizedBox(
// //             height: hideshow ? null : 0,
// //             width: double.infinity,
// //             // color: Color.fromARGB(255, 115, 113, 255),
// //             child: Column(
// //               children: [
// //                 Row(
// //                   children: [
// //                     Container(
// //                       color: Colors.white,
// //                       width: width(context),
// //                       height: 50,
// //                       child: Padding(
// //                         padding: const EdgeInsets.symmetric(
// //                           horizontal: 12,
// //                         ),
// //                         child: DropdownButtonFormField<String>(
// //                             // isDense: false,
// //                             enableFeedback: false,
// //                             // dropdownColor: Colors.green,
// //                             value: selectedDrop,
// //                             items: days.map((e) {
// //                               return DropdownMenuItem(
// //                                   onTap: () {
// //                                     setState(() {
// //                                       selectedDrop = e;
// //                                     });
// //                                   },
// //                                   value: e,
// //                                   child: Text(e));
// //                             }).toList(),
// //                             onChanged: (val) {}),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   height: height(context) * 0.01,
// //                 ),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     Column(
// //                       children: [
// //                         Container(
// //                           width: width(context)*0.5,
// //                            child: Text("startdatetime".tr(),
// //                               style: TextStyle(
// //                                   color: Color.fromARGB(255, 98, 145, 98),
// //                                   fontWeight: FontWeight.bold)),
// //                          ),
// //                         MaterialButton(
// //                           minWidth: width(context) * 0.5,
// //                           height: 55,
// //                           color: const Color.fromARGB(255, 255, 255, 255),
// //                           onPressed: pickDateTime,
// //                           child: Text(
// //                             "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}",
// //                             style: const TextStyle(
// //                                 color: Color.fromARGB(255, 22, 21, 21)),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     Column(
// //                       children: [
// //                         Container(
// //                         //  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
// //                           width: width(context)*0.5,
// //                            child: Text("enddatetime".tr(),
// //                               style: TextStyle(
// //                                   color: Color.fromARGB(255, 98, 145, 98),
// //                                   fontWeight: FontWeight.bold)),
// //                          ),
// //                         MaterialButton(
// //                           minWidth: width(context) * 0.5,
// //                           height: 55,
// //                           color: const Color.fromARGB(255, 255, 255, 255),
// //                           onPressed: pickDateTime2,
// //                           child: Text(
// //                             "${datetime2.year}/ ${datetime2.month}/${datetime2.day}   ${datetime2.hour}: ${datetime2.minute}",
// //                             style: const TextStyle(
// //                                 color: Color.fromARGB(255, 22, 21, 21)),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 // SizedBox(height: 6,),
// //                 MaterialButton(
// //                   minWidth: width(context),
// //                   height: 55,
// //                   color: const Color.fromARGB(255, 141, 247, 255),
// //                   child: const Text(
// //                     "OK",
// //                     style: TextStyle(fontSize: 19),
// //                   ),
// //                   onPressed: () {
// //                     if (datetime2.isBefore(datetime)) {
// //                       showDialog(
// //                         context: context,
// //                         builder: (context) {
// //                           return const AlertDialog(
// //                             title: Text("error"),
// //                             content: Text(
// //                                 "Start Date can't be greater than End Date"),
// //                           );
// //                         },
// //                       );
// //                     }
// //                   },
// //                 )
// //               ],
// //             ),
// //           ),
// //           MaterialButton(
// //             minWidth: 28,
// //             height: 30,
// //             color:
// //                 hideshow ? Colors.red : const Color.fromARGB(255, 8, 177, 65),
// //             child: hideshow
// //                 ?  Text(
// //                     "hideinputarea".tr(),
// //                     style: TextStyle(color: Colors.white),
// //                   )
// //                 :  Text(
// //                     "showinputarea".tr(),
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //             onPressed: () {
// //               setState(() {
// //                 hideshow = !hideshow;
// //               });
// //             },
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Future pickDateTime2() async {
// //     DateTime? date = await pickDate();
// //     if (date == null) return;
// //     TimeOfDay? time = await pickTime();
// //     if (time == null) return;

// //     final newdateTime = DateTime(
// //       date.year,
// //       date.month,
// //       date.day,
// //       time.hour,
// //       time.minute,
// //     );
// //     setState(() {
// //       this.datetime2 = newdateTime;
// //         if (datetime2.isBefore(datetime)) {
// //         showDialog(
// //           context: context,
// //           builder: (context) {
// //             return  AlertDialog(
// //               title: Text("error"),
// //               content: Text("msgabtsedate".tr()),
// //             );
// //           },
// //         );
// //       }
// //     });
// //   }

// //   Future pickDateTime() async {
// //     DateTime? date = await pickDate();
// //     if (date == null) return;
// //     TimeOfDay? time = await pickTime();
// //     if (time == null) return;

// //     final newdateTime = DateTime(
// //       date.year,
// //       date.month,
// //       date.day,
// //       time.hour,
// //       time.minute,
// //     );
// //     setState(() {
// //       this.datetime = newdateTime;
// //     });
// //   }

// //   Future<DateTime?> pickDate() => showDatePicker(
// //       context: context,
// //       initialDate: datetime,
// //       firstDate: DateTime(1900),
// //       lastDate: DateTime(2100));
// //   Future<TimeOfDay?> pickTime() => showTimePicker(
// //       context: context,
// //       initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));
// // }

// ///
// ///
// ///
// ///





// class Geofence_alert_report extends StatefulWidget {
//   @override
//   State<Geofence_alert_report> createState() => _Geofence_alert_reportState();
// }

// class _Geofence_alert_reportState extends State<Geofence_alert_report> {
//   // const Vehicle_on_off_count({super.key});
//   bool hideshow = true;

//   String? selectedDrop;
//   DateTime datetime = DateTime.now();
//   DateTime datetime2 = DateTime.now();

//   String? selectedVId;
//   List<String> vehiclenum = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     vidfordropdown();
//   }

//   vidfordropdown() {
//     for (var i = 0; i < Homepagedatasmap.length; i++) {
//       vehiclenum.add(Homepagedatasmap[i]["vehicleNo"]);

//     }
//   }

//   tryag() {
//     final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime);
//     final formattedDate2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2);
//     Api.geofencereport(
//       selectedVId,
//       formattedDate,
//       formattedDate2,
//     );
//   }

//   int totalgeoincount = 0;
//   int totalgeooutcount = 0;
//   int totalignitiononcount = 0;
//   int totalignitionoffcount = 0;
//   List outputList = [];

//   @override
//   Widget build(BuildContext context) {
//     final hours = datetime.hour.toString().padLeft(2, "0");
//     final minutes = datetime.minute.toString().padLeft(2, "0");
//     return Scaffold(
//       floatingActionButton: const Floatingaction_button(),
//       appBar: AppBar(
//         title: Text("vehicleSummaryr".tr()),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               icon: const Icon(Icons.home))
//         ],
//       ),
//       body: FutureBuilder(
//         future: tryag(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else {
//             // Return the UI for the page here
//             return Column(
//               children: [
//                 SizedBox(
//                   height: hideshow ? null : 0,
//                   width: double.infinity,
//                   // color: Color.fromARGB(255, 115, 113, 255),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             color: Colors.white,
//                             width: width(context),
//                             height: 50,
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 12,
//                               ),
//                               child: DropdownButtonFormField<String>(
//                                   // isDense: false,
//                                   enableFeedback: false,
//                                   // dropdownColor: Colors.green,
//                                   value: selectedDrop,
//                                   items: vehiclenum.map((e) {
//                                     return DropdownMenuItem(
//                                         onTap: () {
//                                           setState(() {
//                                             selectedDrop = e;
//                                             selectedVId =
//                                                 Homepagedatasmap.firstWhere(
//                                                     (vehicle) =>
//                                                         vehicle['vehicleNo'] ==
//                                                         selectedDrop)['vid'];
//                                           });
//                                         },
//                                         value: e,
//                                         child: Text(e));
//                                   }).toList(),
//                                   onChanged: (val) {}),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height(context) * 0.01,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Column(
//                             children: [
//                               Container(
//                                 width: width(context) * 0.5,
//                                 child: Text("startdatetime".tr(),
//                                     style: const TextStyle(
//                                         color: Color.fromARGB(255, 98, 145, 98),
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               MaterialButton(
//                                 minWidth: width(context) * 0.5,
//                                 height: 55,
//                                 color: const Color.fromARGB(255, 255, 255, 255),
//                                 onPressed: pickDateTime,
//                                 child: Text(
//                                   "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}",
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 22, 21, 21)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Container(
//                                 //  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                                 width: width(context) * 0.5,
//                                 child: Text("enddatetime".tr(),
//                                     style: const TextStyle(
//                                         color: Color.fromARGB(255, 98, 145, 98),
//                                         fontWeight: FontWeight.bold)),
//                               ),
//                               MaterialButton(
//                                 minWidth: width(context) * 0.5,
//                                 height: 55,
//                                 color: const Color.fromARGB(255, 255, 255, 255),
//                                 onPressed: pickDateTime2,
//                                 child: Text(
//                                   "${datetime2.year}/ ${datetime2.month}/${datetime2.day}   ${datetime2.hour}: ${datetime2.minute}",
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 22, 21, 21)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       // SizedBox(height: 6,),
//                       MaterialButton(
//                         minWidth: width(context),
//                         height: 55,
//                         color: const Color.fromARGB(255, 141, 247, 255),
//                         child: const Text(
//                           "OK",
//                           style: TextStyle(fontSize: 19),
//                         ),
//                         onPressed: () {
                 
//                           final formattedDate =
//                               DateFormat('yyyy-MM-dd HH:mm:ss')
//                                   .format(datetime);
//                           final formattedDate2 =
//                               DateFormat('yyyy-MM-dd HH:mm:ss')
//                                   .format(datetime2);
//                           Api.geofencereport(
//                             selectedVId,
//                             formattedDate,
//                             formattedDate2,
//                           );
                      

                          

//                           setState(() {
//                             tryag();
//                           });
                        
//                           if (datetime2.isBefore(datetime)) {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return const AlertDialog(
//                                   title: Text("error"),
//                                   content: Text(
//                                       "Start Date can't be greater than End Date"),
//                                 );
//                               },
//                             );
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//                 MaterialButton(
//                   minWidth: 28,
//                   height: 30,
//                   color: hideshow
//                       ? Colors.red
//                       : const Color.fromARGB(255, 8, 177, 65),
//                   child: hideshow
//                       ? Text(
//                           "hideinputarea".tr(),
//                           style: const TextStyle(color: Colors.white),
//                         )
//                       : Text(
//                           "showinputarea".tr(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                   onPressed: () {
//                     setState(() {
//                       hideshow = !hideshow;
//                     });
//                   },
//                 ),
//                 Expanded(
//                   child: vehiclesummaryreportlist.isEmpty
//                       ? ListView.builder(
//                           itemCount: 1,
//                           itemBuilder: (context, index) {
//                             return SizedBox();
//                           },
//                         )
//                       : ListView.builder(
//                           itemCount: geofencereportlist.length,
//                           itemBuilder: (context, index) {
                           
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   geofence(
//                                      vehicleNo: geofencereportlist[index]["vehicleNo"],
//                                      geofencename: geofencereportlist[index]["geofenceName"],
//                                      locationname: geofencereportlist[index]["location"],
//                                      inTime: geofencereportlist[index]["inTime"],
//                                      outTime: geofencereportlist[index]["outTime"],
//                                      duration: geofencereportlist[index]["duriation"],
//                                   )
                                
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                 )
//               ],
//             );
//           }
//         },
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
//       if (datetime2.isBefore(datetime)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text("error"),
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


// //ui




// class geofence extends StatefulWidget {
//   String vehicleNo;
//   String geofencename;
//   String inTime;
//   String locationname;
//   String duration;
//   String outTime;
//   geofence({
//     super.key,
//     required this.vehicleNo,
//     required this.geofencename,
//     required this.inTime,
//     required this.locationname,
//     required this.duration,
//     required this.outTime,
//   });

//   @override
//   State<geofence> createState() => _geofenceState();
// }

// class _geofenceState extends State<geofence> {
//   String? formattedTimeduration;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // convertduration(widget.duration);
//   }

//   // convertduration(String durationvalue) {
//   //   String timeString = durationvalue;
//   //   List<String> timeParts = timeString.split(" ");
//   //   int timeValue = int.parse(timeParts[0]);
//   //   Duration duration = Duration(minutes: timeValue);
//   //   String formattedTime = duration.toString().split('.').first.padLeft(8, "0");
//   //   formattedTimeduration = formattedTime;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // height: height(context) * 0.3,
//       width: width(context),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromARGB(255, 114, 114, 114).withOpacity(0.1),
//             offset: const Offset(-6.0, -6.0),
//             blurRadius: 16.0,
//           ),
//           BoxShadow(
//             color: const Color.fromARGB(255, 121, 121, 121).withOpacity(0.4),
//             offset: const Offset(6.0, 6.0),
//             blurRadius: 10.0,
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: width(context) * 0.4,
//                     child: Text(
//                       "vehiclenumber".tr(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//                 const Text(":"),
//                 Text(widget.vehicleNo)
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: width(context) * 0.4,
//                     child: Text(
//                       "Geofence Name",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//                 const Text(":"),
//                 Text(widget.geofencename)
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: width(context) * 0.4,
//                     child: Text(
//                       "InTime",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//                 const Text(":"),
//                 Text(widget.inTime)
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                   height: height(context) * 0.05,
//                   width: width(context) * 0.4,
//                   // color: Colors.red,
//                   child: Container(
//                       width: width(context) * 0.4,
//                       child: Text(
//                         "locatonname".tr(),
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       )),
//                 ),
//                 Container(
//                     height: height(context) * 0.05, child: const Text(":")),
//                 Container(
//                     height: height(context) * 0.06,
//                     width: width(context) * 0.4,
//                     child: Text(widget.locationname))
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: width(context) * 0.4,
//                     child: Text(
//                       "duration".tr(),
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//                 const Text(":"),
//                 Text(formattedTimeduration!)
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     width: width(context) * 0.4,
//                     child: Text(
//                       "Outtime",
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )),
//                 const Text(":"),
//                 Text(widget.outTime)
//               ],
//             ),
//             SizedBox(
//               height: height(context) * 0.01,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
