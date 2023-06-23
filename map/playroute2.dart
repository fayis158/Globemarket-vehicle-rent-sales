// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';

// // import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:http/http.dart' as http;
// import '../../Constant.dart';

// class play extends StatefulWidget {
//   String vid;
//   play({super.key, required this.vid});

//   @override
//   _playState createState() => _playState();
// }

// class _playState extends State<play> {
//   int vehiclespeed = 2;

//   late DateTime yesterday;

//   final Completer<GoogleMapController> _controller = Completer();

//   late Marker _marker;
//   late Marker marker2;
//   LatLng? _markerLocation;
//   LatLng? _finalmarkerLocation;
//   int _polylineIndex = 0;
//   BitmapDescriptor? myIcon;
//   List<dynamic> _data = [];
//   List<LatLng> _points = [];
//   bool _isLoading = true;

//   late GoogleMapController mapController;
//   // LatLng? _markerLocation;

//   // autometical show popup focusedmenu
//   DateTime? selectedDate;
//   GlobalKey actionKey = GlobalKey();

//   bool selectedtoday = true;
//   bool selectedyesterday = true;
//   bool selecteddaybeforeyesterday = true;


//   // DateTime current_date = DateTime.now();
//   // String startingdate=current_date.tostring();




//   late var datetime2;
//   late var datetime;

//   void showMenuOptions() {
//     final RenderBox renderBox =
//         actionKey.currentContext!.findRenderObject() as RenderBox;
//     final position = renderBox.localToGlobal(Offset.zero);
//     final size = renderBox.size;

