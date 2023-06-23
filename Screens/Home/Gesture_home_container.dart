// import 'dart:async';
// import 'dart:collection';
// import 'dart:convert';

// // import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// import 'package:flutter/material.dart';
// import 'package:focused_menu/focused_menu.dart';
// import 'package:focused_menu/modals.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:gpsglobe/Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
// import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/reports.dart';
// import 'package:gpsglobe/extensions/extensions.dart';
// import 'package:gpsglobe/map/playroute2.dart';
// import 'package:location/location.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:custom_info_window/custom_info_window.dart';
// import 'package:http/http.dart' as http;
// import '../../Constant.dart';
// import '../more_in_tabbar.dart/inside_more/Fastag.dart/Fastag.dart';

// // flutter polyline points
// // ignore: camel_case_types
// class Home_container_map extends StatefulWidget {
//   Home_container_map({
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
//   State<Home_container_map> createState() => _Home_container_mapState();
// }

// // ignore: camel_case_types
// class _Home_container_mapState extends State<Home_container_map> {
//   static const LatLng sourcelocation = LatLng(
//     11.2588,
//     75.7804,
//   );
//   static const LatLng Destination = LatLng(13.0961, 77.8353);

//   List<LatLng> polylineCoordinates = [
//     const LatLng(45.523064, -122.676483),
//     const LatLng(45.523065, -122.676484),
//     const LatLng(45.523066, -122.676485),
//     const LatLng(45.521016, -122.684523),
//     const LatLng(45.519577, -122.685706),
//     const LatLng(45.519042, -122.685849),
//     const LatLng(45.518583, -122.684574),
//     const LatLng(45.518299, -122.683485),
//     const LatLng(45.518296, -122.683485),
//     const LatLng(45.517587, -122.682020),
//     const LatLng(45.517584, -122.682015),
//   ];
//   List<LatLng> points = [
//     const LatLng(19.0759837, 72.8776559),
//     const LatLng(28.679079, 77.069710),
//     const LatLng(26.850000, 80.949997),
//     const LatLng(19.0759837, 72.8776559),
//   ];

//   final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

//   late LocationData currentLocation;
//   void getCurrentLocation() {
//     Location location = Location();

//     location.getLocation().then((location) => currentLocation = location);
//     location.onLocationChanged.listen((newLoc) {
//       currentLocation = newLoc;
//       // setState(() {});
//     });
//   }

//   void getPolypoints() async {
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
//         PointLatLng(Destination.latitude, Destination.longitude));
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng points) {
//         polylineCoordinates.add(LatLng(points.latitude, points.longitude));
//       });
//       setState(() {});
//     }
//   }

//   BitmapDescriptor? myIcon;
//   final Set<Polygon> _polygon = HashSet<Polygon>();
//   @override
//   void initState() {
//     BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
//             mipmaps: true)
//         .then((onValue) {
//       myIcon = onValue;
//     });
//     _polygon.add(Polygon(
//       // given polygonId
//       polygonId: const PolygonId('1'),
//       // initialize the list of points to display polygon
//       points: points,
//       // given color to polygon
//       fillColor: Colors.green.withOpacity(0.3),
//       // given border color to polygon
//       strokeColor: Colors.green,
//       geodesic: true,
//       // given width of border
//       strokeWidth: 4,
//     ));
//     getPolypoints();
//     getCurrentLocation();
//     super.initState();
//     _updateLocation(widget.latitude, widget.longitude);
//   }

//   late GoogleMapController _mapController;

//   bool Normal = true;
//   bool satellite = true;
//   bool Terrain = true;
//   bool loc = true;
//   bool isClicked = false;
//   bool traffic = false;

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

//       if (value != null);
//     });
//   }

//   Set<Circle> circles = {
//     const Circle(
//       circleId: CircleId("id"),
//       strokeColor: Color.fromARGB(255, 170, 203, 231),
//       fillColor: Color.fromARGB(255, 130, 186, 231),
//       strokeWidth: 1,
//       visible: true,
//       center: LatLng(11.2588, 75.7804),
//       radius: 300,
//     )
//   };

//   final CustomInfoWindowController _customInfoWindowController =
//       CustomInfoWindowController();

//   final LatLng _latLng = const LatLng(28.7041, 77.1025);
//   final Set<Marker> _markers = {};
//   // CountDownController controller = CountDownController();
//   // CountDownController controller1 = CountDownController();

//   LatLng? _currentLocation;
//   List<LatLng> _polylineCoordinates = [];

//   void _updateLocation(double latitude, double longitude) {
//     setState(() {
//       _currentLocation = LatLng(latitude, longitude);
//       _polylineCoordinates.add(_currentLocation!);
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _customInfoWindowController.dispose();
//   }

//   double _zoomLevel = 11.3;

//   @override
//   Widget build(BuildContext context) {
//     _markers.add(
//       Marker(
//         markerId: const MarkerId("marker_id"),
//         position: _latLng,
//         onTap: () {
//           _customInfoWindowController.addInfoWindow!(
//             Column(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     width: double.infinity,
//                     height: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const [
//                           Icon(
//                             Icons.account_circle,
//                             color: Color.fromARGB(255, 212, 182, 182),
//                             size: 30,
//                           ),
//                           SizedBox(
//                             width: 8.0,
//                           ),
//                           Text(
//                             "I am here",
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 // Triangle.isosceles(
//                 //   edge: Edge.BOTTOM,
//                 //   child: Container(
//                 //     color: Colors.blue,
//                 //     width: 20.0,
//                 //     height: 10.0,
//                 //   ),
//                 // ),
//               ],
//             ),
//             _latLng,
//           );
//         },
//       ),
//     );
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.vehiclenum),
//         ),
//         body: myIcon == null
//             ? const Center(child: CircularProgressIndicator())
//             : Column(
//                 children: [
//                   Expanded(
//                     flex: 3,
//                     child: Stack(
//                       children: [
//                         GoogleMap(
//                             onMapCreated:
//                                 (GoogleMapController controller) async {
//                               _mapController = controller;
//                               _customInfoWindowController.googleMapController =
//                                   controller;
//                               _setInitialZoom();
//                             },
//                             onTap: (position) {
//                               _customInfoWindowController.hideInfoWindow!();
//                             },
//                             // trafficEnabled: traffic ? true : false,
//                             // indoorViewEnabled: false,
//                             // mapType: Normal == true
//                             //     ? MapType.normal
//                             //     : satellite == true
//                             //         ? MapType.satellite
//                             //         : Terrain == false
//                             //             ? MapType.terrain
//                             //             : MapType.normal,
//                             initialCameraPosition: CameraPosition(
//                                 target:
//                                     LatLng(widget.latitude, widget.longitude),
//                                 zoom: _zoomLevel),
//                             polylines: _polylineCoordinates.isNotEmpty
//                                 ? {
//                                     Polyline(
//                                       polylineId: PolylineId('user_route'),
//                                       points: _polylineCoordinates,
//                                       color: Colors.red,
//                                       width: 5,
//                                     ),
//                                   }
//                                 : Set(),
//                             // polylines: {
//                             //   Polyline(
//                             //     polylineId: const PolylineId("route"),
//                             //     points: polylineCoordinates,
//                             //     color: const Color.fromARGB(255, 13, 112, 192),
//                             //     width: 4,
//                             //   ),
//                             // },
//                             //              markers: _currentLocation != null
//                             // ? [
//                             //     Marker(
//                             //       markerId: MarkerId('current_location'),
//                             //       position: _currentLocation!,
//                             //       icon: BitmapDescriptor.defaultMarkerWithHue(
//                             //           BitmapDescriptor.hueBlue),
//                             //     ),
//                             //   ].toSet()
//                             // : Set(),
//                             markers: loc == true
//                                 ? {
//                                     Marker(
//                                         markerId: const MarkerId("marker_id"),
//                                         position: LatLng(
//                                             widget.latitude, widget.longitude),
//                                         onTap: () {},
//                                         // icon: ,
//                                         icon: myIcon!),

//                                     // Marker(
//                                     //   markerId: const MarkerId("Source"),
//                                     //   position: sourcelocation,
//                                     //   icon: myIcon!,
//                                     //   onTap: () {
//                                     //     _customInfoWindowController
//                                     //         .addInfoWindow!(
//                                     //       Column(
//                                     //         children: [
//                                     //           Expanded(
//                                     //             child: Container(
//                                     //               decoration: BoxDecoration(
//                                     //                 color: const Color.fromARGB(
//                                     //                     190, 255, 255, 255),
//                                     //                 borderRadius:
//                                     //                     BorderRadius.circular(
//                                     //                         4),
//                                     //               ),
//                                     //               width: double.infinity,
//                                     //               // height: 50,
//                                     //               child: const Text(
//                                     //                 "Postmaster, Post Office CALICUT (HEAD OFFICE), KOZHIKODE, KERALA (KL), India (IN), Pin Code:- 673001",
//                                     //               ),
//                                     //             ),
//                                     //           ),
//                                     //           // Triangle.isosceles(
//                                     //           //   edge: Edge.BOTTOM,
//                                     //           //   child: Container(
//                                     //           //     color: Colors.blue,
//                                     //           //     width: 20.0,
//                                     //           //     height: 10.0,
//                                     //           //   ),
//                                     //           // ),
//                                     //         ],
//                                     //       ),
//                                     //       sourcelocation,
//                                     //     );
//                                     //   },
//                                     // ),
//                                     // Marker(
//                                     //   markerId: MarkerId("current location"),
//                                     //   position: LatLng(
//                                     //       currentLocation.latitude!,
//                                     //       currentLocation.longitude!),
//                                     //   icon: BitmapDescriptor.defaultMarker,
//                                     // ),

