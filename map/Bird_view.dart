
// main page bird


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// class bird extends StatefulWidget {
//   @override
//   _birdState createState() => _birdState();
// }

// class _birdState extends State<bird> {
//   getResponse() {
//     http
//         .get(
//             Uri.parse("http://globalgps.in:8089/api/v6/Live/Details/$finalUid"))
//         .then((value) {
//       var firstStep = jsonDecode(value.body);

//     });
//   }

//   BitmapDescriptor? myIcon;

//   Completer<GoogleMapController> _controller = Completer();
  
//   // List<Map<String, dynamic>> _markerList = [    {      "rowNo": 1,      "vehicleNo": "Bhopal",      "latitude": 13.0457,      "longitude": 77.508,      "vehstatus": "../Images/RedMapMakers/ambulance.png",    },    {      "rowNo": 2,      "vehicleNo": "bus 9999",      "latitude": 13.0459,      "longitude":77.506,      "vehstatus": "../Images/RedMapMakers/carwash.png",    },    {      "rowNo": 3,      "vehicleNo": "1111 2023",      "latitude": 13.0461,      "longitude": 77.5062,      "vehstatus": "../Images/RedMapMakers/carwash.png",    }  ];

//   // function to convert the image path to BitmapDescriptor
//   Future<BitmapDescriptor> _bitmapDescriptorFromImagePath(
//       String imagePath, int size) async {
//     // get the byte data from the image file
//     final bytes = await DefaultAssetBundle.of(context).load(imagePath);
//     final codec = await instantiateImageCodec(bytes.buffer.asUint8List(),
//         targetWidth: size);

//     final frameInfo = await codec.getNextFrame();
//     final data = await frameInfo.image.toByteData(format: ImageByteFormat.png);

//     return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
//   }

//   Future<BitmapDescriptor> getMarkerIconFromUrl(
//       String imageUrl, int size) async {
//     final response = await http.get(Uri.parse(imageUrl));
//     final bytes = await http.ByteStream.fromBytes(response.bodyBytes).toBytes();
//     return BitmapDescriptor.fromBytes(bytes, size: Size(3.5, 3.5));
//   }

//   // function to create marker from the marker list
//   Set<Marker> _createMarkers(List markers) {
//     Set<Marker> markersSet = {};

//     markers.forEach((marker) async {
//       // get the BitmapDescriptor from the image path

//       // String url = "https://globalgps.in/${marker['vehstatus']}";
//       //   final response = url.replaceAll('/../', '/');

//       // BitmapDescriptor markerIcon = await getMarkerIconFromUrl(
//       //     response, 100);

//       Marker newMarker = Marker(

//         markerId: MarkerId(marker['rowNo'].toString()),
//         position: LatLng(marker['latitude'], marker['longitude']),
//         icon: myIcon == null ? BitmapDescriptor.defaultMarker : myIcon!,
//         infoWindow: InfoWindow(
//           title: marker['vehicleNo'],
//         ),
//       );

//       markersSet.add(newMarker);
//     });

//     return markersSet;
//   }

//   void _loadIcon() async {
//     final ImageConfiguration config = createLocalImageConfiguration(context);
//     final ImageProvider markerImage = NetworkImage(
//         'https://globalgps.in/Images/GrayMapMakers/motorcycle.png');
//     final Completer<BitmapDescriptor> markerIcon = Completer();

//     markerImage
//         .resolve(config)
//         .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
//       final ByteData? bytes =
//           await image.image.toByteData(format: ImageByteFormat.png);
//       final BitmapDescriptor bitmap =
//           BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
//       markerIcon.complete(bitmap);
//     }));

//     myIcon = await markerIcon.future;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadIcon();
//     getResponse();
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Google Maps Demo'),
//       ),
//       body: GoogleMap(
//         markers: _createMarkers(Homepagedatasmap),
//         onMapCreated: (GoogleMapController controller) async {
//           _controller.complete(controller);

//           final MarkerId markerId = MarkerId('3');
//           await controller.showMarkerInfoWindow(markerId);
//         },
//         initialCameraPosition:
//             CameraPosition(target: LatLng(13.0461, 77.5062), zoom: 5),
//       ),
//     );
//   }
// }

//working fine
class bird extends StatefulWidget {
  @override
  _birdState createState() => _birdState();
}