//     showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(
//           position.dx, position.dy + size.height, position.dx + size.width, 0),
//       items: [
//         PopupMenuItem(
//           child: Row(
//             children: [
//               Icon(Icons.check,
//                   color: selectedtoday == true ? Colors.green : Colors.grey),
//               const Text("Today"),
//             ],
//           ),
//           onTap: () {
//             setState(() {
//               datetime = DateTime.now();
//               _fetchData(widget.vid).then((_) => _drawPolyline());
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => play(
//                           vid: widget.vid,
//                         )),
//               );
//               selectedyesterday = false;
//               selecteddaybeforeyesterday = false;
//               selectedtoday = true;
             
//             });
//           },
//         ),
//         PopupMenuItem(
//           child: Row(
//             children: [
//               Icon(Icons.check,
//                   color: selectedtoday == false && selectedyesterday == true
//                       ? Colors.green
//                       : Colors.grey),
//               const Text("Yesterday"),
//             ],
//           ),
//           onTap: () {

//             setState(() {
//               selectedtoday = false;
//               selecteddaybeforeyesterday = false;
//               selectedyesterday = true;
//             });
//           },
//         ),
//         PopupMenuItem(
//           child: Row(
//             children: [
//               Icon(Icons.check,
//                   color: selecteddaybeforeyesterday == true &&
//                           selectedtoday == false
//                       ? Colors.green
//                       : Colors.grey),
//               const Text("Day Before Yesterday"),
//             ],
//           ),
//           onTap: () {
//             selectedtoday = false;
//             selectedyesterday = false;
//             selecteddaybeforeyesterday = true;
//           },
//         ),
//         PopupMenuItem(
//           child: Row(
//             children: [
//               const Text('Userdefined: '),
//               selectedDate == null
//                   ? const Text('Not Selected', style: TextStyle(color: Colors.grey))
//                   : Text(
//                       '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
//             ],
//           ),
//           onTap: () async {
//             final DateTime? picked = await showDatePicker(
//               context: context,
//               initialDate: selectedDate ?? DateTime.now(),
//               firstDate: DateTime(1900),
//               lastDate: DateTime(2100),
//             );
//             if (picked != null) {
//               setState(() {
//                 selectedDate = picked;
//                 // selectedtoday = false;
//               });
//               // Navigator.pop(context);
//               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextPage()));
//             }
//           },
//         ),
//       ],
//     );
//   }

//   @override
//   void initState() {
//     // yesterday = today.subtract(Duration(days: 1));
//     super.initState();
//       final DateTime now111 = DateTime.now();
//   final DateFormat formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
//   final String formatted = formatter.format(now111);
  

//     DateTime now = DateTime.now();
//     var datetime0000 = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       12,
//       0,
//       0,
//       0,
//     );
//     datetime = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime0000);
//     var datetime2323 = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       now.hour,
//       now.minute,
//       0,
//       0,
//     );

//     datetime2 = DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime2323);


//     setInitialMarkerLocation();

//     _fetchData(widget.vid).then((_) => _drawPolyline());
//     BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
//             mipmaps: true)
//         .then((onValue) {
//       myIcon = onValue;
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showMenuOptions();
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     //  _node.dispose();
//   }










//   ///api fetch data

//   Future<void> _fetchData(String vid) async {
//     final response = await http.get(Uri.parse(
//         'http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/$vid/$datetime/$datetime2'));
//     if (response.statusCode == 200) {
//       final extractedData = json.decode(response.body);
//       setState(() {
//         _data = extractedData["historyData"];
//       });
//     } else {
//       _data = [
//         {
//           "latitude": "29.7097",
//           "longitude": "78.2558",
//         },
//         {
//           "latitude": "29.7097",
//           "longitude": "78.2558",
//         }
//       ];
     
//     }
//   }










//   void _drawPolyline() {
//     for (var data in _data) {
//       double lat = double.parse(data['latitude']);
//       double lng = double.parse(data['longitude']);
//       _points.add(LatLng(lat, lng));
//     }
//     setState(() {
//       _isLoading = false;
//       setInitialMarkerLocation();
//     });
//   }

// //date pickers

//   // DateTime datetime = DateTime(2022, 11, 23, 5, 30);
//   // Future<DateTime?> pickDate() => showDatePicker(
//   //     context: context,
//   //     initialDate: datetime,
//   //     firstDate: DateTime(1900),
//   //     lastDate: DateTime(2100));

//   // Future<TimeOfDay?> pickTime() => showTimePicker(
//   //     context: context,
//   //     initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));

//   // Future pickDateTime() async {
//   //   DateTime? date = await pickDate();
//   //   if (date == null) return;
//   //   TimeOfDay? time = await pickTime();
//   //   if (time == null) return;

//   //   final newdateTime = DateTime(
//   //     date.year,
//   //     date.month,
//   //     date.day,
//   //     time.hour,
//   //     time.minute,
//   //   );
//   //   setState(() {
//   //     datetime = newdateTime;
//   //   });
//   // }

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
//             return const AlertDialog(
//               title: Text("error"),
//               content: Text("msgabtsedate"),
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

//   buildLanguageDialog2(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (builder) {
//           return AlertDialog(
//             // title: const Text(''),
//             content: Container(
//                 height: 280,
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     const Text("Please select maximum only 15 days history"),
//                     const Text("startdatetime"),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     MaterialButton(
//                       minWidth: width(context) * 0.5,
//                       height: 55,
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       onPressed: pickDateTime,
//                       child: Text(
//                         "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}:00",
//                         // "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}",
//                         style: const TextStyle(
//                             color: Color.fromARGB(255, 22, 21, 21)),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text("enddatetime"),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     MaterialButton(
//                       minWidth: width(context) * 0.5,
//                       height: 55,
//                       color: const Color.fromARGB(255, 255, 255, 255),
//                       onPressed: () {
//                         pickDateTime2();
//                       },
//                       child: Text(
//                         "${datetime2.year}/ ${datetime2.month}/${datetime2.day}   ${datetime2.hour}: ${datetime2.minute}:00",
//                         style: const TextStyle(
//                             color: Color.fromARGB(255, 22, 21, 21)),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     MaterialButton(
//                       color: Colors.green,
//                       onPressed: () {
//                         _fetchData(widget.vid).then((_) => _drawPolyline());
//                         Navigator.pop(context);
//                       },
//                       child: const Text(
//                         "OK",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )
//                   ],
//                 )),
//           );
//         });
//   }

//   bool veryslow = false;

//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//     mapController = controller;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             TextButton(
//                 onPressed: () {
//                   // run == false ? moveMarker() : null;
//                   // run == true;
//                   // moveMarker();
//                 },
//                 child: const Text("check")),
//             // Text(widget.vehiclenum),
//             FocusedMenuHolder(
//               animateMenuItems: true,
//               openWithTap: true,
//               blurSize: 0,
//               menuWidth: MediaQuery.of(context).size.width * 0.50,
//               onPressed: () {},
//               menuItems: [
//                 FocusedMenuItem(
//                     title: Row(
//                       children: const [
//                         Icon(
//                           Icons.check,
//                           size: 22,
//                         ),
//                         Text("   Very slow"),
//                       ],
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         veryslow == false;
//                       });
//                     }),
//                 FocusedMenuItem(
//                     title: Row(
//                       children: const [
//                         Icon(
//                           Icons.check,
//                           size: 22,
//                         ),
//                         Text("   Slow"),
//                       ],
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         vehiclespeed = 3;
//                       });
//                     }),
//                 FocusedMenuItem(
//                     title: Row(
//                       children: const [
//                         Icon(
//                           Icons.check,
//                           size: 22,
//                         ),
//                         Text("   Normal"),
//                       ],
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         vehiclespeed = 2;
//                       });
//                     }),
//                 FocusedMenuItem(
//                     title: Row(
//                       children: const [
//                         Icon(
//                           Icons.check,
//                           size: 22,
//                         ),
//                         Text("    Fast"),
//                       ],
//                     ),
//                     onPressed: () {}),
//                 FocusedMenuItem(
//                     title: Row(
//                       children: const [
//                         Icon(
//                           Icons.check,
//                           size: 22,
//                         ),
//                         Text("    Very fast"),
//                       ],
//                     ),
//                     onPressed: () {}),
//               ],
//               child: const Icon(
//                 Icons.play_circle_outline,
//               ),
//             ),
//             GestureDetector(
//               onTap: showMenuOptions,
//               child: Container(
//                 key: actionKey,
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: const Icon(
//                   Icons.watch_later_outlined,
//                 ),
//               ),
//             ),
//             // FocusedMenuHolder(
//             //   //  key: _menuKey,
//             //   animateMenuItems: true,
//             //   openWithTap: true,
//             //   blurSize: 0,
//             //   menuWidth: MediaQuery.of(context).size.width * 0.50,
//             //   onPressed: () {},
//             //   menuItems: [
//             //     FocusedMenuItem(
//             //         title: Row(
//             //           children: const [
//             //             Icon(
//             //               Icons.check,
//             //               size: 22,
//             //             ),
//             //             Text("  Today"),
//             //           ],
//             //         ),
//             //         onPressed: () {}),
//             //     FocusedMenuItem(
//             //         title: Row(
//             //           children: const [
//             //             Icon(
//             //               Icons.check,
//             //               size: 22,
//             //             ),
//             //             Text("  Yesterday"),
//             //           ],
//             //         ),
//             //         onPressed: () {}),
//             //     FocusedMenuItem(
//             //         title: Row(
//             //           children: const [
//             //             Icon(
//             //               Icons.check,
//             //               size: 22,
//             //             ),
//             //             Text("  Before Yesterday"),
//             //           ],
//             //         ),
//             //         onPressed: () {}),
//             //     FocusedMenuItem(
//             //         title: Row(
//             //           children: const [
//             //             Icon(
//             //               Icons.check,
//             //               size: 22,
//             //             ),
//             //             Text("  User defined"),
//             //           ],
//             //         ),
//             //         onPressed: () {
//             //           Future.delayed(const Duration(milliseconds: 1), () {
//             //             buildLanguageDialog2(context);
//             //           });
//             //           // buildLanguageDialog2(context);
//             //         }),
//             //   ],
//             //   child: const Icon(
//             //     Icons.watch_later_outlined,
//             //   ),
//             // ),
//             FocusedMenuHolder(
//               animateMenuItems: true,
//               openWithTap: true,
//               blurSize: 0,
//               menuWidth: MediaQuery.of(context).size.width * 0.50,
//               onPressed: () {},
//               menuItems: [
//                 FocusedMenuItem(
//                     title: const Text("30 ${'minutes'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("2 ${'hour'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("4 ${'hour'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("8 ${'hour'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("12 ${'hour'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("24 ${'hour'}"), onPressed: () {}),
//                 FocusedMenuItem(
//                     title: const Text("${'custom'}"), onPressed: pickDateTime),
//               ],
//               child: const Icon(
//                 Icons.share,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             flex: 7,
//             child: Stack(children: [
//               _isLoading == true && myIcon == null
//                   ? const Center(child: CircularProgressIndicator())
//                   : GoogleMap(
//                       mapType: MapType.normal,
//                       initialCameraPosition: CameraPosition(
//                         target:_points.isEmpty?const LatLng(37.0902, 95.7129):_points.first,
//                         zoom: 14,
//                       ),
//                       polylines: {
//                       _points.isNotEmpty?  Polyline(
//                           polylineId: const PolylineId('polyline'),
//                           color: Colors.blue,
//                           points: _points,
//                           width: 3,
//                         ):const Polyline(polylineId:PolylineId('polyline') )
//                       },
//                       markers: _points.isNotEmpty? {
//                         // Marker(
//                         // markerId: const MarkerId("marker_id"),
//                         // position: _points.first,
//                         // onTap: () {},
//                         // icon: myIcon!),
//                         _marker,
//                       }:{},
//                       onMapCreated: _onMapCreated,
//                       //  (GoogleMapController controller) {
//                       //   _controller.complete(controller);
//                       //   // controller.animateCamera(CameraUpdate.newCameraPosition(
//                       //   //   CameraPosition(
//                       //   //     target: _points.first,
//                       //   //     zoom: 15.0,
//                       //   //   ),
//                       //   // ));
//                       // },
//                     ),
//               Positioned(
//                 left: width(context) * 0.84,
//                 top: height(context) * 0.39,
//                 child: GestureDetector(
//                   onTap: () {
//                     moveMarker();
//                   },
//                   child: Container(
//                       height: 35,
//                       width: 45,
//                       decoration: const BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       child: const Padding(
//                         padding: EdgeInsets.all(8.0),
//                         child: Center(
//                           child: Text(
//                             "Play",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       )),
//                 ),
//               ),
//             ]),
//           ),
//           Expanded(
//               flex: 1,
//               child: Container(
//                 height: 30,
//                 color: const Color.fromARGB(21, 255, 255, 255),
//                 child: Column(
//                   children: [
//                     SliderPlayButton(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("03-Feb-2023 10:59:43 AM"),
//                           Text("Dis. 21.45 kms"),
//                           Text("9.0 km/h")
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ))
//         ],
//       ),
//     );
//   }