//                                     // const Marker(
//                                     //   markerId: MarkerId("Destination"),
//                                     //   position: Destination,
//                                     //   icon: BitmapDescriptor.defaultMarker,
//                                     // ),
//                                     // const Marker(
//                                     //   markerId: MarkerId("Destination"),
//                                     //   position: Destination,
//                                     // ),
//                                   }
//                                 : {
//                                     // const Marker(
//                                     //   markerId: MarkerId("Destination"),
//                                     //   position: Destination,
//                                     // ),
//                                     // const Marker(
//                                     //   markerId: MarkerId("Destination"),
//                                     //   position: Destination,
//                                     // ),
//                                   }),
//                         Positioned(
//                           left: width(context) * 0.84,
//                           top: height(context) * 0.2,
//                           child: Column(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     traffic = !traffic;
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 35,
//                                   width: 45,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(8))),
//                                   child: const Center(
//                                       child: Icon(
//                                     Icons.more_horiz,
//                                     color: Colors.white,
//                                     size: 40,
//                                   )),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   _showPopupMenu(context);
//                                 },
//                                 child: Container(
//                                   height: 35,
//                                   width: 45,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(8))),
//                                   child: const Center(
//                                       child: Icon(
//                                     Icons.view_agenda,
//                                     color: Colors.red,
//                                     size: 30,
//                                   )),
//                                 ),
//                               ),
//                               const SizedBox(
//                                 height: 15,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     MapUtils.openmap(4713.0961, 77.8353);
//                                   });
//                                 },
//                                 child: Container(
//                                   height: 35,
//                                   width: 45,
//                                   decoration: const BoxDecoration(
//                                       color: Colors.black,
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(8))),
//                                   child: const Center(
//                                       child: Icon(
//                                     Icons.double_arrow_sharp,
//                                     color: Colors.white,
//                                     size: 30,
//                                   )),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         // Positioned(
//                         //   left: width(context) * 0.75,
//                         //   top: height(context) * 0.39,
//                         //   child: GestureDetector(
//                         //     onTap: () {
//                         //       Navigator.of(context).push(MaterialPageRoute(
//                         //           builder: (context) => play(
//                         //                 vid: widget.vid,
//                         //               )));

//                         //       // Navigator.of(context).push(MaterialPageRoute(
//                         //       //   builder: (context) =>
//                         //       //       MapScreen(vid: widget.vid),
//                         //       // ));
//                         //     },
//                         //     child: Container(
//                         //         height: 35,
//                         //         width: 90,
//                         //         decoration: const BoxDecoration(
//                         //             color: Colors.black,
//                         //             borderRadius:
//                         //                 BorderRadius.all(Radius.circular(8))),
//                         //         child: const Padding(
//                         //           padding: EdgeInsets.all(8.0),
//                         //           child: Center(
//                         //             child: Text(
//                         //               "Play Route",
//                         //               style: TextStyle(color: Colors.white),
//                         //             ),
//                         //           ),
//                         //         )),
//                         //   ),
//                         // ),
//                         Positioned(
//                           top: height(context) * 0.05,
//                           child: GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               height: 50,
//                               width: 50,
//                               child: ListView.builder(
//                                 itemCount: 1,
//                                 itemBuilder: (context, index) {
//                                   // String title = widget.items[index];
//                                   List<FocusedMenuItem> menuItems =
//                                       List.generate(
//                                     widget.items.length,
//                                     (index) => FocusedMenuItem(
//                                       title: Text(widget.items[index]),
//                                       onPressed: () {},
//                                     ),
//                                   );
//                                   return FocusedMenuHolder(
//                                       menuWidth:
//                                           MediaQuery.of(context).size.width *
//                                               0.50,
//                                       // blurSize: 5.0,
//                                       // menuItemExtent: 45,
//                                       menuBoxDecoration: const BoxDecoration(
//                                         color: Color.fromARGB(0, 255, 255, 255),
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(15.0)),
//                                       ),
//                                       duration:
//                                           const Duration(milliseconds: 100),
//                                       animateMenuItems: true,
//                                       blurBackgroundColor: Colors.black54,
//                                       openWithTap: true,
//                                       menuOffset: 10.0,
//                                       onPressed: () {},
//                                       menuItems: menuItems,
//                                       child: Container(
//                                           height: 45,
//                                           width: 22,
//                                           decoration: const BoxDecoration(
//                                               color: Color.fromARGB(
//                                                   0, 255, 255, 255),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(0))),
//                                           child: const Padding(
//                                               padding: EdgeInsets.all(10.0),
//                                               child: Icon(
//                                                 Icons.double_arrow_outlined,
//                                                 color: Colors.black,
//                                                 size: 27,
//                                               ))));
//                                 },
//                               ),
//                             ),
//                             //  FocusedMenuHolder(
//                             //   animateMenuItems: true,
//                             //   openWithTap: true,
//                             //   blurSize: 0,
//                             //   menuWidth:
//                             //       MediaQuery.of(context).size.width * 0.50,
//                             //   // blurBackgroundColor:
//                             //   // Color.fromARGB(255, 255, 255, 255),
//                             //   onPressed: () {},
//                             //   menuItems: [

//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV7623"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV9876"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV4856"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV9684"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV0909"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV7579"),
//                             //         onPressed: () {}),
//                             //     FocusedMenuItem(
//                             //         title: const Text("Gj06AV7454"),
//                             //         onPressed: () {}),
//                             //   ],
//                             //   child: Container(
//                             //       // height: 45,
//                             //       // width: 50,
//                             //       decoration: const BoxDecoration(
//                             //           color: Color.fromARGB(255, 67, 70, 100),
//                             //           borderRadius:
//                             //               BorderRadius.all(Radius.circular(0))),
//                             //       child: const Padding(
//                             //           padding: EdgeInsets.all(10.0),
//                             //           child: Icon(
//                             //             Icons.double_arrow_outlined,
//                             //             color: Colors.white,
//                             //             size: 27,
//                             //           ))),
//                             // ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           left: 0,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       isClicked = !isClicked;
//                                     });
//                                   },
//                                   icon: Icon(isClicked == false
//                                       ? Icons.keyboard_double_arrow_down_sharp
//                                       : Icons.keyboard_double_arrow_up_sharp)),
//                               // MaterialButton(
//                               //     color: Colors.white,
//                               //     onPressed: () {
//                               //       setState(() {
//                               //         isClicked = !isClicked;
//                               //       });
//                               //     },
//                               //     child: Icon(isClicked == false
//                               //         ? Icons.keyboard_double_arrow_down_sharp
//                               //         : Icons.keyboard_double_arrow_up_sharp)),
//                             ],
//                           ),
//                         ),
//                         CustomInfoWindow(
//                           controller: _customInfoWindowController,
//                           height: 75,
//                           width: 150,
//                           offset: 50,
//                         ),
//                       ],
//                     ),
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
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
//                                       widget.location,
//                                       style: TextStyle(fontSize: 12),
//                                     ),
//                                   ),
//                                   SizedBox(
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
//                                     "       ${widget.km} km /h",
//                                     style: TextStyle(
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
//                                           // Navigator.of(context)
//                                           //     .push(MaterialPageRoute(
//                                           //         builder: (context) => play(
//                                           //               vid: widget.vid,
//                                           //             )));
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
//                                                                       () {
//                                                                     // setState(
//                                                                     //     () {
//                                                                     //   controller
//                                                                     //       .start();
//                                                                     //   Navigator.pop(
//                                                                     //       context);
//                                                                     // });
//                                                                   },
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
//                                   SizedBox(
//                                     height: 5,
//                                   ),
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
//                                   // SizedBox(
//                                   //   height: 5,
//                                   // )
//                                 ],
//                               ),
//                             ]),
//                       ),
//                     ],
//                   )
//                 ],
//               ));
//   }

//   void _setInitialZoom() async {
//     await Future.delayed(Duration(seconds: 2)); // wait for 2 seconds
//     setState(() {
//       _zoomLevel = 25; // set zoom level to 9.0 after 2 seconds
//     });
//     _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: LatLng(widget.latitude, widget.longitude), zoom: _zoomLevel)));
//   }
// }

// class MapUtils {
//   MapUtils._();
//   static void openmap(
//     double latitude,
//     double longitude,
//   ) {
//     String googleMapUrl =
//         "https://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination=12.971599,77.594566";
//     launch(googleMapUrl);
//     // if ( await canLaunch(googleMapUrl)) {
//     //    launch(googleMapUrl);
//     // } else {
//     //   throw 'could not load';
//     // }
//   }
// }








// class MyMap extends StatefulWidget {
//   @override
//   _MyMapState createState() => _MyMapState();
// }

// class _MyMapState extends State<MyMap> {
//   List<dynamic> _data = [];
//   List<LatLng> _points = [];
//   bool _isLoading = true;
//   LatLng? _markerLocation;

//   BitmapDescriptor? myIcon;
//   late Marker _marker;
//   Future<void> _fetchData() async {
//     final response = await http.get(Uri.parse(
//         'http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/26100/2023-02-14 12:02:19/2023-02-15 12:02:19'));
//     final extractedData = json.decode(response.body);

//     setState(() {
//       _data = extractedData["historyData"];
//     });
//   }

//   void _drawPolyline() {
//     for (var data in _data) {
//       double lat = double.parse(data['latitude']);
//       double lng = double.parse(data['longitude']);
//       _points.add(LatLng(lat, lng));
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     setInitialMarkerLocation();
//     _fetchData().then((_) => _drawPolyline());
//     BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
//             mipmaps: true)
//         .then((onValue) {
//       myIcon = onValue;
//     });
//   }