class _birdState extends State<bird> {
  Completer<GoogleMapController> _controller = Completer();
  List<Map<String, dynamic>> _markerList = [    {      "rowNo": 1,      "vehicleNo": "Bhopal",      "latitude": 13.0457,      "longitude": 77.508,      "vehstatus": "../Images/RedMapMakers/ambulance.png",    },    {      "rowNo": 2,      "vehicleNo": "bus 9999",      "latitude": 13.0459,      "longitude": 77.506,      "vehstatus": "../Images/RedMapMakers/carwash.png",    },    {      "rowNo": 3,      "vehicleNo": "1111 2023",      "latitude": 13.0461,      "longitude": 77.5062,      "vehstatus": "../Images/RedMapMakers/carwash.png",    }  ];

  // function to convert the image path to BitmapDescriptor
  Future<BitmapDescriptor> _bitmapDescriptorFromImagePath(
      String imagePath, int size) async {
    // get the byte data from the image file
    final bytes = await DefaultAssetBundle.of(context).load(imagePath);
    final codec = await instantiateImageCodec(bytes.buffer.asUint8List(),
        targetWidth: size);

    final frameInfo = await codec.getNextFrame();
    final data = await frameInfo.image.toByteData(format: ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  // function to create marker from the marker list
  Set<Marker> _createMarkers(List markers) {
    Set<Marker> markersSet = {};

    markers.forEach((marker) async {
      // get the BitmapDescriptor from the image path
      // BitmapDescriptor markerIcon =
      //     await _bitmapDescriptorFromImagePath("https://globalgps.in/Images/RedMapMakers/ambulance.png", 100);//marker['vehstatus']

    // Create a BitmapDescriptor from the image bytes
       // Replace with your image URL

      Marker newMarker = Marker(
        markerId: MarkerId(marker['rowNo'].toString()),
        position: LatLng(marker['latitude'], marker['longitude']),
        icon:BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: marker['vehicleNo'],
        ),
      );

      markersSet.add(newMarker);
    });

    return markersSet;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Google Maps Demo'),
      ),
      body: GoogleMap(
        markers: _createMarkers(_markerList),
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);

          // show all marker info windows
          Set<Marker> markers = _createMarkers(_markerList);
          for (Marker marker in markers) {
            await controller.showMarkerInfoWindow(marker.markerId);
          }
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(13.0461, 77.5062),
          zoom: 10,
        ),
      ),
    );
  }
}



// class bird extends StatefulWidget {
//   @override
//   _birdState createState() => _birdState();
// }

// class _birdState extends State<bird> {
//   Completer<GoogleMapController> _controller = Completer();
//   List<Map<String, dynamic>> _markerList = [
//     {
//       "rowNo": 1,
//       "vehicleNo": "Bhopal",
//       "latitude": 13.0457,
//       "longitude": 77.508,
//       "vehstatus": "https://globalgps.in/Images/RedMapMakers/ambulance.png",
//     },
//     {
//       "rowNo": 2,
//       "vehicleNo": "bus 9999",
//       "latitude": 13.0459,
//       "longitude": 77.506,
//       "vehstatus": "https://globalgps.in/Images/RedMapMakers/carwash.png",
//     },
//     {
//       "rowNo": 3,
//       "vehicleNo": "1111 2023",
//       "latitude": 13.0461,
//       "longitude": 77.5062,
//       "vehstatus": "https://globalgps.in/Images/RedMapMakers/carwash.png",
//     }
//   ];

//   // function to convert the image path to BitmapDescriptor
//   Future<BitmapDescriptor> _bitmapDescriptorFromImagePath(
//       String imagePath, int size) async {
//     // get the byte data from the image file
//     final bytes =
//         await (await NetworkAssetBundle(Uri.parse(imagePath)).load(imagePath))
//             .buffer
//             .asUint8List();
//     final codec = await instantiateImageCodec(bytes, targetWidth: size);

//     final frameInfo = await codec.getNextFrame();
//     final data = await frameInfo.image.toByteData(format: ImageByteFormat.png);

//     return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
//   }

//   // function to create marker from the marker list
//   Set<Marker> _createMarkers(List markers) {
//     Set<Marker> markersSet = {};

//     markers.forEach((marker) async {
//       // get the BitmapDescriptor from the image path
// //       BitmapDescriptor markerIcon = await _bitmapDescriptorFromImagePath(
// //           "https://globalgps.in/Images/RedMapMakers/ambulance.png", 100);


// // //custom
// //       Future<BitmapDescriptor> getMarkerIconFromUrl(
// //           String imageUrl, int size) async {
// //         final response = await http.get(Uri.parse(
// //             "https://globalgps.in/Images/RedMapMakers/ambulance.png"));
// //         final bytes =
// //             await http.ByteStream.fromBytes(response.bodyBytes).toBytes();
// //         return BitmapDescriptor.fromBytes(
// //           bytes,
// //         );
// //       }