//   void setInitialMarkerLocation() {
//     if (_points.isNotEmpty) {
//       _markerLocation = _points.first;
//       // _markerLocation = latLonList.last;
//       _marker = Marker(
//         markerId: const MarkerId('marker'),
//         position: _markerLocation!,
//         rotation: 2.0,
//         icon: myIcon!,
//       );
//     }
//     setState(() {});
//   }

//   void setfinalMarkerLocation() {
//     if (_points.isNotEmpty) {
//       _finalmarkerLocation = const LatLng(45.518299, -122.683485);
//       // _markerLocation = latLonList.last;
//       marker2 = Marker(
//         markerId: const MarkerId('marker'),
//         position: _finalmarkerLocation!,
//         rotation: 2.0,
//         icon: myIcon!,
//       );
//     }
//   }

//   void moveMarker() {
//     Timer.periodic(Duration(seconds: veryslow == false ? 59 : 1), (timer) {
//       setState(() {
//         if (_polylineIndex < _points.length - 1) {
//           _polylineIndex++;
//         } else {
//           _polylineIndex = 0;
//         }
//         _markerLocation = _points[_polylineIndex];
//         _marker = Marker(
//           draggable: true,
//           markerId: const MarkerId('marker'),
//           position: _markerLocation!,
//           icon: myIcon!,
//           // icon: BitmapDescriptor.defaultMarker,
//           anchor: const Offset(1.0, 1.0),
//         );
//         mapController.animateCamera(
//           CameraUpdate.newLatLng(_markerLocation!),
//         );
//         {
//           Polyline(
//             polylineId: const PolylineId('polyline'),
//             color: Colors.blue,
//             points: _points,
//             width: 2,
//           );
//         }
//         ;
//       });
//     });
//   }
// }

// //slider field

// class SliderPlayButton extends StatefulWidget {
//   @override
//   _SliderPlayButtonState createState() => _SliderPlayButtonState();
// }

// class _SliderPlayButtonState extends State<SliderPlayButton> {
//   double _sliderValue = 0.0;
//   bool _isPlaying = false;

//   Timer? _timer;
//   bool run = false;

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _start() {
//     _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//       setState(() {
//         _sliderValue += 1;
//         if (_sliderValue >= 100) {
//           _stop();
//         }
//       });
//     });
//   }

//   void _stop() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           icon: _isPlaying
//               ? const Icon(Icons.pause)
//               : const Icon(Icons.play_arrow),
//           onPressed: () {
//             setState(() {
//               if (_isPlaying) {
//                 _stop();
//               } else {
//                 _start();
//               }
//               _isPlaying = !_isPlaying;
//             });
//           },
//         ),
//         SizedBox(
//           width: width(context) * 0.8,
//           child: Slider(
//             value: _sliderValue,
//             min: 0.0,
//             max: 101.0,
//             divisions: 100,
//             onChanged: (newValue) {
//               setState(() {
//                 _sliderValue = newValue;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
