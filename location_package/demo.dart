import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// bool isLoaded = false;
List<LatLng> latlnglist = [];

class DemoMapScreen extends StatefulWidget {
  const DemoMapScreen({super.key});

  @override
  State<DemoMapScreen> createState() => _DemoMapScreenState();
}

class _DemoMapScreenState extends State<DemoMapScreen> {
  BitmapDescriptor? myIcon;

  Future<void> _loadIcon() async {
    final BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(12, 10)),
      'images/mapicon.png',
      mipmaps: true,
    );

    setState(() {
      myIcon = bitmapDescriptor;
    });
  }

  Completer<GoogleMapController> _controller = Completer();
  Stream<LatLng> getLatLng() async* {
    LatLng x = const LatLng(11.258753, 75.780411);
// http://globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/17308/2023-03-31 00:00:00/2023-03-31 01:23:00
    String _formattedDateTimeone;
    String _formattedDateTime;
    DateTime now = DateTime.now();
    _formattedDateTimeone = DateFormat('yyyy-MM-dd 00:00:00').format(now);
    _formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    var res = await http.get(Uri.parse(
        "http://globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/19961/$_formattedDateTimeone/$_formattedDateTime"));

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body)["historyData"];
      latlnglist.clear();
      for (var i = 0; i < decodedData.length; i++) {
        x = LatLng(double.parse(decodedData[i]["latitude"]),
            double.parse(decodedData[i]["longitude"]));
        latlnglist.add(LatLng(double.parse(decodedData[i]["latitude"]),
            double.parse(decodedData[i]["longitude"])));

        // ...latlnglist = x;

        setState(() {});
        yield x;
      }

      yield x;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadIcon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getLatLng(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                polylines: <Polyline>{
                  Polyline(
                    polylineId: const PolylineId('myPolyline'),
                    color: Colors.blue,
                    width: 5,
                    points: latlnglist,
                  ),
                },
                markers: {
                  Marker(
                      markerId: const MarkerId(
                        "Marker1",
                      ),
                      position:
                          snapshot.data ?? const LatLng(11.258753, 75.780411),
                      icon: myIcon!),
                  Marker(
                      markerId: const MarkerId(
                        "Marker2",
                      ),
                      position: latlnglist.first,
                      icon: BitmapDescriptor.defaultMarker)
                },

                // markers: _markers,
                // polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target:
                        snapshot.data ?? const LatLng(11.258753, 75.780411)),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: snapshot.data ?? LatLng(11.258753, 75.780411),
                        zoom: 17.0,
                        bearing: 45.0,
                        tilt: 45.0,
                      ),
                    ),
                  );
                  // my map has completed being created;
                  // i'm ready to show the pins on the map
                  // showPinsOnMap();
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            );
          }
          return const Text("Loading...");
        },
      ),
    );
  }
}