//   void setInitialMarkerLocation() {
//     if (_points.isNotEmpty) {
//       _markerLocation = _points.first;
//       // _markerLocation = _points.last;
//       _marker = Marker(
//         markerId: const MarkerId('marker'),
//         position: _markerLocation!,
//         rotation: 2.0,
//         icon: BitmapDescriptor.defaultMarker,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       body: _isLoading && myIcon == null
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : GoogleMap(
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(13.0461, 77.50624),
//                 zoom: 15,
//               ),
//               markers: {_marker},
//               polylines: {
//                 Polyline(
//                   polylineId: const PolylineId('route'),
//                   points: _points,
//                   color: Colors.blue,
//                   width: 5,
//                 ),
//               },
//             ),
//     );
//   }
// }


// class MapScreen extends StatefulWidget {
//   String vid;
//   MapScreen({super.key, required this.vid});

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   final Completer<GoogleMapController> _controller = Completer();

//   List<LatLng> latLonList = [];

//   late Marker _marker;
//   late Marker marker2;
//   LatLng? _markerLocation;
//   LatLng? _finalmarkerLocation;
//   int _polylineIndex = 0;
//   BitmapDescriptor? myIcon;

//   @override
//   void initState() {
//     super.initState();
//     setInitialMarkerLocation();
//     setfinalMarkerLocation();
//     moveMarker();
//     hist(widget.vid);
//     BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
//             mipmaps: true)
//         .then((onValue) {
//       myIcon = onValue;
//     });
//   }

//   ///history api

//   hist(String vide) async {
//     var res = await http.get(Uri.parse(
//         "http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/$vide/2023-02-13%2012:02:19/2023-02-17%2012:02:19"));
//     var latilong = [];
//     if (res.statusCode == 200) {
//       var response = jsonDecode(res.body);
//       latilong = response["historyData"];
      
//       for (int i = 0; i < latilong.length - 1; i++) {
//         if (latilong.isNotEmpty) {
//           double lat = double.parse(latilong[i]['latitude']);
//           double lng = double.parse(latilong[i]['longitude']);
//           latLonList.add(LatLng(lat, lng));
//           if (latLonList.length == latilong.length) {
//             List<String> latLngStrings =
//                 latLonList.map((latLon) => latLon.toString()).toList();
//             latLonList == latLngStrings;
            
//           }
//         }
//       }
//     } else {
    
//     }
//   }

//   bool run = false;

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     // _controller.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Map Screen'),
//       ),
//       body: Stack(children: [
//         latLonList.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : GoogleMap(
//                 mapType: MapType.normal,
//                 initialCameraPosition: CameraPosition(
//                   target: latLonList.first,
//                   zoom: 14,
//                 ),
//                 polylines: {
//                   Polyline(
//                     polylineId: const PolylineId('polyline'),
//                     color: Colors.blue,
//                     points: latLonList,
//                     width: 2,
//                   ),
//                 },
//                 markers: {
//                   _marker,
//                   // marker2,
//                 },
//                 onMapCreated: (GoogleMapController controller) {
//                   _controller.complete(controller);
//                 },
//               ),
//         Positioned(
//           left: width(context) * 0.84,
//           top: height(context) * 0.39,
//           child: GestureDetector(
//             onTap: () {
//               run == false ? moveMarker() : null;
//               run == true;
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) => Playroute_history(
//               //           vehiclenum: "}",
//               //           speed: "0",
//               //           // speed: "${widget.speedkm}",
//               //         )));
//             },
//             child: Container(
//                 height: 35,
//                 width: 45,
//                 decoration: const BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.all(Radius.circular(8))),
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(
//                       "Play",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 )),
//           ),
//         ),
//       ]),
//     );
//   }

//   void setInitialMarkerLocation() {
//     if (latLonList.isNotEmpty) {
//       _markerLocation = latLonList.first;
//       // _markerLocation = latLonList.last;
//       _marker = Marker(
//         markerId: const MarkerId('marker'),
//         position: _markerLocation!,
//         rotation: 2.0,
//         icon: myIcon!,
//       );
//     }
//   }

//   void setfinalMarkerLocation() {
//     if (latLonList.isNotEmpty) {
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
//     Timer.periodic(const Duration(seconds: 2), (timer) {
//       setState(() {
//         if (_polylineIndex < latLonList.length - 1) {
//           _polylineIndex++;
//         } else {
//           _polylineIndex = 0;
//         }
//         _markerLocation = latLonList[_polylineIndex];
//         _marker = Marker(
//           draggable: true,
//           markerId: const MarkerId('marker'),
//           position: _markerLocation!,
//           icon: myIcon!,
//           // icon: BitmapDescriptor.defaultMarker,
//           anchor: const Offset(1.0, 1.0),
//         );
//         polylines:
//         {
//           Polyline(
//             polylineId: const PolylineId('polyline'),
//             color: Colors.blue,
//             points: latLonList,
//             width: 2,
//           );
//         }
//         ;
//       });
//     });
//   }
// }

// ///
// ///
// ///

// ///

// class LatLon {
//   final String lat;
//   final String lng;

//   LatLon(this.lat, this.lng);

//   @override
//   String toString() {
//     return 'LatLng($lat, $lng)';
//   }
// }

// //   void moveMarker2() {
// //   Timer.periodic(const Duration(milliseconds: 600), (timer) {
// //     setState(() {
// //       if (_polylineIndex < latLonList.length - 1) {
// //         _polylineIndex++;
// //       } else {
// //         _polylineIndex = 0;
// //       }
// //       LatLng nextLocation = latLonList[_polylineIndex];
// //       double bearing = _calculateBearing(_markerLocation!, nextLocation);
// //       _markerLocation = nextLocation;
// //       _marker = _marker.copyWith(
// //         positionParam: _markerLocation!,
// //         rotationParam: bearing,
// //       );
// //     });
// //   });
// // }

// // double _calculateBearing(LatLng start, LatLng end) {
// //   double lat1 = radians;
// //   double lon1 = radians;
// //   double lat2 = radians;
// //   double lon2 = radians;
// //   double y = sin(lon2 - lon1) * cos(lat2);
// //   double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1);
// //   int bearing = degrees;
// //   return (bearing + 360) % 360;
// // }

// /// remove later

// // class MyMapScreen extends StatefulWidget {
// //   final double initialLat;
// //   final double initialLon;

// //   const MyMapScreen(
// //       {Key? key, required this.initialLat, required this.initialLon})
// //       : super(key: key);

// //   @override
// //   _MyMapScreenState createState() => _MyMapScreenState();
// // }

// // class _MyMapScreenState extends State<MyMapScreen> {
// //   Completer<GoogleMapController> _controller = Completer();
// //   StreamController<LatLng> _streamController = StreamController<LatLng>();
// //   LatLng _currentLocation = LatLng(0, 0);
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     _currentLocation = LatLng(widget.initialLat, widget.initialLon);
// //   }

// //   @override
// //   void dispose() {
// //     _streamController.close();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: GoogleMap(
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(widget.initialLat, widget.initialLon),
// //           zoom: 13.0,
// //         ),
// //         markers: [
// //           Marker(
// //             markerId: MarkerId('current_location'),
// //             position: _currentLocation,
// //             icon:
// //                 BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
// //           ),
// //         ].toSet(),
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller.complete(controller);
// //         },
// //         myLocationEnabled: true,
// //         myLocationButtonEnabled: false,
// //         compassEnabled: false,
// //         zoomControlsEnabled: false,
// //         onTap: (LatLng location) {
// //           _streamController.add(location);
// //         },
// //       ),
// //     );
// //   }
// // }











// //recovery




// // import 'dart:async';
// // import 'dart:collection';
// // import 'dart:convert';

// // // import 'package:circular_countdown_timer/circular_countdown_timer.dart';

// // import 'package:flutter/material.dart';
// // import 'package:focused_menu/focused_menu.dart';
// // import 'package:focused_menu/modals.dart';
// // import 'package:globegps/Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
// // import 'package:globegps/Screens/Drawer_inside_pages/Report/reports.dart';
// // import 'package:globegps/extensions/extensions.dart';
// // import 'package:globegps/map/playroute2.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:location/location.dart';
// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:custom_info_window/custom_info_window.dart';
// // import 'package:http/http.dart' as http;
// // import '../../Constant.dart';
// // import '../more_in_tabbar.dart/inside_more/Fastag.dart/Fastag.dart';

// // // flutter polyline points
// // // ignore: camel_case_types
// // class Home_container_map extends StatefulWidget {
// //   Home_container_map({
// //     super.key,
// //     required this.vehiclenum,
// //     required this.speed,
// //     required this.vehiclecondition,
// //     required this.ignition,
// //     required this.vid,
// //     required this.latitude,
// //     required this.longitude,
// //     required this.items,
// //     required this.location,
// //     required this.km,
// //   });
// //   double latitude;
// //   double longitude;
// //   String location;
// //   int km;
// //   String vehiclenum;
// //   String vehiclecondition;
// //   var ignition;
// //   var speed;
// //   String vid;
// //   final List<String> items;

// //   @override
// //   State<Home_container_map> createState() => _Home_container_mapState();
// // }

// // // ignore: camel_case_types
// // class _Home_container_mapState extends State<Home_container_map> {
// //   static const LatLng sourcelocation = LatLng(
// //     11.2588,
// //     75.7804,
// //   );
// //   static const LatLng Destination = LatLng(13.0961, 77.8353);

// //   List<LatLng> polylineCoordinates = [
// //     const LatLng(45.523064, -122.676483),
// //     const LatLng(45.523065, -122.676484),
// //     const LatLng(45.523066, -122.676485),
// //     const LatLng(45.521016, -122.684523),
// //     const LatLng(45.519577, -122.685706),
// //     const LatLng(45.519042, -122.685849),
// //     const LatLng(45.518583, -122.684574),
// //     const LatLng(45.518299, -122.683485),
// //     const LatLng(45.518296, -122.683485),
// //     const LatLng(45.517587, -122.682020),
// //     const LatLng(45.517584, -122.682015),
// //   ];
// //   List<LatLng> points = [
// //     const LatLng(19.0759837, 72.8776559),
// //     const LatLng(28.679079, 77.069710),
// //     const LatLng(26.850000, 80.949997),
// //     const LatLng(19.0759837, 72.8776559),
// //   ];

// //   final GlobalKey<PopupMenuButtonState<int>> _key = GlobalKey();

// //   late LocationData currentLocation;
// //   void getCurrentLocation() {
// //     Location location = Location();

// //     location.getLocation().then((location) => currentLocation = location);
// //     location.onLocationChanged.listen((newLoc) {
// //       currentLocation = newLoc;
// //       // setState(() {});
// //     });
// //   }

// //   void getPolypoints() async {
// //     PolylinePoints polylinePoints = PolylinePoints();
// //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //         googleAPiKey,
// //         PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
// //         PointLatLng(Destination.latitude, Destination.longitude));
// //     if (result.points.isNotEmpty) {
// //       result.points.forEach((PointLatLng points) {
// //         polylineCoordinates.add(LatLng(points.latitude, points.longitude));
// //       });
// //       setState(() {});
// //     }
// //   }

// //   BitmapDescriptor? myIcon;
// //   final Set<Polygon> _polygon = HashSet<Polygon>();
// //   @override
// //   void initState() {
// //     BitmapDescriptor.fromAssetImage(
// //             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
// //             mipmaps: true)
// //         .then((onValue) {
// //       myIcon = onValue;
// //     });
// //     _polygon.add(Polygon(
// //       // given polygonId
// //       polygonId: const PolygonId('1'),
// //       // initialize the list of points to display polygon
// //       points: points,
// //       // given color to polygon
// //       fillColor: Colors.green.withOpacity(0.3),
// //       // given border color to polygon
// //       strokeColor: Colors.green,
// //       geodesic: true,
// //       // given width of border
// //       strokeWidth: 4,
// //     ));
// //     getPolypoints();
// //     getCurrentLocation();
// //     super.initState();
// //     _updateLocation(widget.latitude, widget.longitude);
// //   }

// //   late GoogleMapController _mapController;

// //   bool Normal = true;
// //   bool satellite = true;
// //   bool Terrain = true;
// //   bool loc = true;
// //   bool isClicked = false;
// //   bool traffic = false;

// //   void _showPopupMenu(BuildContext context) async {
// //     await showMenu(
// //       context: context,
// //       position:
// //           RelativeRect.fromLTRB(width(context), height(context) * 0.45, 0, 0),
// //       items: [
// //         PopupMenuItem(
// //           onTap: () {
// //             setState(() {
// //               Normal = true;
// //               satellite = false;
// //               Terrain = false;
// //             });
// //           },
// //           value: 1,
// //           child: const Text("Normal"),
// //         ),
// //         PopupMenuItem(
// //           onTap: () {
// //             setState(() {
// //               Normal = false;
// //               satellite = true;
// //               Terrain = false;
// //             });
// //           },
// //           value: 2,
// //           child: const Text("Satellite"),
// //         ),
// //         PopupMenuItem(
// //           onTap: () {
// //             setState(() {
// //               Normal = false;
// //               satellite = false;
// //               Terrain = false;
// //             });
// //           },
// //           value: 3,
// //           child: const Text("Terrain"),
// //         ),
// //       ],
// //       elevation: 8.0,
// //     ).then((value) {
// // // NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

// //       if (value != null) ;
// //     });
// //   }

// //   Set<Circle> circles = {
// //     const Circle(
// //       circleId: CircleId("id"),
// //       strokeColor: Color.fromARGB(255, 170, 203, 231),
// //       fillColor: Color.fromARGB(255, 130, 186, 231),
// //       strokeWidth: 1,
// //       visible: true,
// //       center: LatLng(11.2588, 75.7804),
// //       radius: 300,
// //     )
// //   };

// //   final CustomInfoWindowController _customInfoWindowController =
// //       CustomInfoWindowController();

// //   final LatLng _latLng = const LatLng(28.7041, 77.1025);
// //   final Set<Marker> _markers = {};
// //   // CountDownController controller = CountDownController();
// //   // CountDownController controller1 = CountDownController();

// //   LatLng? _currentLocation;
// //   List<LatLng> _polylineCoordinates = [];

// //   void _updateLocation(double latitude, double longitude) {
// //     setState(() {
// //       _currentLocation = LatLng(latitude, longitude);
// //       _polylineCoordinates.add(_currentLocation!);
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     _customInfoWindowController.dispose();
// //   }

// //   double _zoomLevel = 11.3;

// //   @override
// //   Widget build(BuildContext context) {
// //     _markers.add(
// //       Marker(
// //         markerId: const MarkerId("marker_id"),
// //         position: _latLng,
// //         onTap: () {
// //           _customInfoWindowController.addInfoWindow!(
// //             Column(
// //               children: [
// //                 Expanded(
// //                   child: Container(
// //                     decoration: BoxDecoration(
// //                       color: Colors.blue,
// //                       borderRadius: BorderRadius.circular(4),
// //                     ),
// //                     width: double.infinity,
// //                     height: double.infinity,
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(8.0),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: const [
// //                           Icon(
// //                             Icons.account_circle,
// //                             color: Color.fromARGB(255, 212, 182, 182),
// //                             size: 30,
// //                           ),
// //                           SizedBox(
// //                             width: 8.0,
// //                           ),
// //                           Text(
// //                             "I am here",
// //                           )
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 // Triangle.isosceles(
// //                 //   edge: Edge.BOTTOM,
// //                 //   child: Container(
// //                 //     color: Colors.blue,
// //                 //     width: 20.0,
// //                 //     height: 10.0,
// //                 //   ),
// //                 // ),
// //               ],
// //             ),
// //             _latLng,
// //           );
// //         },
// //       ),
// //     );
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text(widget.vehiclenum),
// //         ),
// //         body: myIcon == null
// //             ? const Center(child: CircularProgressIndicator())
// //             : Column(
// //                 children: [
// //                   Expanded(
// //                     flex: 3,
// //                     child: Stack(
// //                       children: [
// //                         GoogleMap(
// //                             onMapCreated:
// //                                 (GoogleMapController controller) async {
// //                               _mapController = controller;
// //                               _customInfoWindowController.googleMapController =
// //                                   controller;
// //                               _setInitialZoom();
// //                             },
// //                             onTap: (position) {
// //                               _customInfoWindowController.hideInfoWindow!();
// //                             },
// //                             // trafficEnabled: traffic ? true : false,
// //                             // indoorViewEnabled: false,
// //                             // mapType: Normal == true
// //                             //     ? MapType.normal
// //                             //     : satellite == true
// //                             //         ? MapType.satellite
// //                             //         : Terrain == false
// //                             //             ? MapType.terrain
// //                             //             : MapType.normal,
// //                             initialCameraPosition: CameraPosition(
// //                                 target:
// //                                     LatLng(widget.latitude, widget.longitude),
// //                                 zoom: _zoomLevel),
// //                             polylines: _polylineCoordinates.isNotEmpty
// //                                 ? {
// //                                     Polyline(
// //                                       polylineId: PolylineId('user_route'),
// //                                       points: _polylineCoordinates,
// //                                       color: Colors.red,
// //                                       width: 5,
// //                                     ),
// //                                   }
// //                                 : Set(),
// //                             // polylines: {
// //                             //   Polyline(
// //                             //     polylineId: const PolylineId("route"),
// //                             //     points: polylineCoordinates,
// //                             //     color: const Color.fromARGB(255, 13, 112, 192),
// //                             //     width: 4,
// //                             //   ),
// //                             // },
// //                             //              markers: _currentLocation != null
// //                             // ? [
// //                             //     Marker(
// //                             //       markerId: MarkerId('current_location'),
// //                             //       position: _currentLocation!,
// //                             //       icon: BitmapDescriptor.defaultMarkerWithHue(
// //                             //           BitmapDescriptor.hueBlue),
// //                             //     ),
// //                             //   ].toSet()
// //                             // : Set(),
// //                             markers: loc == true
// //                                 ? {
// //                                     Marker(
// //                                         markerId: const MarkerId("marker_id"),
// //                                         position: LatLng(
// //                                             widget.latitude, widget.longitude),
// //                                         onTap: () {},
// //                                         // icon: ,
// //                                         icon: myIcon!),

// //                                     // Marker(
// //                                     //   markerId: const MarkerId("Source"),
// //                                     //   position: sourcelocation,
// //                                     //   icon: myIcon!,
// //                                     //   onTap: () {
// //                                     //     _customInfoWindowController
// //                                     //         .addInfoWindow!(
// //                                     //       Column(
// //                                     //         children: [
// //                                     //           Expanded(
// //                                     //             child: Container(
// //                                     //               decoration: BoxDecoration(
// //                                     //                 color: const Color.fromARGB(
// //                                     //                     190, 255, 255, 255),
// //                                     //                 borderRadius:
// //                                     //                     BorderRadius.circular(
// //                                     //                         4),
// //                                     //               ),
// //                                     //               width: double.infinity,
// //                                     //               // height: 50,
// //                                     //               child: const Text(
// //                                     //                 "Postmaster, Post Office CALICUT (HEAD OFFICE), KOZHIKODE, KERALA (KL), India (IN), Pin Code:- 673001",
// //                                     //               ),
// //                                     //             ),
// //                                     //           ),
// //                                     //           // Triangle.isosceles(
// //                                     //           //   edge: Edge.BOTTOM,
// //                                     //           //   child: Container(
// //                                     //           //     color: Colors.blue,
// //                                     //           //     width: 20.0,
// //                                     //           //     height: 10.0,
// //                                     //           //   ),
// //                                     //           // ),
// //                                     //         ],
// //                                     //       ),
// //                                     //       sourcelocation,
// //                                     //     );
// //                                     //   },
// //                                     // ),
// //                                     // Marker(
// //                                     //   markerId: MarkerId("current location"),
// //                                     //   position: LatLng(
// //                                     //       currentLocation.latitude!,
// //                                     //       currentLocation.longitude!),
// //                                     //   icon: BitmapDescriptor.defaultMarker,
// //                                     // ),

// //                                     // const Marker(
// //                                     //   markerId: MarkerId("Destination"),
// //                                     //   position: Destination,
// //                                     //   icon: BitmapDescriptor.defaultMarker,
// //                                     // ),
// //                                     // const Marker(
// //                                     //   markerId: MarkerId("Destination"),
// //                                     //   position: Destination,
// //                                     // ),
// //                                   }
// //                                 : {
// //                                     // const Marker(
// //                                     //   markerId: MarkerId("Destination"),
// //                                     //   position: Destination,
// //                                     // ),
// //                                     // const Marker(
// //                                     //   markerId: MarkerId("Destination"),
// //                                     //   position: Destination,
// //                                     // ),
// //                                   }),
// //                         Positioned(
// //                           left: width(context) * 0.84,
// //                           top: height(context) * 0.2,
// //                           child: Column(
// //                             children: [
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   setState(() {
// //                                     traffic = !traffic;
// //                                   });
// //                                 },
// //                                 child: Container(
// //                                   height: 35,
// //                                   width: 45,
// //                                   decoration: const BoxDecoration(
// //                                       color: Colors.black,
// //                                       borderRadius:
// //                                           BorderRadius.all(Radius.circular(8))),
// //                                   child: const Center(
// //                                       child: Icon(
// //                                     Icons.more_horiz,
// //                                     color: Colors.white,
// //                                     size: 40,
// //                                   )),
// //                                 ),
// //                               ),
// //                               const SizedBox(
// //                                 height: 15,
// //                               ),
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   _showPopupMenu(context);
// //                                 },
// //                                 child: Container(
// //                                   height: 35,
// //                                   width: 45,
// //                                   decoration: const BoxDecoration(
// //                                       color: Colors.black,
// //                                       borderRadius:
// //                                           BorderRadius.all(Radius.circular(8))),
// //                                   child: const Center(
// //                                       child: Icon(
// //                                     Icons.view_agenda,
// //                                     color: Colors.red,
// //                                     size: 30,
// //                                   )),
// //                                 ),
// //                               ),
// //                               const SizedBox(
// //                                 height: 15,
// //                               ),
// //                               GestureDetector(
// //                                 onTap: () {
// //                                   setState(() {
// //                                     MapUtils.openmap(4713.0961, 77.8353);
// //                                   });
// //                                 },
// //                                 child: Container(
// //                                   height: 35,
// //                                   width: 45,
// //                                   decoration: const BoxDecoration(
// //                                       color: Colors.black,
// //                                       borderRadius:
// //                                           BorderRadius.all(Radius.circular(8))),
// //                                   child: const Center(
// //                                       child: Icon(
// //                                     Icons.double_arrow_sharp,
// //                                     color: Colors.white,
// //                                     size: 30,
// //                                   )),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         Positioned(
// //                           left: width(context) * 0.75,
// //                           top: height(context) * 0.39,
// //                           child: GestureDetector(
// //                             onTap: () {
// //                               Navigator.of(context).push(MaterialPageRoute(
// //                                   builder: (context) => play(
// //                                         vid: widget.vid,
// //                                       )));

// //                               // Navigator.of(context).push(MaterialPageRoute(
// //                               //   builder: (context) =>
// //                               //       MapScreen(vid: widget.vid),
// //                               // ));
// //                             },
// //                             child: Container(
// //                                 height: 35,
// //                                 width: 90,
// //                                 decoration: const BoxDecoration(
// //                                     color: Colors.black,
// //                                     borderRadius:
// //                                         BorderRadius.all(Radius.circular(8))),
// //                                 child: const Padding(
// //                                   padding: EdgeInsets.all(8.0),
// //                                   child: Center(
// //                                     child: Text(
// //                                       "Play Route",
// //                                       style: TextStyle(color: Colors.white),
// //                                     ),
// //                                   ),
// //                                 )),
// //                           ),
// //                         ),
// //                         Positioned(
// //                           top: height(context) * 0.05,
// //                           child: GestureDetector(
// //                             onTap: () {},
// //                             child: Container(
// //                               height: 50,
// //                               width: 50,
// //                               child: ListView.builder(
// //                                 itemCount: 1,
// //                                 itemBuilder: (context, index) {
// //                                   // String title = widget.items[index];
// //                                   List<FocusedMenuItem> menuItems =
// //                                       List.generate(
// //                                     widget.items.length,
// //                                     (index) => FocusedMenuItem(
// //                                       title: Text(widget.items[index]),
// //                                       onPressed: () {},
// //                                     ),
// //                                   );
// //                                   return FocusedMenuHolder(
// //                                       menuWidth:
// //                                           MediaQuery.of(context).size.width *
// //                                               0.50,
// //                                       // blurSize: 5.0,
// //                                       // menuItemExtent: 45,
// //                                       menuBoxDecoration: const BoxDecoration(
// //                                         color: Color.fromARGB(0, 255, 255, 255),
// //                                         borderRadius: BorderRadius.all(
// //                                             Radius.circular(15.0)),
// //                                       ),
// //                                       duration:
// //                                           const Duration(milliseconds: 100),
// //                                       animateMenuItems: true,
// //                                       blurBackgroundColor: Colors.black54,
// //                                       openWithTap: true,
// //                                       menuOffset: 10.0,
// //                                       onPressed: () {},
// //                                       menuItems: menuItems,
// //                                       child: Container(
// //                                           height: 45,
// //                                           width: 22,
// //                                           decoration: const BoxDecoration(
// //                                               color: Color.fromARGB(
// //                                                   0, 255, 255, 255),
// //                                               borderRadius: BorderRadius.all(
// //                                                   Radius.circular(0))),
// //                                           child: const Padding(
// //                                               padding: EdgeInsets.all(10.0),
// //                                               child: Icon(
// //                                                 Icons.double_arrow_outlined,
// //                                                 color: Colors.black,
// //                                                 size: 27,
// //                                               ))));
// //                                 },
// //                               ),
// //                             ),
// //                             //  FocusedMenuHolder(
// //                             //   animateMenuItems: true,
// //                             //   openWithTap: true,
// //                             //   blurSize: 0,
// //                             //   menuWidth:
// //                             //       MediaQuery.of(context).size.width * 0.50,
// //                             //   // blurBackgroundColor:
// //                             //   // Color.fromARGB(255, 255, 255, 255),
// //                             //   onPressed: () {},
// //                             //   menuItems: [

// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV7623"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV9876"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV4856"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV9684"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV0909"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV7579"),
// //                             //         onPressed: () {}),
// //                             //     FocusedMenuItem(
// //                             //         title: const Text("Gj06AV7454"),
// //                             //         onPressed: () {}),
// //                             //   ],
// //                             //   child: Container(
// //                             //       // height: 45,
// //                             //       // width: 50,
// //                             //       decoration: const BoxDecoration(
// //                             //           color: Color.fromARGB(255, 67, 70, 100),
// //                             //           borderRadius:
// //                             //               BorderRadius.all(Radius.circular(0))),
// //                             //       child: const Padding(
// //                             //           padding: EdgeInsets.all(10.0),
// //                             //           child: Icon(
// //                             //             Icons.double_arrow_outlined,
// //                             //             color: Colors.white,
// //                             //             size: 27,
// //                             //           ))),
// //                             // ),
// //                           ),
// //                         ),
// //                         Positioned(
// //                           bottom: 0,
// //                           right: 0,
// //                           left: 0,
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.center,
// //                             children: [
// //                               IconButton(
// //                                   onPressed: () {
// //                                     setState(() {
// //                                       isClicked = !isClicked;
// //                                     });
// //                                   },
// //                                   icon: Icon(isClicked == false
// //                                       ? Icons.keyboard_double_arrow_down_sharp
// //                                       : Icons.keyboard_double_arrow_up_sharp)),
// //                               // MaterialButton(
// //                               //     color: Colors.white,
// //                               //     onPressed: () {
// //                               //       setState(() {
// //                               //         isClicked = !isClicked;
// //                               //       });
// //                               //     },
// //                               //     child: Icon(isClicked == false
// //                               //         ? Icons.keyboard_double_arrow_down_sharp
// //                               //         : Icons.keyboard_double_arrow_up_sharp)),
// //                             ],
// //                           ),
// //                         ),
// //                         CustomInfoWindow(
// //                           controller: _customInfoWindowController,
// //                           height: 75,
// //                           width: 150,
// //                           offset: 50,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Container(
// //                         width: width(context),
// //                         height: isClicked == false ? null : 0,
// //                         color: const Color.fromARGB(255, 255, 255, 255),
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(4.0),
// //                           child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   SizedBox(
// //                                     // height: 50,
// //                                     width: width(context) * 0.35,
// //                                     child: Text(
// //                                       widget.location,
// //                                       style: TextStyle(fontSize: 12),
// //                                     ),
// //                                   ),
// //                                   SizedBox(
// //                                     height: 8,
// //                                   ),
// //                                   Container(
// //                                     height: height(context) * 0.09,
// //                                     width: width(context) * 0.27,
// //                                     decoration: const BoxDecoration(
// //                                       shape: BoxShape.circle,
// //                                       // color: Colors.green,
// //                                     ),
// //                                     child: Image.asset(
// //                                       "images/odo2.png",
// //                                       fit: BoxFit.fill,
// //                                     ),
// //                                   ),
// //                                   Text(
// //                                     "       ${widget.km} km /h",
// //                                     style: TextStyle(
// //                                         fontWeight: FontWeight.bold,
// //                                         fontSize: 14),
// //                                   ),
// //                                   const SizedBox(
// //                                     height: 10,
// //                                   ),
// //                                   // const Text(
// //                                   //   "       32949",
// //                                   //   style: TextStyle(
// //                                   //       fontWeight: FontWeight.bold,
// //                                   //       fontSize: 16),
// //                                   // ),
// //                                 ],
// //                               ),
// //                               const SizedBox(
// //                                 width: 20,
// //                               ),
// //                               Column(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceAround,
// //                                 children: [
// //                                   Column(
// //                                     children: [
// //                                       const CircleAvatar(
// //                                         radius: 25,
// //                                         backgroundColor:
// //                                             Color.fromARGB(255, 235, 223, 117),
// //                                         child: Icon(
// //                                           Icons.fire_truck_rounded,
// //                                           color: Colors.black,
// //                                         ),
// //                                       ),
// //                                       Text(
// //                                         widget.vehiclecondition,
// //                                         style: const TextStyle(fontSize: 12),
// //                                       )
// //                                     ],
// //                                   ),
// //                                   Column(
// //                                     children: [
// //                                       GestureDetector(
// //                                         onTap: () {
// //                                           Navigator.of(context)
// //                                               .push(MaterialPageRoute(
// //                                             builder: (context) =>
// //                                                 const Reports(),
// //                                           ));
// //                                         },
// //                                         child: const CircleAvatar(
// //                                           radius: 25,
// //                                           backgroundColor: Color.fromARGB(
// //                                               255, 255, 175, 173),
// //                                           child: Icon(
// //                                             Icons.report,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const Text(
// //                                         "Report",
// //                                         style: TextStyle(fontSize: 12),
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                               Column(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceAround,
// //                                 children: [
// //                                   Column(
// //                                     children: [
// //                                       const CircleAvatar(
// //                                         radius: 25,
// //                                         backgroundColor:
// //                                             Color.fromARGB(255, 117, 235, 215),
// //                                         child: Icon(
// //                                           Icons.key,
// //                                           color:
// //                                               Color.fromARGB(255, 187, 184, 2),
// //                                         ),
// //                                       ),
// //                                       Text(
// //                                         widget.ignition,
// //                                         style: const TextStyle(fontSize: 12),
// //                                       )
// //                                     ],
// //                                   ),
// //                                   Column(
// //                                     children: [
// //                                       GestureDetector(
// //                                         onTap: () {
// //                                           Navigator.of(context)
// //                                               .push(MaterialPageRoute(
// //                                                   builder: (context) => play(
// //                                                         vid: widget.vid,
// //                                                       )));
// //                                         },
// //                                         child: const CircleAvatar(
// //                                           radius: 25,
// //                                           backgroundColor: Color.fromARGB(
// //                                               255, 173, 185, 255),
// //                                           child: Icon(
// //                                             Icons.history,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const Text(
// //                                         "History",
// //                                         style: TextStyle(fontSize: 12),
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                               Column(
// //                                 mainAxisAlignment:
// //                                     MainAxisAlignment.spaceAround,
// //                                 children: [
// //                                   Column(
// //                                     children: [
// //                                       Stack(
// //                                         alignment: AlignmentDirectional.center,
// //                                         children: [
// //                                           Positioned(
// //                                               child: InkWell(
// //                                             onTap: (() {
// //                                               showDialog(
// //                                                 context: context,
// //                                                 builder: (context) {
// //                                                   return AlertDialog(
// //                                                     content: Container(
// //                                                       height: height(context) *
// //                                                           0.15,
// //                                                       width: double.infinity,
// //                                                       decoration: const BoxDecoration(
// //                                                           borderRadius:
// //                                                               BorderRadius.all(
// //                                                                   Radius
// //                                                                       .circular(
// //                                                                           40))),
// //                                                       child: Column(
// //                                                         children: [
// //                                                           const SizedBox(
// //                                                             height: 10,
// //                                                           ),
// //                                                           const Text(
// //                                                             "Are You sure You Want on Relay ?",
// //                                                             textAlign: TextAlign
// //                                                                 .center,
// //                                                             style: TextStyle(
// //                                                                 fontWeight:
// //                                                                     FontWeight
// //                                                                         .w700),
// //                                                           ),
// //                                                           const SizedBox(
// //                                                             height: 40,
// //                                                           ),
// //                                                           Row(
// //                                                             mainAxisAlignment:
// //                                                                 MainAxisAlignment
// //                                                                     .spaceAround,
// //                                                             children: [
// //                                                               ElevatedButton(
// //                                                                   style:
// //                                                                       ButtonStyle(
// //                                                                           backgroundColor: MaterialStateProperty.all(const Color.fromARGB(
// //                                                                               255,
// //                                                                               53,
// //                                                                               64,
// //                                                                               114)),
// //                                                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                                                                               RoundedRectangleBorder(
// //                                                                             borderRadius:
// //                                                                                 BorderRadius.circular(16.0),
// //                                                                           ))),
// //                                                                   onPressed:
// //                                                                       () {
// //                                                                     // setState(
// //                                                                     //     () {
// //                                                                     //   controller
// //                                                                     //       .start();
// //                                                                     //   Navigator.pop(
// //                                                                     //       context);
// //                                                                     // });
// //                                                                   },
// //                                                                   child:
// //                                                                       const Text(
// //                                                                     "Yes",
// //                                                                     style: TextStyle(
// //                                                                         color: Colors
// //                                                                             .white,
// //                                                                         fontWeight:
// //                                                                             FontWeight.w800),
// //                                                                   )),
// //                                                               ElevatedButton(
// //                                                                   style:
// //                                                                       ButtonStyle(
// //                                                                           backgroundColor: MaterialStateProperty
// //                                                                               .all(
// //                                                                             const Color.fromARGB(
// //                                                                                 255,
// //                                                                                 202,
// //                                                                                 245,
// //                                                                                 228),
// //                                                                           ),
// //                                                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                                                                               RoundedRectangleBorder(
// //                                                                             borderRadius:
// //                                                                                 BorderRadius.circular(16.0),
// //                                                                           ))),
// //                                                                   onPressed:
// //                                                                       () {
// //                                                                     Navigator.pop(
// //                                                                         context);
// //                                                                   },
// //                                                                   child:
// //                                                                       const Text(
// //                                                                     "No",
// //                                                                     style: TextStyle(
// //                                                                         color: Colors
// //                                                                             .black,
// //                                                                         fontWeight:
// //                                                                             FontWeight.w800),
// //                                                                   ))
// //                                                             ],
// //                                                           )
// //                                                         ],
// //                                                       ),
// //                                                     ),
// //                                                   );
// //                                                 },
// //                                               );
// //                                             }),
// //                                             child: const CircleAvatar(
// //                                               backgroundColor: Color.fromARGB(
// //                                                   255, 236, 169, 169),
// //                                               radius: 22,
// //                                               child: Icon(
// //                                                 Icons.lock,
// //                                                 color: Colors.black,
// //                                                 // size: 45,
// //                                               ),
// //                                             ),
// //                                           ))
// //                                         ],
// //                                       ),
// //                                       const Text("Relay")
// //                                     ],
// //                                   ),
// //                                   Column(
// //                                     children: [
// //                                       GestureDetector(
// //                                         onTap: () {
// //                                           launchUrl(Uri.parse(
// //                                               'https://www.globalgps.in/'));
// //                                         },
// //                                         child: const CircleAvatar(
// //                                           radius: 25,
// //                                           backgroundColor: Color.fromARGB(
// //                                               255, 235, 223, 117),
// //                                           child: Icon(
// //                                             Icons.screen_share_rounded,
// //                                             color: Colors.black,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const Text(
// //                                         "Links",
// //                                         style: TextStyle(fontSize: 12),
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ],
// //                               )
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       Container(
// //                         width: width(context),
// //                         color: Colors.white,
// //                         child: Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                             children: [
// //                               Column(
// //                                 children: [
// //                                   GestureDetector(
// //                                     onTap: () {
// //                                       const Buy_GPS().navigateTo(context);
// //                                     },
// //                                     child: const CircleAvatar(
// //                                       radius: 25,
// //                                       backgroundColor:
// //                                           Color.fromARGB(255, 173, 255, 210),
// //                                       child: Icon(
// //                                         Icons.shopify_outlined,
// //                                         color: Colors.black,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   const Text(
// //                                     "New GPS",
// //                                     style: TextStyle(fontSize: 12),
// //                                   )
// //                                 ],
// //                               ),
// //                               Column(
// //                                 children: [
// //                                   GestureDetector(
// //                                     onTap: () {
// //                                       const Fastag().navigateTo(context);
// //                                     },
// //                                     child: const CircleAvatar(
// //                                       radius: 25,
// //                                       backgroundColor:
// //                                           Color.fromARGB(255, 174, 250, 155),
// //                                       child: Icon(
// //                                         Icons.tag,
// //                                         color: Colors.black,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   const Text(
// //                                     "Fastag",
// //                                     style: TextStyle(fontSize: 12),
// //                                   )
// //                                 ],
// //                               ),
// //                               Column(
// //                                 children: const [
// //                                   CircleAvatar(
// //                                     radius: 25,
// //                                     backgroundColor:
// //                                         Color.fromARGB(255, 255, 173, 237),
// //                                     child: Icon(
// //                                       Icons.offline_bolt_sharp,
// //                                       color: Colors.black,
// //                                     ),
// //                                   ),
// //                                   Text(
// //                                     "Fuel",
// //                                     style: TextStyle(fontSize: 12),
// //                                   )
// //                                 ],
// //                               ),
// //                               Column(
// //                                 children: const [
// //                                   SizedBox(
// //                                     height: 5,
// //                                   ),
// //                                   CircleAvatar(
// //                                     radius: 25,
// //                                     backgroundColor:
// //                                         Color.fromARGB(255, 177, 177, 177),
// //                                     child: Icon(
// //                                       Icons.location_on,
// //                                       color: Colors.black,
// //                                     ),
// //                                   ),
// //                                   Text(
// //                                     "Live",
// //                                     style: TextStyle(fontSize: 12),
// //                                   ),
// //                                   SizedBox(
// //                                     height: 5,
// //                                   )
// //                                 ],
// //                               ),
// //                             ]),
// //                       ),
// //                     ],
// //                   )
// //                 ],
// //               ));
// //   }

// //   void _setInitialZoom() async {
// //     await Future.delayed(Duration(seconds: 2)); // wait for 2 seconds
// //     setState(() {
// //       _zoomLevel = 25; // set zoom level to 9.0 after 2 seconds
// //     });
// //     _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
// //         target: LatLng(widget.latitude, widget.longitude), zoom: _zoomLevel)));
// //   }
// // }

// // class MapUtils {
// //   MapUtils._();
// //   static void openmap(
// //     double latitude,
// //     double longitude,
// //   ) {
// //     String googleMapUrl =
// //         "https://www.google.com/maps/dir/?api=1&travelmode=driving&layer=traffic&destination=12.971599,77.594566";
// //     launch(googleMapUrl);
// //     // if ( await canLaunch(googleMapUrl)) {
// //     //    launch(googleMapUrl);
// //     // } else {
// //     //   throw 'could not load';
// //     // }
// //   }
// // }

// // /// just to move marker
// // ///

// // // class markermove extends StatefulWidget{
// // //   @override
// // //   _markermoveState createState() => _markermoveState();
// // // }

// // // class _markermoveState extends State<markermove> {

// // //   GoogleMapController? mapController; //contrller for Google map
// // //   Set<Marker> markers = Set(); //markers for google map

// // //   LatLng loc1 = LatLng(27.6602292, 85.308027);

// // //   int numDeltas = 50; //number of delta to devide total distance
// // //   int delay = 50; //milliseconds of delay to pass each delta
// // //   var i = 0;
// // //   double? deltaLat;
// // //   double? deltaLng;
// // //   var position; //position variable while moving marker
// // //   BitmapDescriptor? myIcon;
// // //   @override
// // //   void initState() {
// // //      BitmapDescriptor.fromAssetImage(
// // //             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
// // //             mipmaps: true)
// // //         .then((onValue) {
// // //       myIcon = onValue;
// // //     });
// // //     position = [loc1.latitude, loc1.longitude]; //initial position of moving marker
// // //     addMarkers();
// // //     super.initState();
// // //     //  transition(result);
// // //   }

// // // // void initState() {
// // // //     BitmapDescriptor.fromAssetImage(
// // // //             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
// // // //             mipmaps: true)
// // // //         .then((onValue) {
// // // //       myIcon = onValue;
// // // //     });
// // // //     _polygon.add(Polygon(
// // // //       // given polygonId
// // // //       polygonId: const PolygonId('1'),
// // // //       // initialize the list of points to display polygon
// // // //       points: points,
// // // //       // given color to polygon
// // // //       fillColor: Colors.green.withOpacity(0.3),
// // // //       // given border color to polygon
// // // //       strokeColor: Colors.green,
// // // //       geodesic: true,
// // // //       // given width of border
// // // //       strokeWidth: 4,
// // // //     ));
// // // //     getPolypoints();
// // // //     getCurrentLocation();
// // // //     super.initState();
// // // //   }
// // //   addMarkers() async {
// // //       markers.add(
// // //         Marker(
// // //           markerId: MarkerId(loc1.toString()),
// // //           position: loc1,
// // //           icon: BitmapDescriptor.defaultMarker
// // //         )
// // //       );

// // //       setState(() {
// // //           //refresh UI
// // //       });
// // //   }

// // //   transition(result){
// // //       i = 0;
// // //       deltaLat = (result[0] - position[0])/numDeltas;
// // //       deltaLng = (result[1] - position[1])/numDeltas;
// // //       moveMarker();
// // //   }

// // //   moveMarker(){
// // //       position[0] += deltaLat;
// // //       position[1] += deltaLng;
// // //       var latlng = LatLng(position[0], position[1]);

// // //       markers = {
// // //         Marker(
// // //             markerId: MarkerId("movingmarker"),
// // //             position: latlng,
// // //             icon:myIcon!,
// // //         )
// // //       };

// // //       setState(() {
// // //          //refresh UI
// // //       });

// // //       if(i!=numDeltas){
// // //           i++;
// // //           Future.delayed(Duration(milliseconds: delay), (){
// // //               moveMarker();
// // //           });
// // //       }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return  Scaffold(
// // //           appBar: AppBar(
// // //              title: Text("Move Marker Position on Google Map"),
// // //              backgroundColor: Colors.deepPurpleAccent,
// // //           ),
// // //           floatingActionButton: FloatingActionButton(
// // //              child: Text("Move"),
// // //              onPressed: (){
// // //                  var result = [27.661838, 85.308543];
// // //                  //latitude and longitude of new position

// // //                  transition(result);
// // //                  //start moving marker
// // //              },
// // //           ),
// // //           body: GoogleMap(
// // //             //Map widget from google_maps_flutter package
// // //                   zoomGesturesEnabled: true, //enable Zoom in, out on map
// // //                   initialCameraPosition: CameraPosition( //innital position in map
// // //                     target: loc1, //initial position
// // //                     zoom: 14.0, //initial zoom level
// // //                   ),
// // //                   markers: markers, //markers to show on map
// // //                   mapType: MapType.normal, //map type
// // //                   onMapCreated: (controller) { //method called when map is created
// // //                     setState(() {
// // //                       mapController = controller;
// // //                     });
// // //                   },
// // //           )
// // //        );
// // //   }
// // // }

// // // onmap camera position

// // // class oncameraposition extends StatefulWidget {
// // //   @override
// // //   _oncamerapositionState createState() => _oncamerapositionState();
// // // }

// // // class _oncamerapositionState extends State<oncameraposition> {
// // //   String googleApikey = "GOOGLE_MAP_API_KEY";
// // //   GoogleMapController? mapController; //contrller for Google map
// // //   LatLng startLocation = const LatLng(
// // //     27.6602292,
// // //     85.308027,
// // //   );

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text("Move to New Position of Map"),
// // //           backgroundColor: Colors.deepPurpleAccent,
// // //         ),
// // //         floatingActionButton: FloatingActionButton(
// // //           child: const Text("Move"),
// // //           onPressed: () {
// // //             LatLng newlatlang = const LatLng(27.7149298, 85.2903343);
// // //             mapController?.animateCamera(CameraUpdate.newCameraPosition(
// // //                 CameraPosition(target: newlatlang, zoom: 17)
// // //                 //17 is new zoom level
// // //                 ));
// // //             //move position of map camera to new location
// // //           },
// // //         ),
// // //         body: Container(
// // //           child: GoogleMap(
// // //             // onCameraMoveStarted: ,
// // //             //Map widget from google_maps_flutter package
// // //             zoomGesturesEnabled: true, //enable Zoom in, out on map
// // //             initialCameraPosition: CameraPosition(
// // //               //innital position in map
// // //               target: startLocation, //initial position
// // //               zoom: 14.0, //initial zoom level
// // //             ),
// // //             mapType: MapType.normal, //map type
// // //             onMapCreated: (controller) {
// // //               //method called when map is created
// // //               setState(() {
// // //                 mapController = controller;
// // //               });
// // //             },
// // //           ),
// // //         ));
// // //   }
// // // }

// // // const List<LatLng> latLonList2 = [
// // //   LatLng(45.523064, -122.676483),
// // //   LatLng(45.523065, -122.676484),
// // //   LatLng(45.523066, -122.676485),
// // //   LatLng(45.523067, -122.676486),
// // //   LatLng(45.523067, -122.676487),
// // //   LatLng(45.523068, -122.676488),
// // //   LatLng(45.523069, -122.676489),
// // //   LatLng(45.523070, -122.676490),
// // //   LatLng(45.522020, -122.685590),
// // //   LatLng(45.522016, -122.685523),
// // //   LatLng(45.521016, -122.684523),
// // //   LatLng(45.519577, -122.685706),
// // //   LatLng(45.519042, -122.685849),
// // //   LatLng(45.518583, -122.684574),
// // //   LatLng(45.518299, -122.683485),
// // //   LatLng(45.518296, -122.683485),
// // //   LatLng(45.517587, -122.682020),
// // //   LatLng(45.517584, -122.682015),
// // //   LatLng(45.517583, -122.682014),
// // //   LatLng(45.517582, -122.682013),
// // //   LatLng(45.517581, -122.682012),
// // //   LatLng(45.517580, -122.682011),
// // //   LatLng(45.517579, -122.682009),
// // // ];

// // class MyMap extends StatefulWidget {
// //   @override
// //   _MyMapState createState() => _MyMapState();
// // }

// // class _MyMapState extends State<MyMap> {
// //   List<dynamic> _data = [];
// //   List<LatLng> _points = [];
// //   bool _isLoading = true;
// //   LatLng? _markerLocation;

// //   BitmapDescriptor? myIcon;
// //   late Marker _marker;
// //   Future<void> _fetchData() async {
// //     final response = await http.get(Uri.parse(
// //         'http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/26100/2023-02-14 12:02:19/2023-02-15 12:02:19'));
// //     final extractedData = json.decode(response.body);

// //     setState(() {
// //       _data = extractedData["historyData"];
// //     });
// //   }

// //   void _drawPolyline() {
// //     for (var data in _data) {
// //       double lat = double.parse(data['latitude']);
// //       double lng = double.parse(data['longitude']);
// //       _points.add(LatLng(lat, lng));
// //     }
// //     setState(() {
// //       _isLoading = false;
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     setInitialMarkerLocation();
// //     _fetchData().then((_) => _drawPolyline());
// //     BitmapDescriptor.fromAssetImage(
// //             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
// //             mipmaps: true)
// //         .then((onValue) {
// //       myIcon = onValue;
// //     });
// //   }

// //   void setInitialMarkerLocation() {
// //     if (_points.isNotEmpty) {
// //       _markerLocation = _points.first;
// //       // _markerLocation = _points.last;
// //       _marker = Marker(
// //         markerId: const MarkerId('marker'),
// //         position: _markerLocation!,
// //         rotation: 2.0,
// //         icon: BitmapDescriptor.defaultMarker,
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {

// //     return Scaffold(
// //       body: _isLoading && myIcon == null
// //           ? const Center(
// //               child: CircularProgressIndicator(),
// //             )
// //           : GoogleMap(
// //               initialCameraPosition: const CameraPosition(
// //                 target: LatLng(13.0461, 77.50624),
// //                 zoom: 15,
// //               ),
// //               markers: {_marker},
// //               polylines: {
// //                 Polyline(
// //                   polylineId: const PolylineId('route'),
// //                   points: _points,
// //                   color: Colors.blue,
// //                   width: 5,
// //                 ),
// //               },
// //             ),
// //     );
// //   }
// // }

// // // class MyMap extends StatefulWidget {
// // //   @override
// // //   _MyMapState createState() => _MyMapState();
// // // }

// // // class _MyMapState extends State<MyMap> {
// // //   List<dynamic> _data = [];
// // //   List<LatLng> _points = [];

// // //   Future<void> _fetchData() async {
// // //     final response = await http.get(Uri.parse('http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/26100/2023-02-14 12:02:19/2023-02-15 12:02:19'));
// // //     final extractedData = json.decode(response.body) as List<dynamic>;
// // //     setState(() {
// // //       _data = extractedData;
// // //     });
// // //   }

// // //   void _drawPolyline() {
// // //     for (var data in _data) {
// // //       double lat = double.parse(data['latitude']);
// // //       double lng = double.parse(data['longitude']);
// // //       _points.add(LatLng(lat, lng));
// // //     }
// // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fetchData().then((_) => _drawPolyline());
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body:_points.isEmpty? Center(child: CircularProgressIndicator()): GoogleMap(
// // //         initialCameraPosition: CameraPosition(
// // //           target: LatLng(13.0461, 77.50624),
// // //           zoom: 15,
// // //         ),
// // //         polylines: {
// // //           Polyline(
// // //             polylineId: PolylineId('route'),
// // //             points: _points,
// // //             color: Colors.blue,
// // //             width: 5,
// // //           ),
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }

// // // class MyMap extends StatefulWidget {
// // //   @override
// // //   _MyMapState createState() => _MyMapState();
// // // }

// // // class _MyMapState extends State<MyMap> {
// // //   Set<Polyline> _polylines = {};
// // //   List<LatLng> _latLngList = [];

// // //   void _getPolylineData() async {
// // //     // Make API call and parse response data
// // //     var response = await http.get(Uri.parse("http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/17251/2023-02-13%2012:02:19/2023-02-17%2012:02:19"));
// // //     var jsonData = json.decode(response.body);

// // //     // Parse latitude and longitude data and store in list
// // //     for (var data in jsonData) {
// // //       double lat = double.parse(data['latitude']);
// // //       double lng = double.parse(data['longitude']);
// // //       LatLng latLng = LatLng(lat, lng);
// // //       _latLngList.add(latLng);
// // //     }

// // //     // Create polyline object and add to set
// // //     Polyline polyline = Polyline(
// // //       polylineId: PolylineId('polyline'),
// // //       points: _latLngList,
// // //       color: Colors.blue,
// // //       width: 5,
// // //     );
// // //     _polylines.add(polyline);

// // //     // Update state to rebuild widget with polyline data
// // //     setState(() {});
// // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _getPolylineData();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Google Maps Polylines'),
// // //       ),
// // //       body: GoogleMap(
// // //         initialCameraPosition: CameraPosition(
// // //           target: LatLng(13.0461, 77.50624),
// // //           zoom: 14,
// // //         ),
// // //         polylines: _polylines,
// // //       ),
// // //     );
// // //   }
// // // }

// // class MapScreen extends StatefulWidget {
// //   String vid;
// //   MapScreen({super.key, required this.vid});

// //   @override
// //   _MapScreenState createState() => _MapScreenState();
// // }

// // class _MapScreenState extends State<MapScreen> {
// //   final Completer<GoogleMapController> _controller = Completer();

// //   List<LatLng> latLonList = [];
// //   // final List<LatLng> latLonList2 = const [
// //   //   LatLng(45.523064, -122.676483),
// //   //   LatLng(45.523065, -122.676484),
// //   //   LatLng(45.523066, -122.676485),
// //   //   LatLng(45.523067, -122.676486),
// //   //   LatLng(45.523067, -122.676487),
// //   //   LatLng(45.523068, -122.676488),
// //   //   LatLng(45.523069, -122.676489),
// //   //   LatLng(45.523070, -122.676490),
// //   //   LatLng(45.522020, -122.685590),
// //   //   LatLng(45.522016, -122.685523),
// //   //   LatLng(45.521016, -122.684523),
// //   //   LatLng(45.519577, -122.685706),
// //   //   LatLng(45.519042, -122.685849),
// //   //   LatLng(45.518583, -122.684574),
// //   //   LatLng(45.518299, -122.683485),
// //   //   LatLng(45.518296, -122.683485),
// //   //   LatLng(45.517587, -122.682020),
// //   //   LatLng(45.517584, -122.682015),
// //   //   LatLng(45.517583, -122.682014),
// //   //   LatLng(45.517582, -122.682013),
// //   //   LatLng(45.517581, -122.682012),
// //   //   LatLng(45.517580, -122.682011),
// //   //   LatLng(45.517579, -122.682009),
// //   // ];
// //   // BitmapDescriptor? _markerIcon;
// //   late Marker _marker;
// //   late Marker marker2;
// //   LatLng? _markerLocation;
// //   LatLng? _finalmarkerLocation;
// //   int _polylineIndex = 0;
// //   BitmapDescriptor? myIcon;

// //   @override
// //   void initState() {
// //     super.initState();
// //     setInitialMarkerLocation();
// //     setfinalMarkerLocation();
// //     moveMarker();
// //     hist(widget.vid);
// //     BitmapDescriptor.fromAssetImage(
// //             const ImageConfiguration(size: Size(0, 0)), 'images/car2.png',
// //             mipmaps: true)
// //         .then((onValue) {
// //       myIcon = onValue;
// //     });
// //   }

// //   ///history api

// //   hist(String vide) async {
// //     var res = await http.get(Uri.parse(
// //         "http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/$vide/2023-02-13%2012:02:19/2023-02-17%2012:02:19"));
// //     var latilong = [];
// //     if (res.statusCode == 200) {
// //       var response = jsonDecode(res.body);
// //       latilong = response["historyData"];

// //       for (int i = 0; i < latilong.length - 1; i++) {
// //         if (latilong.isNotEmpty) {
// //           double lat = double.parse(latilong[i]['latitude']);
// //           double lng = double.parse(latilong[i]['longitude']);
// //           latLonList.add(LatLng(lat, lng));
// //           if (latLonList.length == latilong.length) {
// //             List<String> latLngStrings =
// //                 latLonList.map((latLon) => latLon.toString()).toList();
// //             latLonList == latLngStrings;

// //           }
// //         }
// //       }
// //     } else {

// //     }
// //   }

// //   // histor() async {
// //   //   his = await Api.history("21321");
// //   //   await Api.history("21321");
// //   //   for (int i = 0; i < his.length; i++) {
// //   //     if (his.isNotEmpty) {
// //   //       double lat = double.parse(his[i]['latitude']);
// //   //       double lng = double.parse(his[i]['longitude']);
// //   //       latLonList.add(LatLng(lat, lng));
// //   //       if (latLonList.length == his.length) {
// //   //         List<String> latLngStrings =
// //   //             latLonList.map((latLon) => latLon.toString()).toList();
// //   //         latLonList == latLngStrings;

// //   //       }
// //   //     }
// //   //   }
// //   // }

// //   bool run = false;

// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     super.dispose();
// //     // _controller.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Map Screen'),
// //       ),
// //       body: Stack(children: [
// //         latLonList.isEmpty
// //             ? const Center(child: CircularProgressIndicator())
// //             : GoogleMap(
// //                 mapType: MapType.normal,
// //                 initialCameraPosition: CameraPosition(
// //                   target: latLonList.first,
// //                   zoom: 14,
// //                 ),
// //                 polylines: {
// //                   Polyline(
// //                     polylineId: const PolylineId('polyline'),
// //                     color: Colors.blue,
// //                     points: latLonList,
// //                     width: 2,
// //                   ),
// //                 },
// //                 markers: {
// //                   _marker,
// //                   // marker2,
// //                 },
// //                 onMapCreated: (GoogleMapController controller) {
// //                   _controller.complete(controller);
// //                 },
// //               ),
// //         Positioned(
// //           left: width(context) * 0.84,
// //           top: height(context) * 0.39,
// //           child: GestureDetector(
// //             onTap: () {
// //               run == false ? moveMarker() : null;
// //               run == true;
// //               // Navigator.of(context).push(MaterialPageRoute(
// //               //     builder: (context) => Playroute_history(
// //               //           vehiclenum: "}",
// //               //           speed: "0",
// //               //           // speed: "${widget.speedkm}",
// //               //         )));
// //             },
// //             child: Container(
// //                 height: 35,
// //                 width: 45,
// //                 decoration: const BoxDecoration(
// //                     color: Colors.black,
// //                     borderRadius: BorderRadius.all(Radius.circular(8))),
// //                 child: const Padding(
// //                   padding: EdgeInsets.all(8.0),
// //                   child: Center(
// //                     child: Text(
// //                       "Play",
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 )),
// //           ),
// //         ),
// //       ]),
// //     );
// //   }

// //   void setInitialMarkerLocation() {
// //     if (latLonList.isNotEmpty) {
// //       _markerLocation = latLonList.first;
// //       // _markerLocation = latLonList.last;
// //       _marker = Marker(
// //         markerId: const MarkerId('marker'),
// //         position: _markerLocation!,
// //         rotation: 2.0,
// //         icon: myIcon!,
// //       );
// //     }
// //   }

// //   void setfinalMarkerLocation() {
// //     if (latLonList.isNotEmpty) {
// //       _finalmarkerLocation = const LatLng(45.518299, -122.683485);
// //       // _markerLocation = latLonList.last;
// //       marker2 = Marker(
// //         markerId: const MarkerId('marker'),
// //         position: _finalmarkerLocation!,
// //         rotation: 2.0,
// //         icon: myIcon!,
// //       );
// //     }
// //   }

// //   void moveMarker() {
// //     Timer.periodic(const Duration(seconds: 2), (timer) {
// //       setState(() {
// //         if (_polylineIndex < latLonList.length - 1) {
// //           _polylineIndex++;
// //         } else {
// //           _polylineIndex = 0;
// //         }
// //         _markerLocation = latLonList[_polylineIndex];
// //         _marker = Marker(
// //           draggable: true,
// //           markerId: const MarkerId('marker'),
// //           position: _markerLocation!,
// //           icon: myIcon!,
// //           // icon: BitmapDescriptor.defaultMarker,
// //           anchor: const Offset(1.0, 1.0),
// //         );
// //         polylines:
// //         {
// //           Polyline(
// //             polylineId: const PolylineId('polyline'),
// //             color: Colors.blue,
// //             points: latLonList,
// //             width: 2,
// //           );
// //         }
// //         ;
// //       });
// //     });
// //   }
// // }

// // ///
// // ///
// // ///

// // ///

// // class LatLon {
// //   final String lat;
// //   final String lng;

// //   LatLon(this.lat, this.lng);

// //   @override
// //   String toString() {
// //     return 'LatLng($lat, $lng)';
// //   }
// // }

// // //   void moveMarker2() {
// // //   Timer.periodic(const Duration(milliseconds: 600), (timer) {
// // //     setState(() {
// // //       if (_polylineIndex < latLonList.length - 1) {
// // //         _polylineIndex++;
// // //       } else {
// // //         _polylineIndex = 0;
// // //       }
// // //       LatLng nextLocation = latLonList[_polylineIndex];
// // //       double bearing = _calculateBearing(_markerLocation!, nextLocation);
// // //       _markerLocation = nextLocation;
// // //       _marker = _marker.copyWith(
// // //         positionParam: _markerLocation!,
// // //         rotationParam: bearing,
// // //       );
// // //     });
// // //   });
// // // }

// // // double _calculateBearing(LatLng start, LatLng end) {
// // //   double lat1 = radians;
// // //   double lon1 = radians;
// // //   double lat2 = radians;
// // //   double lon2 = radians;
// // //   double y = sin(lon2 - lon1) * cos(lat2);
// // //   double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1);
// // //   int bearing = degrees;
// // //   return (bearing + 360) % 360;
// // // }

// // /// remove later

// // // class MyMapScreen extends StatefulWidget {
// // //   final double initialLat;
// // //   final double initialLon;

// // //   const MyMapScreen(
// // //       {Key? key, required this.initialLat, required this.initialLon})
// // //       : super(key: key);

// // //   @override
// // //   _MyMapScreenState createState() => _MyMapScreenState();
// // // }

// // // class _MyMapScreenState extends State<MyMapScreen> {
// // //   Completer<GoogleMapController> _controller = Completer();
// // //   StreamController<LatLng> _streamController = StreamController<LatLng>();
// // //   LatLng _currentLocation = LatLng(0, 0);
// // //   @override
// // //   void initState() {
// // //     // TODO: implement initState
// // //     _currentLocation = LatLng(widget.initialLat, widget.initialLon);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _streamController.close();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: GoogleMap(
// // //         initialCameraPosition: CameraPosition(
// // //           target: LatLng(widget.initialLat, widget.initialLon),
// // //           zoom: 13.0,
// // //         ),
// // //         markers: [
// // //           Marker(
// // //             markerId: MarkerId('current_location'),
// // //             position: _currentLocation,
// // //             icon:
// // //                 BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
// // //           ),
// // //         ].toSet(),
// // //         onMapCreated: (GoogleMapController controller) {
// // //           _controller.complete(controller);
// // //         },
// // //         myLocationEnabled: true,
// // //         myLocationButtonEnabled: false,
// // //         compassEnabled: false,
// // //         zoomControlsEnabled: false,
// // //         onTap: (LatLng location) {
// // //           _streamController.add(location);
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