// //       BitmapDescriptor myIcon = await getMarkerIconFromUrl(
// //           "https://globalgps.in/Images/RedMapMakers/ambulance.png", 100);


//       // Create a BitmapDescriptor from the image bytes
//       Marker newMarker = Marker(
//         markerId: MarkerId(marker['rowNo'].toString()),
//         position: LatLng(marker['latitude'], marker['longitude']),
//         icon:  BitmapDescriptor.defaultMarker,
//         infoWindow: InfoWindow(
//           title: marker['vehicleNo'],
//         ),
//       );

//       markersSet.add(newMarker);
//     });

//     return markersSet;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Google Maps Demo'),
//       ),
//       body: GoogleMap(
//         markers: _createMarkers(_markerList),
//         onMapCreated: (GoogleMapController controller) async {
//           _controller.complete(controller);

//           // show all marker info windows
//           Set<Marker> markers = _createMarkers(_markerList);
//           for (Marker marker in markers) {
//             await controller.showMarkerInfoWindow(marker.markerId);
//           }
//         },
//         initialCameraPosition: CameraPosition(
//           target: LatLng(13.0461, 77.5062),
//           zoom: 10,
//         ),
//       ),
//     );
//   }
// }







//duplicate
// class bird extends StatefulWidget {
//   @override
//   _birdState createState() => _birdState();
// }

// class _birdState extends State<bird> {
//   Completer<GoogleMapController> _controller = Completer();
//   List<Map<String, dynamic>> _markerList = [
//     {
//       "rowNo": 1,
//       "vehicleNo": "Bhopal",
//       "latitude": 13.0457,
//       "longitude": 77.508,
//       "vehstatus": "../Images/RedMapMakers/ambulance.png",
//     },
//     {
//       "rowNo": 2,
//       "vehicleNo": "bus 9999",
//       "latitude": 13.0459,
//       "longitude": 77.506,
//       "vehstatus": "../Images/RedMapMakers/carwash.png",
//     },
//     {
//       "rowNo": 3,
//       "vehicleNo": "1111 2023",
//       "latitude": 13.0461,
//       "longitude": 77.5062,
//       "vehstatus": "../Images/RedMapMakers/carwash.png",
//     }
//   ];

//   // function to convert the image path to BitmapDescriptor
//   Future<BitmapDescriptor> _bitmapDescriptorFromImagePath(
//       String imagePath, int size) async {
//     // get the byte data from the image file
//     final bytes = await DefaultAssetBundle.of(context).load(imagePath);
//     final codec = await instantiateImageCodec(bytes.buffer.asUint8List(),
//         targetWidth: size);

//     final frameInfo = await codec.getNextFrame();
//     final data = await frameInfo.image.toByteData(format: ImageByteFormat.png);

//     return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
//   }

//   // function to create marker from the marker list
//   Set<Marker> _createMarkers(List markers) {
//     Set<Marker> markersSet = {};

//     markers.forEach((marker) async {
//       // get the BitmapDescriptor from the image path
//       // BitmapDescriptor markerIcon =
//       //     await _bitmapDescriptorFromImagePath(marker['vehstatus'], 100);

//       Marker newMarker = Marker(
//         markerId: MarkerId(marker['rowNo'].toString()),
//         position: LatLng(marker['latitude'], marker['longitude']),
//         icon: BitmapDescriptor.defaultMarker,
//         infoWindow: InfoWindow(
//           title: marker['vehicleNo'],
//         ),
//       );

//       markersSet.add(newMarker);
//     });

//     return markersSet;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Google Maps Demo'),
//       ),
//       body: GoogleMap(
//         markers: _createMarkers(_markerList),
//         onMapCreated: (GoogleMapController controller) async {
//           _controller.complete(controller);
//           final MarkerId markerId = MarkerId('1');
//           await controller.showMarkerInfoWindow(markerId);
//         },
//         initialCameraPosition:
//             CameraPosition(target: LatLng(13.0461, 77.5062), zoom: 10),
//       ),
//     );
//   }
// }




// dont delete
///  String imageUrl = 'https://globalgps.in/Images/RedMapMakers/ambulance.png';

    // // Get the bytes of the image from the URL
    // http.Response response = await http.get(Uri.parse(imageUrl));
    // Uint8List bytes = response.bodyBytes;

    // // Create a BitmapDescriptor from the image bytes
    // BitmapDescriptor bitmapDescriptor =
    //     BitmapDescriptor.fromBytes(bytes);
   

    // BitmapDescriptor markerIcon =
    //     BitmapDescriptor.fromBytes(bytes);
