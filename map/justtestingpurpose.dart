import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home/container_row_content/Relay.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/map/vehiclemove.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:humanitarian_icons/humanitarian_icons.dart';
// import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../Screens/Drawer_inside_pages/Report/reports.dart';

import '../Screens/more_in_tabbar.dart/inside_more/Fastag.dart/Fastag.dart';
import 'package:http/http.dart' as http;

import '../playroute/playRoute.dart';

String finalIcon = "";

List<LatLng> latlnglist = [];
int speed = 0;
String distance = "0";
String ed = "";
String vehiclelocation = "";
String currentlocation = "";
String? imageurl;
late GoogleMapController mapController;

class Mytest2 extends StatefulWidget {
  Mytest2(
      {super.key,
      required this.vehiclenum,
      required this.speed,
      required this.vehiclecondition,
      required this.ignition,
      required this.vid,
      required this.latitude,
      required this.longitude,
      required this.location,
      required this.km,
      required this.vehicleid});

  double latitude;
  double longitude;
  String location;
  int km;
  String vehiclenum;
  String vehiclecondition;
  var ignition;
  var speed;
  String vid;
  int vehicleid;

  @override
  State<Mytest2> createState() => _Mytest2State();
}

bool Normal = true;
bool satellite = true;
bool Terrain = true;
bool loc = true;
bool isClicked = false;
bool traffic = false;
var now = DateTime.now();
DateTime? _selectedDate;

final CustomInfoWindowController _customInfoWindowController =
    CustomInfoWindowController();
late GoogleMapController _mapController;

double _zoomLevel = 15.3;
late List<MarkerData> _customMarkers;

class _Mytest2State extends State<Mytest2> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? myIcon;
  // Location location = Location();
  LatLng _markerLocation = LatLng(12.9716, 77.5946);
  String? Live;
  // GoogleMapController controller = await _controller.future;
  GoogleMapController? _mapController;
  final locations = const [
    LatLng(12.9716, 77.5946),
    LatLng(37.41796133580664, -122.085749655962),
    LatLng(37.43796133580664, -122.085749655962),
    LatLng(37.42796133580664, -122.095749655962),
    LatLng(37.42796133580664, -122.075749655962),
  ];
  @override
  void initState() {
    super.initState();
    finalgetlatlang();
    iconapi();
    _customMarkers = [
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-1'), position: locations[0]),
          child: _customMarker2('Everywhere\nis a Widgets', Colors.blue)),
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-5'), position: locations[4]),
          child: _customMarker2('A', Colors.black)),
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-2'), position: locations[1]),
          child: _customMarker2('B', Colors.red)),
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-3'), position: locations[2]),
          child: _customMarker2('C', Colors.green)),
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-4'), position: locations[3]),
          child: _customMarker2('D', Colors.purple)),
      MarkerData(
          marker:
              Marker(markerId: const MarkerId('id-5'), position: locations[4]),
          child: _customMarker2('A', Colors.blue)),
    ];
  }

  _customMarker2(String symbol, Color color) {
    return Container(
      width: 15,
      height: 15,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: color, blurRadius: 6)]),
      child: Center(
          child: Text(
        symbol,
        style: TextStyle(fontSize: 12),
      )),
    );
  }

  finalgetlatlang() async {
    var resultGetLatLang = getLatLng();
    GoogleMapController controller = await _controller.future;
    resultGetLatLang.listen((event) {
      controller.animateCamera(CameraUpdate.newLatLng(event));
      if (mounted) {
        setState(() {});
      }
    });
  }

//strem api call

  Stream<LatLng> getLatLng() async* {
    LatLng x = LatLng(widget.latitude, widget.longitude);
    String _formattedDateTimeone;
    String _formattedDateTime;
    DateTime now = DateTime.now();
    _formattedDateTimeone = DateFormat('yyyy-MM-dd 00:00:00').format(now);
    _formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

    var res = await http.get(Uri.parse(
        "http://globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/${widget.vid}/$_formattedDateTimeone/$_formattedDateTime"));

    if (res.statusCode == 200) {
      latlnglist = [];
      List decodedData = jsonDecode(res.body)["historyData"];
      if (decodedData.isNotEmpty) {
        for (var i = 0; i < decodedData.length; i++) {
          x = LatLng(double.parse(decodedData[i]["latitude"]),
              double.parse(decodedData[i]["longitude"]));
          latlnglist.add(LatLng(double.parse(decodedData[i]["latitude"]),
              double.parse(decodedData[i]["longitude"])));
          // latlnglist.add(x);

          distance = decodedData.last["distence"];
          ed = decodedData.last["trackDateTime"];

          _markerLocation = x;

          if (mounted) {
            setState(() {});
          }

          yield x;
        }
      }
      yield x;
    } else {}
  }
