// import 'dart:async';
// import 'dart:convert';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';

// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';


// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:gpsglobe/Constant.dart';
// import 'package:gpsglobe/extensions/extensions.dart';
// import 'package:gpsglobe/map/playroute2.dart';
// import 'package:gpsglobe/map/vehiclemove.dart';
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
// import '../Screens/Drawer_inside_pages/Report/reports.dart';
// import '../Screens/Home/Gesture_home_container.dart';
// import '../Screens/more_in_tabbar.dart/inside_more/Fastag.dart/Fastag.dart';
// import 'package:http/http.dart' as http;
// import 'package:cached_network_image/cached_network_image.dart';

// List<LatLng> latlnglist = [];
// int speed = 0;
// String distance = "0";
// String ed = "";
// String vehiclelocation = "";
// String currentlocation = "";
// String? imageurl;

// class Mytest2 extends StatefulWidget {
//   Mytest2({
//     super.key,
//     required this.vehiclenum,
//     required this.speed,
//     required this.vehiclecondition,
//     required this.ignition,
//     required this.vid,
//     required this.latitude,
//     required this.longitude,
//     required this.items,
//     required this.location,
//     required this.km,
//   });

//   double latitude;
//   double longitude;
//   String location;
//   int km;
//   String vehiclenum;
//   String vehiclecondition;
//   var ignition;
//   var speed;
//   String vid;
//   final List<String> items;

//   @override
//   State<Mytest2> createState() => _Mytest2State();
// }

// bool Normal = true;
// bool satellite = true;
// bool Terrain = true;
// bool loc = true;
// bool isClicked = false;
// bool traffic = false;

// final CustomInfoWindowController _customInfoWindowController =
//     CustomInfoWindowController();
// late GoogleMapController _mapController;

// double _zoomLevel = 15.3;

// class _Mytest2State extends State<Mytest2> {
//   Completer<GoogleMapController> _controller = Completer();
//   BitmapDescriptor? myIcon;
//   Location location = Location();

//   @override
//   void initState() {
//     super.initState();
//     iconapi();
//     _loadIcon();
//   }

// //strem api call

//   Stream<LatLng> getLatLng() async* {
//     LatLng x = LatLng(widget.latitude, widget.longitude);
//     String _formattedDateTimeone;
//     String _formattedDateTime;
//     DateTime now = DateTime.now();
//     _formattedDateTimeone = DateFormat('yyyy-MM-dd 00:00:00').format(now);
//     _formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     var res = await http.get(Uri.parse(
//         "http://globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/${widget.vid}/$_formattedDateTimeone/$_formattedDateTime"));
//     if (res.statusCode == 200) {
//       List decodedData = jsonDecode(res.body)["historyData"];
//       latlnglist.clear();
//       for (var i = 0; i < decodedData.length; i++) {
//         x = LatLng(double.parse(decodedData[i]["latitude"]),
//             double.parse(decodedData[i]["longitude"]));
//         latlnglist.add(LatLng(double.parse(decodedData[i]["latitude"]),
//             double.parse(decodedData[i]["longitude"])));

//         distance = decodedData.last["distence"];
//         ed = decodedData.last["trackDateTime"];

//         // await lastlocation(
//         //     decodedData.last["latitude"], decodedData.last["longitude"]);
//         setState(() {});
//         yield x;
//       }
//       yield x;
//     }
//   }

//   iconapi() async {
//     var fetchicondata = await http.get(Uri.parse(
//         "http://globalgps.in:8089/api/v1/LiveDataDetailswithLocationByVid/${widget.vid}"));
//     if (fetchicondata.statusCode == 200) {
//       List icondata = jsonDecode(fetchicondata.body);
//       imageurl = icondata[0]["vehstatus1"];
//       currentlocation = icondata[0]["location"];
//       speed = icondata[0]["speed"];
//       var url = imageurl!.substring(1);
//       // final response = await http.get(Uri.parse(
//       //   "https://globalgps.in/$url",
//       // ));
//       // final bytes = response.bodyBytes;

//       // // Create a BitmapDescriptor from the icon data
//       // final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes);

//       // setState(() {
//       //   myIcon = bitmapDescriptor;
//       // });
//     }
//   }

