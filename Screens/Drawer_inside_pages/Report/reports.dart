import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Distance_daywise_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Distance_periodic__report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Full_details_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Geofence_alert_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Idle_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Over_speed_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Stoppage_reports.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Travel_report.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/Vehicle_summary_report.dart';
import 'package:gpsglobe/Screens/Home_page/Drawer/Drawermain.dart';
import 'package:gpsglobe/extensions/extensions.dart';





import 'vahicle_onoff_report.dart';
// import 'package:flutter_compass/flutter_compass.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 106, 180, 110),
        centerTitle: true,
        title: Text(
          "Reports".tr(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Stoppage_report().navigateTo(context);
              },
              title: Text("stoppager".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Travel_report().navigateTo(context);
              },
              title: Text("travelr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                idle_report().navigateTo(context);
              },
              title: Text("idler".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Vehicle_summary_report().navigateTo(context);
              },
              title: Text("vehicleSummaryr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Over_speed_report().navigateTo(context);
              },
              title: Text("overspeedr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Distance_daywise_report().navigateTo(context);
              },
              title: Text("distancedaywiser".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                // Geofence_alert_report().navigateTo(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => geofence_alert_report()),
                );
              },
              title: Text("geofencealertr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Vehicle_on_off_count(),
                ));
              },
              title: Text("vehicleonoffcountr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Distance_periodic_report().navigateTo(context);
              },
              title: Text("distanceperiodicr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                Full_details_report().navigateTo(context);
              },
              title: Text("fulldetailsr".tr()),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => MyHomePage2(
            //                   title: "dcsdcdsc",
            //                 )),
            //       );
            //     },
            //     child: const Text("."))
          ],
        ),
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: Drawermain(),
      ),
      floatingActionButton: const Floatingaction_button(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   late LatLng _markerPosition;

//   final LatLng _startPosition = const LatLng(37.4219999, -122.0840575);
//   final LatLng _endPosition =
//       const LatLng(37.42796133580664, -122.085749655962);

//   BitmapDescriptor? _markerIcon;

//   @override
//   void initState() {
//     super.initState();

//     // Load the custom marker image from assets and convert it to a BitmapDescriptor
//     BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(
//         size: Size(48, 48), // size of the image
//       ),
//       'images/car2.png',
//     ).then((icon) => _markerIcon = icon);

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3500),
//     )..addListener(() {
//         setState(() {
//           _markerPosition = LatLng(
//             lerpDouble(_startPosition.latitude, _endPosition.latitude,
//                         _controller.value)
//                     ?.toDouble() ??
//                 0.0,
//             lerpDouble(_startPosition.longitude, _endPosition.longitude,
//                         _controller.value)
//                     ?.toDouble() ??
//                 0.0,
//           );
//         });
//       });
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _startPosition,
//           zoom: 15,
//         ),
//         markers: [
//           Marker(
//             markerId: const MarkerId('marker'),
//             position: _markerPosition,
//             icon: _markerIcon!, // use the custom marker icon
//           ),
//         ].toSet(),
//       ),
//     );
//   }
// }

// class MyHomePage2 extends StatefulWidget {
//   const MyHomePage2({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage2> createState() => _MyHomePage2State();
// }

// class _MyHomePage2State extends State<MyHomePage2> {
//   Set<Marker> markers = {};
//   initMarkers() async {
//     // markers = {};

//     for (var i = 0; i < Homepagedatasmap.length; i++) {
//      int j = i + 1;
//       markers.add(Marker(
//         markerId: MarkerId("$j"),
//         position: LatLng(
//             Homepagedatasmap[i]["latitude"], Homepagedatasmap[i]["longitude"]),
//         icon: await CountWidget(count: j).toBitmapDescriptor(),
//       ));
//       setState(() {});
//     }
//   }

//   @override
//   void initState() {
//     initMarkers();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//         ),
//         body: Center(
//             child: GoogleMap(
//           initialCameraPosition: const CameraPosition(
//               target: LatLng(30.488774662306618, 31.032559163868427), zoom: 9),
//           markers: markers,
//           onTap: (s) {
           
//           },
//         )));
//   }
// }

// class CountWidget extends StatelessWidget {
//   const CountWidget({super.key, required this.count});
//   final int count;
//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       maxRadius: 12,
//       backgroundColor: Colors.red,
      
//       child: Text('$count',style: TextStyle(color: Colors.white),),
//     );
//   }
// }

// // class MarkerWidget extends StatelessWidget {
// //   const MarkerWidget({
// //     super.key,
// //   });
// //   @override
// //   Widget build(BuildContext context) {
// //     return Image(
// //       image: const AssetImage(
// //         "assets/marker2.png",
// //       ),
// //       height: 150,
// //       width: 150,
// //     );
// //   }
// // }

// class TextOnImage extends StatelessWidget {
//   const TextOnImage({
//     super.key,
//     required this.text,
//   });
//   final String text;
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Image(
//           image: const AssetImage(
//             "assets/marker.png",
//           ),
//           height: 150,
//           width: 150,
//         ),
//         Text(
//           text,
//           style: TextStyle(color: Colors.black),
//         )
//       ],
//     );
//   }
// }