//original code changed after crash
//   iconapi() async {
//     var fetchicondata = await http.get(Uri.parse(
//         "http://globalgps.in:8089/api/v1/LiveDataDetailswithLocationByVid/${widget.vid}"));
//     if (fetchicondata.statusCode == 200) {
//       List icondata = jsonDecode(fetchicondata.body);
//       imageurl = icondata[0]["vehstatus1"];

//       currentlocation = icondata[0]["location"];
//       speed = icondata[0]["speed"];
//       var url = imageurl!.substring(1);

//       finalIcon = "https://globalgps.in/$url";
//       setCustomMarkerIcon();
//       Live = icondata[0]["date"];
//       if(mounted){
//  setState(() {});
//       }

//     }
//   }

  iconapi() async {
    var fetchicondata = await http.get(Uri.parse(
        "http://globalgps.in:8089/api/v1/LiveDataDetailswithLocationByVid/${widget.vid}"));

    if (fetchicondata.statusCode == 200) {
      List icondata = jsonDecode(fetchicondata.body);

      if (icondata != null && icondata.isNotEmpty) {
        imageurl = icondata[0]["vehstatus1"];
        currentlocation = icondata[0]["location"];
        speed = icondata[0]["speed"];

        if (imageurl != null) {
          var url = imageurl!.substring(1);
          finalIcon = "https://globalgps.in/$url";
          setCustomMarkerIcon();
          Live = icondata[0]["date"];

          if (mounted) {
            setState(() {});
          }
        }
      }
    }
  }

  Future<Uint8List> getBytesFromUrl(String url) async {
    var response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  void setCustomMarkerIcon() async {
    Uint8List imageData =
        await getBytesFromUrl(finalIcon); // replace with your image URL
    myIcon = BitmapDescriptor.fromBytes(imageData);
  }

  // Future<void> _loadIcon() async {
  //   // Fetch the icon data from the network
  //   final response = await http.get(Uri.parse(
  //     "https://globalgps.in/Images/RedMapMakers1/car.png",
  //   ));
  //   final bytes = response.bodyBytes;

  //   // Create a BitmapDescriptor from the icon data
  //   final bitmapDescriptor = BitmapDescriptor.fromBytes(f);

  //   setState(() {
  //     myIcon = bitmapDescriptor;
  //   });
  // }

  controllerMapFunction(GoogleMapController controller, LatLng latLng) {
    controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng)));
    if (mounted) {
      setState(() {});
    }
  }

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position:
          RelativeRect.fromLTRB(width(context), height(context) * 0.45, 0, 0),
      items: [
        PopupMenuItem(
          onTap: () {
            setState(() {
              Normal = true;
              satellite = false;
              Terrain = false;
            });
          },
          value: 1,
          child: const Text("Normal"),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              Normal = false;
              satellite = true;
              Terrain = false;
            });
          },
          value: 2,
          child: const Text("Satellite"),
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              Normal = false;
              satellite = false;
              Terrain = false;
            });
          },
          value: 3,
          child: const Text("Terrain"),
        ),
      ],
      elevation: 8.0,
    ).then((value) {});
  }

  onMapCreated(GoogleMapController controller, LatLng latLng) {
    _controller.complete(controller);
    controller.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: latLng)));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customInfoWindowController.dispose();
  }

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('marker1'),
      position: LatLng(37.422, -122.084),
      infoWindow: InfoWindow(
        title: 'Marker 1',
        snippet: 'This is marker 1',
      ),
    ),
  };
  MarkerId _markerId = MarkerId("Marker1");
  _onMapCreated(
    GoogleMapController controller,
  ) {
    controller.showMarkerInfoWindow(const MarkerId('Marker1'));
    controller.showMarkerInfoWindow(_markerId);
    _controller.complete(controller);
    mapController = controller;
    var _cameraPosition = CameraPosition(
      target: _markerLocation,
      zoom: 12,
      tilt: 45,

      // bearing: 90,
    );

    mapController
        .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
    // mapController.animateCamera(
    //   CameraUpdate.newLatLng(_markerLocation!),
    // );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TabBarDemo()),
        );
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TabBarDemo(),
                    ));
                // Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            widget.vehiclenum,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            FocusedMenuHolder(
              animateMenuItems: true,
              openWithTap: true,
              blurSize: 0,
              menuWidth: MediaQuery.of(context).size.width * 0.50,
              onPressed: () {},
              menuItems: [
                FocusedMenuItem(
                    title: Text("30 ${'minutes'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);
                      var earlier = now.add(const Duration(minutes: 30));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate30 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate30);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("2 ${'hour'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);

                      var earlier = now.add(const Duration(hours: 2));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate2 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate2);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("4 ${'hour'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);

                      var earlier = now.add(const Duration(hours: 4));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate2 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate2);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("8 ${'hour'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);

                      var earlier = now.add(const Duration(hours: 8));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate2 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate2);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("12 ${'hour'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);

                      var earlier = now.add(const Duration(hours: 12));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate2 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate2);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("24 ${'hour'.tr()}"),
                    onPressed: () async {
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);

                      var earlier = now.add(const Duration(days: 1));
                      var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var enddate2 = formatterend.format(earlier);

                      await Api.sharebutton(
                          widget.vid, startdatemain, enddate2);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
                FocusedMenuItem(
                    title: Text("${'custom'.tr()}"),
                    onPressed: () async {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(hours: 24)),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedDate),
                          ).then((selectedTime) {
                            if (selectedTime != null) {
                              setState(() {
                                _selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                              });
                            }
                          });
                        }
                      });
                      var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                      var startdatemain = formatter.format(now);
                      await Api.sharebutton(
                          widget.vid, startdatemain, _selectedDate);

                      _shareLink(sharebuttonmap["linkShareText"]);
                    }),
              ],
              child: const SizedBox(
                height: 35,
                width: 50,
                child: Icon(
                  Icons.share,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(children: [
                StreamBuilder(
                  stream: getLatLng(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _controller.future.then(
                        (controller) => controller.animateCamera(
                          CameraUpdate.newLatLng(
                            snapshot.data!,
                          ),
                        ),
                      );

                      return CustomGoogleMapMarkerBuilder(
                          //screenshotDelay: const Duration(seconds: 4),
                          customMarkers: _customMarkers,
                          builder:
                              (BuildContext context, Set<Marker>? markers) {
                            return GoogleMap(
                              trafficEnabled: traffic,
                              onMapCreated: _onMapCreated,
                              // onMapCreated: (GoogleMapController controller) {

                              //   controller
                              //       .showMarkerInfoWindow(const MarkerId('Marker1'));
                              //   _controller.complete(controller);

                              //   // controller.animateCamera(
                              //   //   CameraUpdate.newLatLng(
                              //   //     snapshot.data ??
                              //   //         const LatLng(
                              //   //           40.876,
                              //   //           77.987,
                              //   //         ),
                              //   //   ),
                              //   // );
                              //   setState(
                              //     () {

                              //     },
                              //   );
                              // },
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
                                myIcon != null
                                    ? Marker(
                                        markerId: _markerId,
                                        position: snapshot.data ??
                                            const LatLng(40.876, 77.987),
                                        infoWindow: InfoWindow(
                                          title: "Live:$Live",
                                          snippet:
                                              "Speed:${speed.toString()}      km:$distance ",
                                        ),
                                        icon: myIcon!)
                                    : const Marker(
                                        markerId: MarkerId(
                                          "Marker1",
                                        ),
                                      ),
                                latlnglist.isEmpty
                                    ? Marker(
                                        markerId: MarkerId("1"),
                                        position: LatLng(
                                            widget.latitude, widget.longitude))
                                    : Marker(
                                        markerId: const MarkerId(
                                          "Marker2",
                                        ),
                                        position: latlnglist.first,
                                        icon: BitmapDescriptor.defaultMarker,
                                      )
                              },
                              mapType: Normal == true
                                  ? MapType.normal
                                  : satellite == true
                                      ? MapType.satellite
                                      : Terrain == false
                                          ? MapType.terrain
                                          : MapType.normal,

                              initialCameraPosition: CameraPosition(
                                  target: snapshot.data ??
                                      const LatLng(40.876, 77.987),
                                  zoom: 14),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.purple,
                        ),
                      );
                    }
                  },
                ),
                Positioned(
                  left: width(context) * 0.745,
                  top: height(context) * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            traffic = !traffic;
                          });
                        },
                        child: Container(
                          height: 35,
                          width: 45,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: const Center(
                              child: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                            size: 40,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showPopupMenu(context);
                        },
                        child: Container(
                          height: 35,
                          width: 45,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: const Center(
                              child: Icon(
                            Icons.view_agenda,
                            color: Colors.red,
                            size: 30,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          MapUtils.openMap(widget.latitude, widget.longitude);

                          // MapUtils.openmap(13.0455, 77.5078);
                          setState(() {});
                        },
                        child: Container(
                          height: 35,
                          width: 45,
                          decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: const Center(
                              child: Icon(
                            Icons.double_arrow_sharp,
                            color: Colors.white,
                            size: 30,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => playroo(
                          //           vid: widget.vid,
                          //           vehiclenum: widget.vehiclenum,
                          //         )));
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayTheRoute(
                                    vehiclenum: widget.vehiclenum,
                                    vid: widget.vid,
                                  )));
                        },
                        child: Container(
                            height: 35,
                            width: 90,
                            decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Play Route",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   left: width(context) * 0.75,
                //   top: height(context) * 0.39,
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //           builder: (context) => playroo(
                //                 vid: widget.vid,
                //               )));
                //     },
                //     child: Container(
                //         height: 35,
                //         width: 90,
                //         decoration: const BoxDecoration(
                //             color: Colors.black,
                //             borderRadius: BorderRadius.all(Radius.circular(8))),
                //         child: const Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Center(
                //             child: Text(
                //               "Play Route",
                //               style: TextStyle(color: Colors.white, fontSize: 12),
                //             ),
                //           ),
                //         )),
                //   ),
                // ),
                Positioned(
                  top: height(context) * 0.05,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                      child: ListView.builder(
                        itemCount: Homepagedatasmap.length,
                        itemBuilder: (context, index) {
                          // String title = widget.items[index];
                          List<FocusedMenuItem> menuItems = List.generate(
                            Homepagedatasmap.length,
                            (index) => FocusedMenuItem(
                              title: Text(Homepagedatasmap[index]["vehicleNo"]),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Mytest2(
                                    km: Homepagedatasmap[index]["speed"],
                                    location: Homepagedatasmap[index]
                                        ["finallocation"],
                                    latitude: Homepagedatasmap[index]
                                        ["latitude"],
                                    longitude: Homepagedatasmap[index]
                                        ["longitude"],
                                    vid: Homepagedatasmap[index]["vid"],
                                    ignition: Homepagedatasmap[index]
                                        ["ignition"],
                                    vehiclecondition: Homepagedatasmap[index]
                                                    ["ignition"] ==
                                                "Off" &&
                                            Homepagedatasmap[index]["speed"] ==
                                                0
                                        ? "Stopped"
                                        : Homepagedatasmap[index]["ignition"] ==
                                                    "On" &&
                                                Homepagedatasmap[index]
                                                        ["speed"] ==
                                                    0
                                            ? "idle"
                                            : "Live",
                                    vehiclenum: Homepagedatasmap[index]
                                        ["vehicleNo"],
                                    speed: Homepagedatasmap[index]["speed"],
                                    vehicleid: Homepagedatasmap[index]
                                        ["vehicleId"],
                                  ),
                                ));
                              },
                            ),
                          );
                          return FocusedMenuHolder(
                              menuWidth:
                                  MediaQuery.of(context).size.width * 0.50,
                              // blurSize: 5.0,
                              // menuItemExtent: 45,
                              menuBoxDecoration: const BoxDecoration(
                                color: Color.fromARGB(0, 255, 255, 255),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                              ),
                              duration: const Duration(milliseconds: 100),
                              animateMenuItems: true,
                              blurBackgroundColor: Colors.black54,
                              openWithTap: true,
                              menuOffset: 10.0,
                              onPressed: () {},
                              menuItems: menuItems,
                              child: Container(
                                  height: 45,
                                  width: 22,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(0, 255, 255, 255),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(0))),
                                  child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.double_arrow_outlined,
                                        color: Colors.black,
                                        size: 27,
                                      ))));
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                          icon: Icon(isClicked == false
                              ? Icons.keyboard_double_arrow_down_sharp
                              : Icons.keyboard_double_arrow_up_sharp)),
                    ],
                  ),
                ),
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 75,
                  width: 150,
                  offset: 50,
                ),
              ]),
            ),
            Container(
              width: width(context),
              height: isClicked == false ? null : 0,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          // height: 50,
                          width: width(context) * 0.35,
                          child: Text(
                            currentlocation,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: height(context) * 0.09,
                          width: width(context) * 0.27,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            // color: Colors.green,
                          ),
                          child: Image.asset(
                            "images/odo2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "       ${speed.toString()} km /h",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Color.fromARGB(255, 66, 63, 33),
                              child: widget.vehicleid == 8
                                  ? Image.asset(
                                      "images/Bull.png",
                                      color: Colors.white,
                                      height: 28,
                                      fit: BoxFit.cover,
                                    )
                                  : widget.vehicleid == 16
                                      ? Image.asset(
                                          "images/jc.png",
                                          color: Colors.white,
                                          height: 28,
                                        )
                                      : widget.vehicleid == 10
                                          ? FaIcon(
                                              FontAwesomeIcons.tractor,
                                              color: Colors.white,
                                            )
                                          : widget.vehicleid == 7
                                              ? Image.asset(
                                                  "images/van.png",
                                                  height: 30,
                                                  color: Colors.white,
                                                )
                                              : widget.vehicleid == 6
                                                  ? Image.asset(
                                                      "images/jeep.png",
                                                      height: 30,
                                                      color: Colors.white,
                                                    )
                                                  : widget.vehicleid == 11
                                                      ? Image.asset(
                                                          "images/rolller.png",
                                                          height: 30,
                                                          color: Colors.white,
                                                        )
                                                      : widget.vehicleid == 12
                                                          ? Image.asset(
                                                              "images/tipper.png",
                                                              height: 35,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : widget.vehicleid ==
                                                                  13
                                                              ? Image.asset(
                                                                  "images/hitachi1.png",
                                                                  height: 40,
                                                                  color: Colors
                                                                      .white,
                                                                )
                                                              : widget.vehicleid ==
                                                                      14
                                                                  ? Image.asset(
                                                                      "images/tanker.png",
                                                                      height:
                                                                          35,
                                                                      color: Colors
                                                                          .white,
                                                                    )
                                                                  : widget.vehicleid ==
                                                                          15
                                                                      ? Image
                                                                          .asset(
                                                                          "images/grader.png",
                                                                          height:
                                                                              35,
                                                                          color:
                                                                              Colors.white,
                                                                        )
                                                                      : widget.vehicleid ==
                                                                              17
                                                                          ? Image
                                                                              .asset(
                                                                              "images/crane.png",
                                                                              height: 35,
                                                                              color: Colors.white,
                                                                            )
                                                                          : widget.vehicleid == 4
                                                                              ? Image.asset(
                                                                                  "images/bike.png",
                                                                                  height: 25,
                                                                                  color: Colors.white,
                                                                                )
                                                                              : Icon(
                                                                                  widget.vehicleid == 1
                                                                                      ? CupertinoIcons.car_detailed
                                                                                      : widget.vehicleid == 2
                                                                                          ? FontAwesomeIcons.truck
                                                                                          : widget.vehicleid == 3
                                                                                              ? Icons.directions_bus_rounded
                                                                                              : widget.vehicleid == 5
                                                                                                  ? HumanitarianIcons.ambulance
                                                                                                  : widget.vehicleid == 9
                                                                                                      ? Icons.man
                                                                                                      : null,
                                                                                  color: Colors.white,
                                                                                  size: widget.vehicleid == 1 || widget.vehicleid == 2 || widget.vehicleid == 3 || widget.vehicleid == 5 || widget.vehicleid == 9 ? 25 : 0,
                                                                                ),
                            ),
                            Text(
                              widget.vehiclecondition,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Reports(),
                                ));
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 175, 173),
                                child: Icon(
                                  Icons.report,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              "Report",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  Color.fromARGB(255, 117, 235, 215),
                              child: Icon(
                                Icons.key,
                                color: Color.fromARGB(255, 187, 184, 2),
                              ),
                            ),
                            Text(
                              widget.ignition,
                              style: const TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => playroo(
                                          vehiclenum: widget.vehiclenum,
                                          vid: widget.vid,
                                        )));
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Color.fromARGB(255, 173, 185, 255),
                                child: Icon(
                                  Icons.history,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              "History",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Positioned(
                                    child: InkWell(
                                  onTap: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Relay(vid: widget.vid),
                                        ));
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return AlertDialog(
                                    //       content: Container(
                                    //         height: height(context) * 0.15,
                                    //         width: double.infinity,
                                    //         decoration: const BoxDecoration(
                                    //             borderRadius: BorderRadius.all(
                                    //                 Radius.circular(40))),
                                    //         child: Column(
                                    //           children: [
                                    //             const SizedBox(
                                    //               height: 10,
                                    //             ),
                                    //             const Text(
                                    //               "Are You sure You Want on Relay ?",
                                    //               textAlign: TextAlign.center,
                                    //               style: TextStyle(
                                    //                   fontWeight:
                                    //                       FontWeight.w700),
                                    //             ),
                                    //             const SizedBox(
                                    //               height: 40,
                                    //             ),
                                    //             Row(
                                    //               mainAxisAlignment:
                                    //                   MainAxisAlignment
                                    //                       .spaceAround,
                                    //               children: [
                                    //                 ElevatedButton(
                                    //                     style: ButtonStyle(
                                    //                         backgroundColor:
                                    //                             MaterialStateProperty
                                    //                                 .all(const Color
                                    //                                         .fromARGB(
                                    //                                     255,
                                    //                                     53,
                                    //                                     64,
                                    //                                     114)),
                                    //                         shape: MaterialStateProperty.all<
                                    //                                 RoundedRectangleBorder>(
                                    //                             RoundedRectangleBorder(
                                    //                           borderRadius:
                                    //                               BorderRadius
                                    //                                   .circular(
                                    //                                       16.0),
                                    //                         ))),
                                    //                     onPressed: () {},
                                    //                     child: const Text(
                                    //                       "Yes",
                                    //                       style: TextStyle(
                                    //                           color: Colors.white,
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .w800),
                                    //                     )),
                                    //                 ElevatedButton(
                                    //                     style: ButtonStyle(
                                    //                         backgroundColor:
                                    //                             MaterialStateProperty
                                    //                                 .all(
                                    //                           const Color
                                    //                                   .fromARGB(
                                    //                               255,
                                    //                               202,
                                    //                               245,
                                    //                               228),
                                    //                         ),
                                    //                         shape: MaterialStateProperty.all<
                                    //                                 RoundedRectangleBorder>(
                                    //                             RoundedRectangleBorder(
                                    //                           borderRadius:
                                    //                               BorderRadius
                                    //                                   .circular(
                                    //                                       16.0),
                                    //                         ))),
                                    //                     onPressed: () {
                                    //                       Navigator.pop(context);
                                    //                     },
                                    //                     child: const Text(
                                    //                       "No",
                                    //                       style: TextStyle(
                                    //                           color: Colors.black,
                                    //                           fontWeight:
                                    //                               FontWeight
                                    //                                   .w800),
                                    //                     ))
                                    //               ],
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  }),
                                  child: const CircleAvatar(
                                    backgroundColor:
                                        Color.fromARGB(255, 236, 169, 169),
                                    radius: 22,
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                      // size: 45,
                                    ),
                                  ),
                                ))
                              ],
                            ),
                            const Text("Relay")
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                launchUrl(
                                    Uri.parse('https://www.globalgps.in/'));
                              },
                              child: const CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Color.fromARGB(255, 235, 223, 117),
                                child: Icon(
                                  Icons.screen_share_rounded,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const Text(
                              "Links",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: width(context),
              color: Colors.white,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Buy_GPS2(
                                      text: '',
                                    )));
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Color.fromARGB(255, 173, 255, 210),
                            child: Icon(
                              Icons.shopify_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text(
                          "New GPS",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            const Fastag().navigateTo(context);
                          },
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundColor: Color.fromARGB(255, 174, 250, 155),
                            child: Icon(
                              Icons.tag,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text(
                          "Fastag",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Column(
                      children: const [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 255, 173, 237),
                          child: Icon(
                            Icons.offline_bolt_sharp,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Fuel",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Column(
                      children: const [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Color.fromARGB(255, 177, 177, 177),
                          child: Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Live",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  // void _setInitialZoom() async {
  //   await Future.delayed(Duration(seconds: 2)); // wait for 2 seconds
  //   setState(() {
  //     _zoomLevel = 16; // set zoom level to 9.0 after 2 seconds
  //   });
  //   _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: snapshot.data ??  LatLng(widget.latitude, widget.longitude), zoom: _zoomLevel)));
  // }
}

_shareLink(var link) {
  Share.share(link,
      subject: 'Check out this link',
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