//   // Future<void> _loadIcon() async {
//   //   final BitmapDescriptor bitmapDescriptor =
//   //       await BitmapDescriptor.fromAssetImage(
//   //     const ImageConfiguration(size: Size(12, 10)),
//   //     'images/mapicon.png',
//   //     mipmaps: true,
//   //   );
//   //   setState(() {
//   //     myIcon = bitmapDescriptor;
//   //   });
//   // }

//   Future<void> _loadIcon() async {
//     // Fetch the icon data from the network
//     final response = await http.get(Uri.parse(
//       "https://globalgps.in/Images/RedMapMakers1/car.png",
//     ));
//     final bytes = response.bodyBytes;

//     // Create a BitmapDescriptor from the icon data
//     final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes);

//     setState(() {
//       myIcon = bitmapDescriptor;
//     });
//   }




//   controllerMapFunction(GoogleMapController controller, LatLng latLng) {
//     controller.animateCamera(
//         CameraUpdate.newCameraPosition(CameraPosition(target: latLng)));
//     setState(() {});
//   }

//   void _showPopupMenu(BuildContext context) async {
//     await showMenu(
//       context: context,
//       position:
//           RelativeRect.fromLTRB(width(context), height(context) * 0.45, 0, 0),
//       items: [
//         PopupMenuItem(
//           onTap: () {
//             setState(() {
//               Normal = true;
//               satellite = false;
//               Terrain = false;
//             });
//           },
//           value: 1,
//           child: const Text("Normal"),
//         ),
//         PopupMenuItem(
//           onTap: () {
//             setState(() {
//               Normal = false;
//               satellite = true;
//               Terrain = false;
//             });
//           },
//           value: 2,
//           child: const Text("Satellite"),
//         ),
//         PopupMenuItem(
//           onTap: () {
//             setState(() {
//               Normal = false;
//               satellite = false;
//               Terrain = false;
//             });
//           },
//           value: 3,
//           child: const Text("Terrain"),
//         ),
//       ],
//       elevation: 8.0,
//     ).then((value) {
// // NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

//       // if (value != null);
//     });
//   }

//   onMapCreated(GoogleMapController controller, LatLng latLng) {
//     _controller.complete(controller);
//     controller.animateCamera(
//         CameraUpdate.newCameraPosition(CameraPosition(target: latLng)));
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _customInfoWindowController.dispose();
//   }

