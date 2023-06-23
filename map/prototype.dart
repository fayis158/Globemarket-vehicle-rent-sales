// import 'dart:async';
// import 'dart:convert';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;

// class protoscreen extends StatefulWidget {
//   const protoscreen({super.key});

//   @override
//   State<protoscreen> createState() => _protoscreenState();
// }

// class _protoscreenState extends State<protoscreen> {
//   List<LatLng> latlnglisttemp = [];
//   String distance = "0";
//   String ed = "";
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

//   Completer<GoogleMapController> _controller = Completer();
//   Stream<LatLng> getLatLng() async* {
//     GoogleMapController googleMapController = await _controller.future;
//     LatLng x = LatLng(40.777, 77.654);
//     String _formattedDateTimeone;
//     String _formattedDateTime;
//     DateTime now = DateTime.now();
//     _formattedDateTimeone = DateFormat('yyyy-MM-dd 00:00:00').format(now);
//     _formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
//     var res = await http.get(Uri.parse(
//         "http://globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/20007/$_formattedDateTimeone/$_formattedDateTime"));
  
//     if (res.statusCode == 200) {

//       List decodedData = jsonDecode(res.body)["historyData"];
//       latlnglisttemp.clear();
//       for (var i = 0; i < decodedData.length; i++) {
//         x = LatLng(double.parse(decodedData[i]["latitude"]),
//             double.parse(decodedData[i]["longitude"]));
//         latlnglisttemp.add(LatLng(double.parse(decodedData[i]["latitude"]),
//             double.parse(decodedData[i]["longitude"])));

//         distance = decodedData.last["distence"];
//         ed = decodedData.last["trackDateTime"];
  
//         setState(() {});
//         googleMapController.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(target: x, zoom: 13.5),
//         ));

//         // await lastlocation(
//         //     decodedData.last["latitude"], decodedData.last["longitude"]);
//         setState(() {});
//         yield x;
//       }
//       yield x;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: latlnglisttemp.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : StreamBuilder(
//               stream: getLatLng(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return GoogleMap(
//                     markers: {
//                       Marker(
//                           markerId: const MarkerId(
//                             "Marker1",
//                           ),
//                           position: snapshot.data ?? LatLng(40.77, 77.40),
//                           infoWindow: InfoWindow(
//                             title: " ",
//                             snippet: "ED:$ed",
//                           ),
//                           icon: BitmapDescriptor.defaultMarker),
//                       latlnglisttemp.isEmpty
//                           ? const Marker(markerId: MarkerId(""))
//                           : Marker(
//                               markerId: const MarkerId(
//                                 "Marker2",
//                               ),
//                               position: latlnglisttemp.first,
//                               icon: BitmapDescriptor.defaultMarker)
//                     },
//                     polylines: <Polyline>{
//                       Polyline(
//                         polylineId: const PolylineId('myPolyline'),
//                         color: Colors.blue,
//                         width: 5,
//                         points: latlnglisttemp,
//                       ),
//                     },
//                     myLocationEnabled: true,
//                     myLocationButtonEnabled: true,
//                     compassEnabled: true,
//                     tiltGesturesEnabled: false,
//                     initialCameraPosition: CameraPosition(
//                         target: snapshot.data ?? LatLng(40.77, 77.40),
//                         zoom: 13.5),
//                     onMapCreated: (controller) {
//                       _controller.complete(controller);
//                     },
//                   );
//                   // return Text("Loaasing");
//                 }
//                 return const Text("Loading");
//               },
//             ),
//     );
//   }
// }