//   final Set<Marker> _markers = {
//     const Marker(
//       markerId: MarkerId('marker1'),
//       position: LatLng(37.422, -122.084),
//       infoWindow: InfoWindow(
//         title: 'Marker 1',
//         snippet: 'This is marker 1',
//       ),
//     ),
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             )),
//         title: Text(
//           widget.vehiclenum,
//           style: const TextStyle(color: Colors.black),
//         ),
//       ),
//       body: myIcon == null
//           ? Center(child: const CircularProgressIndicator())
//           : Column(
//                     children: [
//                       Expanded(
//                         child: Stack(children: [
//                         StreamBuilder(
//               stream: getLatLng(),
//               builder: (context, snapshot) {
//                 iconapi();
//                   final latLng = snapshot.data ?? const LatLng(40.876, 77.987);
//                 if (snapshot.hasData) {
//                   return   GoogleMap(
//                             onMapCreated: (GoogleMapController controller) {
//                               controller.showMarkerInfoWindow(
//                                   const MarkerId('Marker1'));
//                               _controller.complete(controller);
//                               controller.animateCamera(
//                                 CameraUpdate.newCameraPosition(
//                                   CameraPosition(
//                                     target: latLng,
//                                     zoom: 14.0,
//                                     bearing: 360.0,
//                                     tilt: 45.0,
//                                   ),
//                                 ),
//                               );
//                               setState(
//                                 () {},
//                               );
//                             },
//                             myLocationEnabled: true,
//                             myLocationButtonEnabled: true,
//                             compassEnabled: true,
//                             tiltGesturesEnabled: false,
//                             polylines: <Polyline>{
//                               Polyline(
//                                 polylineId: const PolylineId('myPolyline'),
//                                 color: Colors.blue,
//                                 width: 5,
//                                 points: latlnglist,
//                               ),
//                             },
//                             markers: {
//                               Marker(
//                                   markerId: const MarkerId(
//                                     "Marker1",
//                                   ),
//                                   position:latLng,
//                                   infoWindow: InfoWindow(
//                                     title:
//                                         "SP:${speed.toString()} DT:$distance ",
//                                     snippet: "ED:$ed",
//                                   ),
//                                   icon: myIcon!),
//                               latlnglist.isEmpty
//                                   ? const Marker(markerId: MarkerId(""))
//                                   : Marker(
//                                       markerId: const MarkerId(
//                                         "Marker2",
//                                       ),
//                                       position: latlnglist.first,
//                                       icon: BitmapDescriptor.defaultMarker)
//                             },
//                             mapType: Normal == true
//                                 ? MapType.normal
//                                 : satellite == true
//                                     ? MapType.satellite
//                                     : Terrain == false
//                                         ? MapType.terrain
//                                         : MapType.normal,
//                             initialCameraPosition: CameraPosition(
//                               target: latLng
//                             ),
//                           );
//                           } else {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.purple,
//                     ),
//                   );
//                 }
//               },
//             ),
//                           Positioned(
//                             left: width(context) * 0.84,
//                             top: height(context) * 0.2,
//                             child: Column(
//                               children: [
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       traffic = !traffic;
//                                     });
//                                   },
//                                   child: Container(
//                                     height: 35,
//                                     width: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: const Center(
//                                         child: Icon(
//                                       Icons.more_horiz,
//                                       color: Colors.white,
//                                       size: 40,
//                                     )),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     _showPopupMenu(context);
//                                   },
//                                   child: Container(
//                                     height: 35,
//                                     width: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: const Center(
//                                         child: Icon(
//                                       Icons.view_agenda,
//                                       color: Colors.red,
//                                       size: 30,
//                                     )),
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 15,
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       MapUtils.openmap(4713.0961, 77.8353);
//                                     });
//                                   },
//                                   child: Container(
//                                     height: 35,
//                                     width: 45,
//                                     decoration: const BoxDecoration(
//                                         color: Colors.black,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(8))),
//                                     child: const Center(
//                                         child: Icon(
//                                       Icons.double_arrow_sharp,
//                                       color: Colors.white,
//                                       size: 30,
//                                     )),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Positioned(
//                             left: width(context) * 0.75,
//                             top: height(context) * 0.39,
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => playroo(
//                                           vid: widget.vid,
//                                         )));
//                               },
//                               child: Container(
//                                   height: 35,
//                                   width: 90,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(8))),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Center(
//                                       child: Text(
//                                         "Play Route",
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 12),
//                                       ),
//                                     ),
//                                   )),
//                             ),
//                           ),
//                           Positioned(
//                             top: height(context) * 0.05,
//                             child: GestureDetector(
//                               onTap: () {},
//                               child: Container(
//                                 height: 50,
//                                 width: 50,
//                                 child: ListView.builder(
//                                   itemCount: 1,
//                                   itemBuilder: (context, index) {
//                                     // String title = widget.items[index];
//                                     List<FocusedMenuItem> menuItems =
//                                         List.generate(
//                                       widget.items.length,
//                                       (index) => FocusedMenuItem(
//                                         title: Text(widget.items[index]),
//                                         onPressed: () {},
//                                       ),
//                                     );
//                                     return FocusedMenuHolder(
//                                         menuWidth:
//                                             MediaQuery.of(context).size.width *
//                                                 0.50,
//                                         // blurSize: 5.0,
//                                         // menuItemExtent: 45,
//                                         menuBoxDecoration: const BoxDecoration(
//                                           color:
//                                               Color.fromARGB(0, 255, 255, 255),
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(15.0)),
//                                         ),
//                                         duration:
//                                             const Duration(milliseconds: 100),
//                                         animateMenuItems: true,
//                                         blurBackgroundColor: Colors.black54,
//                                         openWithTap: true,
//                                         menuOffset: 10.0,
//                                         onPressed: () {},
//                                         menuItems: menuItems,
//                                         child: Container(
//                                             height: 45,
//                                             width: 22,
//                                             decoration: const BoxDecoration(
//                                                 color: Color.fromARGB(
//                                                     0, 255, 255, 255),
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(0))),
//                                             child: const Padding(
//                                                 padding: EdgeInsets.all(10.0),
//                                                 child: Icon(
//                                                   Icons.double_arrow_outlined,
//                                                   color: Colors.black,
//                                                   size: 27,
//                                                 ))));
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 0,
//                             right: 0,
//                             left: 0,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 IconButton(
//                                     onPressed: () {
//                                       setState(() {
//                                         isClicked = !isClicked;
//                                       });
//                                     },
//                                     icon: Icon(isClicked == false
//                                         ? Icons.keyboard_double_arrow_down_sharp
//                                         : Icons
//                                             .keyboard_double_arrow_up_sharp)),
//                               ],
//                             ),
//                           ),
//                           CustomInfoWindow(
//                             controller: _customInfoWindowController,
//                             height: 75,
//                             width: 150,
//                             offset: 50,
//                           ),
//                         ]),
//                       ),
//                       Container(
//                         width: width(context),
//                         height: isClicked == false ? null : 0,
//                         color: const Color.fromARGB(255, 255, 255, 255),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(
//                                     // height: 50,
//                                     width: width(context) * 0.35,
//                                     child: Text(
//                                       currentlocation,
//                                       style: const TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 8,
//                                   ),
//                                   Container(
//                                     height: height(context) * 0.09,
//                                     width: width(context) * 0.27,
//                                     decoration: const BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       // color: Colors.green,
//                                     ),
//                                     child: Image.asset(
//                                       "images/odo2.png",
//                                       fit: BoxFit.fill,
//                                     ),
//                                   ),
//                                   Text(
//                                     "       ${speed.toString()} km /h",
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 14),
//                                   ),
//                                   const SizedBox(
//                                     height: 10,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(
//                                 width: 20,
//                               ),
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 25,
//                                         backgroundColor:
//                                             Color.fromARGB(255, 235, 223, 117),
//                                         child: Icon(
//                                           Icons.fire_truck_rounded,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       Text(
//                                         widget.vehiclecondition,
//                                         style: const TextStyle(fontSize: 12),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context)
//                                               .push(MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const Reports(),
//                                           ));
//                                         },
//                                         child: const CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Color.fromARGB(
//                                               255, 255, 175, 173),
//                                           child: Icon(
//                                             Icons.report,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       const Text(
//                                         "Report",
//                                         style: TextStyle(fontSize: 12),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       const CircleAvatar(
//                                         radius: 25,
//                                         backgroundColor:
//                                             Color.fromARGB(255, 117, 235, 215),
//                                         child: Icon(
//                                           Icons.key,
//                                           color:
//                                               Color.fromARGB(255, 187, 184, 2),
//                                         ),
//                                       ),
//                                       Text(
//                                         widget.ignition,
//                                         style: const TextStyle(fontSize: 12),
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           Navigator.of(context)
//                                               .push(MaterialPageRoute(
//                                                   builder: (context) => play(
//                                                         vid: widget.vid,
//                                                       )));
//                                         },
//                                         child: const CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Color.fromARGB(
//                                               255, 173, 185, 255),
//                                           child: Icon(
//                                             Icons.history,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       const Text(
//                                         "History",
//                                         style: TextStyle(fontSize: 12),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Stack(
//                                         alignment: AlignmentDirectional.center,
//                                         children: [
//                                           Positioned(
//                                               child: InkWell(
//                                             onTap: (() {
//                                               showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return AlertDialog(
//                                                     content: Container(
//                                                       height: height(context) *
//                                                           0.15,
//                                                       width: double.infinity,
//                                                       decoration: const BoxDecoration(
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius
//                                                                       .circular(
//                                                                           40))),
//                                                       child: Column(
//                                                         children: [
//                                                           const SizedBox(
//                                                             height: 10,
//                                                           ),
//                                                           const Text(
//                                                             "Are You sure You Want on Relay ?",
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                             style: TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w700),
//                                                           ),
//                                                           const SizedBox(
//                                                             height: 40,
//                                                           ),
//                                                           Row(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .spaceAround,
//                                                             children: [
//                                                               ElevatedButton(
//                                                                   style:
//                                                                       ButtonStyle(
//                                                                           backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
//                                                                               255,
//                                                                               53,
//                                                                               64,
//                                                                               114)),
//                                                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                                                               RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(16.0),
//                                                                           ))),
//                                                                   onPressed:
//                                                                       () {},
//                                                                   child:
//                                                                       const Text(
//                                                                     "Yes",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontWeight:
//                                                                             FontWeight.w800),
//                                                                   )),
//                                                               ElevatedButton(
//                                                                   style:
//                                                                       ButtonStyle(
//                                                                           backgroundColor: MaterialStateProperty
//                                                                               .all(
//                                                                             const Color.fromARGB(
//                                                                                 255,
//                                                                                 202,
//                                                                                 245,
//                                                                                 228),
//                                                                           ),
//                                                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                                                                               RoundedRectangleBorder(
//                                                                             borderRadius:
//                                                                                 BorderRadius.circular(16.0),
//                                                                           ))),
//                                                                   onPressed:
//                                                                       () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   },
//                                                                   child:
//                                                                       const Text(
//                                                                     "No",
//                                                                     style: TextStyle(
//                                                                         color: Colors
//                                                                             .black,
//                                                                         fontWeight:
//                                                                             FontWeight.w800),
//                                                                   ))
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   );
//                                                 },
//                                               );
//                                             }),
//                                             child: const CircleAvatar(
//                                               backgroundColor: Color.fromARGB(
//                                                   255, 236, 169, 169),
//                                               radius: 22,
//                                               child: Icon(
//                                                 Icons.lock,
//                                                 color: Colors.black,
//                                                 // size: 45,
//                                               ),
//                                             ),
//                                           ))
//                                         ],
//                                       ),
//                                       const Text("Relay")
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       GestureDetector(
//                                         onTap: () {
//                                           launchUrl(Uri.parse(
//                                               'https://www.globalgps.in/'));
//                                         },
//                                         child: const CircleAvatar(
//                                           radius: 25,
//                                           backgroundColor: Color.fromARGB(
//                                               255, 235, 223, 117),
//                                           child: Icon(
//                                             Icons.screen_share_rounded,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                       ),
//                                       const Text(
//                                         "Links",
//                                         style: TextStyle(fontSize: 12),
//                                       )
//                                     ],
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: width(context),
//                         color: Colors.white,
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       const Buy_GPS().navigateTo(context);
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 25,
//                                       backgroundColor:
//                                           Color.fromARGB(255, 173, 255, 210),
//                                       child: Icon(
//                                         Icons.shopify_outlined,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                   const Text(
//                                     "New GPS",
//                                     style: TextStyle(fontSize: 12),
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       const Fastag().navigateTo(context);
//                                     },
//                                     child: const CircleAvatar(
//                                       radius: 25,
//                                       backgroundColor:
//                                           Color.fromARGB(255, 174, 250, 155),
//                                       child: Icon(
//                                         Icons.tag,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ),
//                                   const Text(
//                                     "Fastag",
//                                     style: TextStyle(fontSize: 12),
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 children: const [
//                                   CircleAvatar(
//                                     radius: 25,
//                                     backgroundColor:
//                                         Color.fromARGB(255, 255, 173, 237),
//                                     child: Icon(
//                                       Icons.offline_bolt_sharp,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Fuel",
//                                     style: TextStyle(fontSize: 12),
//                                   )
//                                 ],
//                               ),
//                               Column(
//                                 children: const [
//                                   CircleAvatar(
//                                     radius: 25,
//                                     backgroundColor:
//                                         Color.fromARGB(255, 177, 177, 177),
//                                     child: Icon(
//                                       Icons.location_on,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   Text(
//                                     "Live",
//                                     style: TextStyle(fontSize: 12),
//                                   ),
//                                 ],
//                               ),
//                             ]),
//                       ),
//                     ],
//                   ),
                
//     );
//   }

//   // void _setInitialZoom() async {
//   //   await Future.delayed(Duration(seconds: 2)); // wait for 2 seconds
//   //   setState(() {
//   //     _zoomLevel = 16; // set zoom level to 9.0 after 2 seconds
//   //   });
//   //   _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//   //       target: snapshot.data ??  LatLng(widget.latitude, widget.longitude), zoom: _zoomLevel)));
//   // }
// }
