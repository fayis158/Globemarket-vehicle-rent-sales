//play route

import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:http/http.dart' as http;
import '../../Constant.dart';
import 'dart:math';
import 'dart:math' as math;


DateTime startdate = DateTime.now();
DateTime enddate = DateTime.now();
DateTime _selectedDateTime = DateTime.now();



String starteddateselected =
    DateFormat('dd-MM-yyyy 00:00:00').format(startdate);
String enddateselected = DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);








class playroo extends StatefulWidget {
  String vid;
  String vehiclenum;

  playroo({super.key, required this.vid, required this.vehiclenum});

  @override
  playrooState createState() => playrooState();
}

class playrooState extends State<playroo> with TickerProviderStateMixin {
  int vehiclespeed = 2;

  Completer<GoogleMapController> _controller = Completer();

  late Marker _marker;
  late Marker _marker2;
  LatLng? _markerLocation;
  int _polylineIndex = 0;
  BitmapDescriptor? myIcon;
  List<dynamic> _data = [];
  List<LatLng> _points = [];

  List<LatLng> stoppagepoint = [];
  late GoogleMapController mapController;
  GlobalKey actionKey = GlobalKey();
  bool selectedtoday = true;
  bool selectedyesterday = false;
  bool selecteddaybeforeyesterday = false;
  bool selecteddayrandom = false;
  bool _isLoading = false;
  bool showmessage = false;
  bool _isLoadingindicator = true;

  bool veryslow = true;
  bool slow = true;
  bool normal = true;
  bool fast = true;
  bool veryfast = true;

  // int speedofvehicle = 600;

  late List<MarkerData> _customMarkers;

  List pointofstopped = [];
  int lengthofstoppagepoint = 0;

  double _sliderValue = 0.0;
  bool _isPlaying = false;
  // int _sliderValue2=10;

  Timer? _timer;
  bool run = false;
  int speedofmovement = 600;
  // double maxLength = 0.0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
//parse the date

  String datea1 = '';

  changeformat(String date) {
    String input = date;
    String output = formatDate(input);
    datea1 = output;
  }

  String formatDate(String input) {
    DateTime dateTime = DateTime.parse(input);
    DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm:ss a');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  String dis = '';
  String speed = '';
  String date = '';

  progress(int pos) {
    setState(() {
      // _sliderValue2 = pos;
      _sliderValue = pos.toDouble();

      dis = _data[pos]["distence"];
      speed = "${_data[pos]["speed"]} Km/h";
      date = _data[pos]["trackDateTime"];

      if (_sliderValue >= _data.length.toDouble()) {
        _stop();
      }
    });
  }

  void _start(int pos) {
    setState(() {
      _sliderValue = pos.toDouble();
    });
    // _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
    //   setState(() {
    //     _sliderValue += 1;
    //     if (_sliderValue > 100) {
    //       _stop();
    //     }
    //   });
    // });
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  int? hours;
  int? minutes;
  int? seconds;
  String? lastkm;

  ///api fetch data

  Future<void> _fetchDataHistory(
    String vid,
  ) async {
    final response = await http.get(Uri.parse(
        'http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/$vid/$starteddateselected/$enddateselected'));
    if (response.statusCode == 200) {
      final extractedData = json.decode(response.body);
      showmessage = true;
      setState(() {
        _data = extractedData["historyData"];
        String firstdate = _data.last["trackDateTime"];
        String lastdate = _data.first["trackDateTime"];
      });
      // convertionAndCount();
      lastkm = _data.last["distence"];
      List stop = extractedData["stoppagePoints"];

      stop.isNotEmpty
          ? stoppagepoint.add(LatLng(stop[0]["latitude"], stop[0]["longitude"]))
          : null;

      if (extractedData["historyData"] != null) {
        setState(() {});
      }
    } else {}
  }
  // api fecth data stoppoint

  Future<void> stoppagepoints(
    String vid,
  ) async {
    // pointofstopped.clear();
    final response = await http.get(Uri.parse(
        'http://www.globalgps.in:8089/api/v1/History/GetHistoryWithStoppagePointsByVid/$vid/$starteddateselected/$enddateselected'));

    if (response.statusCode == 200) {
      final extractedDatapoint = json.decode(response.body);
      List stoppagepoints = extractedDatapoint["stoppagePoints"];
      lengthofstoppagepoint = stoppagepoints.length;
      for (int i = 0; i < stoppagepoints.length; i++) {
        pointofstopped.add(LatLng(
            stoppagepoints[i]["latitude"], stoppagepoints[i]["longitude"]));

        // _customMarkers = [];
        // _customMarkers.clear();
        for (int i = 0; i < pointofstopped.length; i++) {
          String str = "${stoppagepoints[i]["haltedDuration"]}";

          // healted to

          String date = stoppagepoints[i]["haltedFromDate"];
          DateTime dateTime = DateTime.parse(date);
          DateFormat formatter = DateFormat('dd-MMM-yyyy hh:mm:ss a');
          String formattedDate = formatter.format(dateTime);

          //healted from

          String date2 = stoppagepoints[i]["haltedToDate"];
          DateTime dateTime2 = DateTime.parse(date);
          DateFormat formatter2 = DateFormat('dd-MMM-yyyy hh:mm:ss a');
          String formattedDate2 = formatter.format(dateTime);

          //
          // changeformat(str);
          List<String> parts =
              str.split("."); // split the string at the decimal point
          String timePart = parts[0]; // extract the time part

          _customMarkers.add(
            MarkerData(
              marker: Marker(
                  markerId: MarkerId('marker$i'),
                  position: pointofstopped[i],
                  infoWindow: InfoWindow(
                      title:
                          "Stop Time:$timePart km: ${stoppagepoints[i]["kMsTravelled"]}km",
                      snippet: " From: $formattedDate  Till: $formattedDate2")),
              child: _customMarker2('${i + 1}', Colors.red),
            ),
          );
        }
      }
    } else {}
  }

  final LatLng _startPosition = const LatLng(37.4219999, -122.0840575);
  final LatLng _endPosition =
      const LatLng(37.42796133580664, -122.085749655962);
  late AnimationController _animatecontroller;
  late LatLng _markerPosition;

  bool mapviewstart = true;

  @override
  void initState() {
    super.initState();
    stoppagepoints(widget.vid);
    setInitialMarkerLocation();
  
    BitmapDescriptor.fromAssetImage(
      
             ImageConfiguration(size: Size(11, 11),
             devicePixelRatio: 1,
            ), 'images/car2.png',
            
            mipmaps: true)
        .then((onValue) {
      myIcon = onValue;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showMenuOptions();
    });
    DateTime startdateyesterday = DateTime.now();
    startdate = DateTime(startdateyesterday.year, startdateyesterday.month,
        startdateyesterday.day, 00, 0);
    enddate = DateTime(
        startdateyesterday.year,
        startdateyesterday.month,
        startdateyesterday.day,
        startdateyesterday.hour,
        startdateyesterday.minute,
        startdateyesterday.second);
    var formattedYesterdayStart =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(startdate);
    String formattedYesterdayend =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
    starteddateselected = formattedYesterdayStart;
    enddateselected = formattedYesterdayend;

    // _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
    setInitialMarkerLocation();
    _customMarkers = [];
    loa();
    stoptimeapicall();
  }

  loa() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoadingindicator = false;
      });
    });
  }

  String intervel = '0';

  String stoptym = '';
  String todaykm = '';
  String idlehr = '';
  String idlecount = '';

  stoptimeapicall() async {
    stoptym = await Api.stoppagekmplay(
        widget.vid, starteddateselected, enddateselected, intervel);
    todaykm = await Api.Todaykmplay(
        widget.vid, starteddateselected, enddateselected, intervel);
    idlehr = await Api.idlehr(
        widget.vid, starteddateselected, enddateselected, intervel);
    idlecount = await Api.idlecount(
        widget.vid, starteddateselected, enddateselected, intervel);
    setState(() {});
  }

  void showMenuOptions() {
    final RenderBox renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
          position.dx, position.dy + size.height, position.dx + size.width, 0),
      items: [
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.check,
                  color: selectedtoday == true ? Colors.green : Colors.grey),
              const Text("Today"),
            ],
          ),
          onTap: () {
            mapviewstart = false;
            _points.clear();
            _isLoadingindicator = true;
            setState(() {
              selectedtoday = true;
              selectedyesterday = false;
              selecteddaybeforeyesterday = false;
              selecteddayrandom = false;
              DateTime startdateyesterday = DateTime.now();
              startdate = DateTime(startdateyesterday.year,
                  startdateyesterday.month, startdateyesterday.day, 00, 0);
              enddate = DateTime(
                  startdateyesterday.year,
                  startdateyesterday.month,
                  startdateyesterday.day,
                  startdateyesterday.hour,
                  startdateyesterday.minute,
                  startdateyesterday.second);
              String formattedYesterdayStart =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(startdate);
              String formattedYesterdayend =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
              starteddateselected = formattedYesterdayStart;
              enddateselected = formattedYesterdayend;
              _customMarkers.clear();
              stoppagepoints(widget.vid);
              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              stoptimeapicall();
              intervel = '0';
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.check,
                  color:
                      selectedyesterday == true ? Colors.green : Colors.grey),
              const Text("Yesterday"),
            ],
          ),
          onTap: () {
            mapviewstart = false;
            _points.clear();
            _isLoadingindicator = true;
            setState(() {
              selectedtoday = false;
              selecteddaybeforeyesterday = false;
              selectedyesterday = true;
              selecteddayrandom = false;

              DateTime startdateyesterday = DateTime.now();

              startdate = DateTime(startdateyesterday.year,
                  startdateyesterday.month, startdateyesterday.day - 1, 00, 0);
              enddate = DateTime(
                  startdateyesterday.year,
                  startdateyesterday.month,
                  startdateyesterday.day - 1,
                  23,
                  59,
                  59);
              String formattedYesterdayStart =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(startdate);
              String formattedYesterdayend =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
              starteddateselected = formattedYesterdayStart;
              enddateselected = formattedYesterdayend;
              stoppagepoints(widget.vid);
              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              intervel = '1';
            });
          },
        ),
        PopupMenuItem(
          child: Row(
            children: [
              Icon(Icons.check,
                  color: selecteddaybeforeyesterday == true
                      ? Colors.green
                      : Colors.grey),
              const Text("Day Before Yesterday"),
            ],
          ),
          onTap: () {
            mapviewstart = false;
            _points.clear();
            _isLoadingindicator = true;
            setState(() {
              selectedtoday = false;
              selectedyesterday = false;
              selecteddaybeforeyesterday = true;
              selecteddayrandom = false;

              DateTime startdateyesterday = DateTime.now();

              startdate = DateTime(startdateyesterday.year,
                  startdateyesterday.month, startdateyesterday.day - 2, 00, 00);
              enddate = DateTime(
                  startdateyesterday.year,
                  startdateyesterday.month,
                  startdateyesterday.day - 2,
                  23,
                  59,
                  59);
              String formattedYesterdayStart =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(startdate);
              String formattedYesterdayend =
                  DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
              starteddateselected = formattedYesterdayStart;
              enddateselected = formattedYesterdayend;
              stoppagepoints(widget.vid);
              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              intervel = '2';
              stoptimeapicall();
            });
          },
        ),
        PopupMenuItem(
          onTap: () {
            setState(() {
              buildLanguageDialog2(context);
              selectedtoday = false;
              selectedyesterday = false;
              selecteddaybeforeyesterday = false;
              selecteddayrandom = true;
            });
          },
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
              setState(() {
                buildLanguageDialog2(context);
                selectedtoday = false;
                selectedyesterday = false;
                selecteddaybeforeyesterday = false;
                selecteddayrandom = true;
              });

              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.055,
              color: const Color.fromARGB(0, 255, 255, 255),
              child: Row(
                children: [
                  Icon(Icons.check,
                      color: selecteddayrandom == true
                          ? Colors.green
                          : Colors.grey),
                  const Text('Userdefined'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _drawPolyline() {
    for (var data in _data) {
      double lat = double.parse(data['latitude']);
      double lng = double.parse(data['longitude']);
      _points.add(LatLng(lat, lng));
    }
    setState(() {
      _isLoading = false;
      setInitialMarkerLocation();
    });
  }

  Future pickDateTime2(ValueChanged<DateTime> onDateSelected) async {
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

    onDateSelected(newdateTime);
  }

  Future pickDateTime(ValueChanged<DateTime> onDateSelected) async {
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

    onDateSelected(newdateTime);
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: startdate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: startdate.hour, minute: startdate.minute));

  void _onMapCreated(GoogleMapController controller) {
    // _controller.complete(controller);
    var _cameraPosition = CameraPosition(
      target: _markerLocation!,
      zoom: 17,
      tilt: 45,
      // bearing: 90,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

    // controller.showMarkerInfoWindow(const MarkerId('marker2'));  // commented to check crashing
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehiclenum),
        actions: [
          TextButton(
              onPressed: () {
                // run == false ? moveMarker() : null;
                // run == true;
                // moveMarker();
              },
              child: const Text("check")),
          // Text(widget.vehiclenum),
          FocusedMenuHolder(
            animateMenuItems: true,
            openWithTap: true,
            blurSize: 0,
            menuWidth: MediaQuery.of(context).size.width * 0.50,
            onPressed: () {},
            menuItems: [
              FocusedMenuItem(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.check,
                        size: 22,
                      ),
                      Text("   Very slow"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      speedofmovement = 4800;
                      moveMarker();
                    });
                  }),
              FocusedMenuItem(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.check,
                        size: 22,
                      ),
                      Text("   Slow"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      speedofmovement = 3000;
                      moveMarker();
                    });
                  }),
              FocusedMenuItem(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.check,
                        size: 22,
                      ),
                      Text("   Normal"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      speedofmovement = 600;
                      moveMarker();
                    });
                  }),
              FocusedMenuItem(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.check,
                        size: 22,
                      ),
                      Text("    Fast"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      speedofmovement = 200;
                      moveMarker();
                    });
                  }),
              FocusedMenuItem(
                  title: Row(
                    children: const [
                      Icon(
                        Icons.check,
                        size: 22,
                      ),
                      Text("    Very fast"),
                    ],
                  ),
                  onPressed: () {
                    setState(() {
                      speedofmovement = 100;
                      moveMarker();
                    });
                  }),
            ],
            child: const Icon(
              Icons.play_circle_outline,
            ),
          ),
          GestureDetector(
            onTap: showMenuOptions,
            child: Container(
              key: actionKey,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Icons.watch_later_outlined,
              ),
            ),
          ),

          FocusedMenuHolder(
            animateMenuItems: true,
            openWithTap: true,
            blurSize: 0,
            menuWidth: MediaQuery.of(context).size.width * 0.50,
            onPressed: () {},
            menuItems: [
              FocusedMenuItem(
                  title: const Text("30 ${'minutes'}"), onPressed: () {}),
              FocusedMenuItem(
                  title: const Text("2 ${'hour'}"), onPressed: () {}),
              FocusedMenuItem(
                  title: const Text("4 ${'hour'}"), onPressed: () {}),
              FocusedMenuItem(
                  title: const Text("8 ${'hour'}"), onPressed: () {}),
              FocusedMenuItem(
                  title: const Text("12 ${'hour'}"), onPressed: () {}),
              FocusedMenuItem(
                  title: const Text("24 ${'hour'}"), onPressed: () {}),
              FocusedMenuItem(title: const Text('custom'), onPressed: () {}),
            ],
            child: const Icon(
              Icons.share,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: mapviewstart == true
          ? const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(19.0759837, 72.8776559),
                zoom: 12,
              ),
            )
          : myIcon == null || _points.isEmpty
              ? Stack(
                  children: [
                    const GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(19.0759837, 72.8776559),
                        zoom: 12,
                      ),
                    ),
                    Center(
                        child: Container(
                            height: 60,
                            width: width(context) * 0.8,
                            color: const Color.fromARGB(0, 255, 255, 255),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (showmessage == true &&
                                      _points.isEmpty &&
                                      _isLoadingindicator == false)
                                  ? Container(
                                      height: 40,
                                      color: Colors.white,
                                      child: const Text(
                                        "NO MOVING DATA AVAILABLE IN SELECTED PERIOD ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    )
                                  : const Center(child: Circularprogress()),
                            )))
                  ],
                )
              : Column(
                  children: [
                    Container(
                      // height: 25,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text(
                                  "Start: ${startdate.day}-${startdate.month}-${startdate.year}  ${startdate.hour}:${startdate.minute}:${startdate.second} -"),
                            ),
                            // Text("-"),
                            Padding(
                              padding: const EdgeInsets.only(left: 22),
                              child: Text(
                                  "End  : ${enddate.day}-${enddate.month}-${enddate.year}  ${enddate.hour}:${enddate.minute}:${enddate.minute}"),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Run Time ",
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      todaykm,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                        lastkm == null ? "" : lastkm.toString(),
                                        style: const TextStyle(fontSize: 12))
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Stop Time ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(stoptym,
                                        style: const TextStyle(fontSize: 12)),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text("$lengthofstoppagepoint stops",
                                        style: const TextStyle(fontSize: 12))
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text("Idle Hr :$idlehr"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text("Idle Count :$idlecount")
                                  ],
                                )
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: const [
                                //     Text(
                                //       "Signal lost ",
                                //       style: TextStyle(
                                //           color: Colors.black,
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                //     Text("", style: TextStyle(fontSize: 12)),
                                //     SizedBox(
                                //       height: 8,
                                //     ),
                                //     Text("", style: TextStyle(fontSize: 12))
                                //   ],
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 9,
                      child: Stack(children: [
                        CustomGoogleMapMarkerBuilder(
                            customMarkers: _customMarkers,
                            builder:
                                (BuildContext context, Set<Marker>? markers) {
                              if (markers == null) {
                                return GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: _points.first,
                                    zoom: 14,
                                  ),
                                  polylines: {
                                    Polyline(
                                      polylineId: const PolylineId('polyline'),
                                      color: Colors.blue,
                                      points: _points,
                                      width: 3,
                                    )
                                  },
                                  markers: {
                                    _marker,
                                    Marker(
                                        markerId: const MarkerId("marker2"),
                                        infoWindow: InfoWindow(
                                            title:
                                                "End Time ${_data.last["trackDateTime"]}",
                                            snippet:
                                                " Distance: ${_data.last["distence"]}"),
                                        position: _points.last),
                                  },
                                  onMapCreated: _onMapCreated,
                                );
                              }
                              {
                                markers.add(
                                  _marker,
                                );

                                markers.add(
                                  Marker(
                                      markerId: const MarkerId("marker2"),
                                      infoWindow: InfoWindow(
                                          title:
                                              "End Time ${_data.last["trackDateTime"]}",
                                          snippet:
                                              " Distance: ${_data.last["distence"]}"),
                                      position: _points.last),
                                );

                                return GoogleMap(
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                    target: _points.first,
                                    zoom: 14,
                                  ),
                                  polylines: {
                                    Polyline(
                                      polylineId: const PolylineId('polyline'),
                                      color: Colors.blue,
                                      points: _points,
                                      width: 3,
                                    )
                                  },
                                  markers: markers,
                                  onMapCreated: _onMapCreated,
                                );
                              }
                            }),
                      ]),
                    ),
                    Expanded(
                        flex: 2,
                        child: Container(
                          height: 60,
                          color: const Color.fromARGB(0, 255, 255, 255),
                          child: Column(
                            children: [
                              // sliderPlayButtonState.setLength(_data.length),
                              Row(
                                children: [
                                  IconButton(
                                    icon: _isPlaying
                                        ? const Icon(Icons.pause)
                                        : const Icon(Icons.play_arrow),
                                    onPressed: () {
                                      setState(() {
                                        if (_isPlaying) {
                                          _stop();
                                          setState(() {});
                                          // _timer?.cancel();
                                          // speedofmovement = 100000000000000000;
                                          // moveMarker();
                                        } else {
                                          if (_polylineIndex >=
                                              _points.length) {
                                            _polylineIndex = 0;
                                          }
                                          // _onMapCreated(mapController);
                                          _start(0);
                                          moveMarker();
                                        }
                                        _isPlaying = !_isPlaying;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: width(context) * 0.8,
                                    child: Slider(
                                      value: _sliderValue,
                                      min: 0.0,
                                      max: _data.length.toDouble(),
                                      divisions: _data.length,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _sliderValue = newValue;
                                          _polylineIndex = newValue.toInt();
                                          progress(newValue.toInt());
                                        });
                                      },
                                      onChangeStart: (value) {
                                        setState(() {
                                          _sliderValue = value;
                                          _polylineIndex = value.toInt();
                                          progress(value.toInt());
                                        });
                                      },
                                      onChangeEnd: (newValue) {
                                        moveMarker();
                                      },
                                      // onChangeEnd: (value) {
                                      //   setState(() {
                                      //     _sliderValue = value;
                                      //     _polylineIndex = value.toInt();
                                      //     progress(value.toInt());
                                      //   });
                                      // },
                                      //onChangeStart: (newValue) {
                                      //   // Pause the animation by cancelling the timer.
                                      //   _timer?.cancel();
                                      // },
                                    ),

                                    //  Slider(
                                    //   value: _sliderValue,
                                    //   min: 0.0,
                                    //   max: _data.length.toDouble(),
                                    //   divisions: _data.length,
                                    //   onChanged: (newValue) {
                                    //     setState(() {
                                    //       _sliderValue = newValue;
                                    //       _polylineIndex = newValue.toInt();
                                    //       progress(newValue.toInt());
                                    //       moveMarker(speedofvehicle);
                                    //     });
                                    //   },
                                    // ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(date,
                                        style: const TextStyle(fontSize: 12)),
                                    Text(
                                      "Dis : $dis",
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                    Text(
                                      speed,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
    );
  }

  void setInitialMarkerLocation() {
    if (_points.isNotEmpty) {
      _markerLocation = _points.first;
      _marker = Marker(
        markerId: const MarkerId('marker'),
        position: _markerLocation!,
        rotation: 2.0,
        icon: myIcon!,
      );
      // stoppoints(_points.first);
    }
    setState(() {});
  }

  void moveMarker() {
    int speedofmovement2 = speedofmovement;

    _timer = Timer.periodic(Duration(milliseconds: speedofmovement2), (timer) {
      setState(() {
        if (_polylineIndex < _points.length) {
          _polylineIndex++;
          progress(_polylineIndex);
          // sliderPlayButtonState.progress(_polylineIndex);
        } else {
          // _polylineIndex = 0;
        }
        _markerLocation = _points[_polylineIndex];

        Marker m = _marker.clone();

        _marker = Marker(
            markerId: m.markerId,
            onTap: () {},
            position:
                LatLng(_markerLocation!.latitude, _markerLocation!.longitude),
            icon: m.icon,
            infoWindow: m.infoWindow,
            rotation: Bearing.getBearing(m.position,
                _markerLocation!) //InfoWindow(title: 'my new Title'),
            );
        var _cameraPosition = CameraPosition(
          target: _markerLocation!,
          zoom: 14.5,
        );
        mapController
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
        {
          Polyline(
            polylineId: const PolylineId('polyline'),
            color: Colors.blue,
            points: _points,
            width: 2,
          );
        }
        ;
      });
    });
  }

  updateMarker(id) {}

  _customMarker2(String symbol, Color color) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: color, width: 2),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: color, blurRadius: 6)]),
      child: Center(child: Text(symbol)),
    );
  }

  buildLanguageDialog2(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            // title: const Text(''),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Please select maximum only 15 days history"),
                      const Text("startdatetime"),
                      const SizedBox(
                        height: 6,
                      ),
                      MaterialButton(
                        minWidth: width(context) * 0.5,
                        height: 55,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        onPressed: () async {
                          pickDateTime((selectedDate) {
                            setState(() {
                              startdate = selectedDate;
                            });
                          });
                        },
                        child: Text(
                          "${startdate.day}-${startdate.month}-${startdate.year}   ${startdate.hour}:${startdate.minute}:${startdate.second}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 22, 21, 21),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("enddatetime"),
                      const SizedBox(
                        height: 6,
                      ),
                      MaterialButton(
                        minWidth: width(context) * 0.5,
                        height: 55,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        onPressed: () async {
                          pickDateTime2((selectedDate) {
                            setState(() {
                              enddate = selectedDate;
                            });
                          });
                        },
                        child: Text(
                          "${enddate.day}-${enddate.month}-${enddate.year}   ${enddate.hour}:${enddate.minute}:${enddate.minute}",
                          style: const TextStyle(
                            color: Color.fromARGB(255, 22, 21, 21),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        color: Colors.green,
                        onPressed: () {
                          Navigator.pop(context);

                          setState(() {
                            mapviewstart = false;
                            _points.clear();
                            selectedtoday = false;
                            selectedyesterday = false;
                            selecteddaybeforeyesterday = false;
                            selecteddayrandom = true;

                            final userdefinedstartdate =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(startdate);
                            final userdefinedenddate =
                                DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(enddate);
                            starteddateselected = userdefinedstartdate;
                            enddateselected = userdefinedenddate;
                            stoppagepoints(widget.vid);

                            _fetchDataHistory(widget.vid)
                                .then((_) => _drawPolyline());
                            setInitialMarkerLocation();
                            intervel = '3';
                            stoptimeapicall();
                          });
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ));
            }),
          );
        });
  }
}

class Bearing {
  static double getBearing(LatLng startPosition, LatLng endPosition) {
    double latitudeDiff = (startPosition.latitude - endPosition.latitude).abs();
    double longitudeDiff =
        (startPosition.longitude - endPosition.longitude).abs();

    if (startPosition.latitude < endPosition.latitude &&
        startPosition.longitude < endPosition.longitude)
      return (atan(longitudeDiff / latitudeDiff) * 180 / pi);
    else if (startPosition.latitude >= endPosition.latitude &&
        startPosition.longitude < endPosition.longitude)
      return (90 - atan(longitudeDiff / latitudeDiff) * 180 / pi) + 90;
    else if (startPosition.latitude >= endPosition.latitude &&
        startPosition.longitude >= endPosition.longitude)
      return atan(longitudeDiff / latitudeDiff) * 180 / pi + 180;
    else if (startPosition.latitude < endPosition.latitude &&
        startPosition.longitude >= endPosition.longitude)
      return (90 - atan(longitudeDiff / latitudeDiff) * 180 / pi) + 270;

    return -1;
  }
}

class Circularprogress extends StatelessWidget {
  const Circularprogress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.95,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CircularProgressIndicator(),
            Text(
              "LOADING.. PLEASE WAIT",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}


//slider field

// class SliderPlayButton extends StatefulWidget {
//   SliderPlayButton({super.key, required this.length});
//   int length;

//   @override
//   SliderPlayButtonState createState() => SliderPlayButtonState();
// }

// class SliderPlayButtonState extends State<SliderPlayButton> {
//   double _sliderValue = 0.0;
//   bool _isPlaying = false;

//   Timer? _timer;
//   bool run = false;

//   // double maxLength = 0.0;

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   setLength(int length1) {
//     widget.length = length1;
//   }

//   progress(int pos) {
//     setState(() {
//       _sliderValue = pos.toDouble();
//       if (_sliderValue >= widget.length.toDouble()) {
//         _stop();
//       }
//     });
//   }

//   void _start(int pos) {
//     setState(() {
//       _sliderValue = pos.toDouble();
//     });
//     // _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
//     //   setState(() {
//     //     _sliderValue += 1;
//     //     if (_sliderValue > 100) {
//     //       _stop();
//     //     }
//     //   });
//     // });
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
//                 _start(0);
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
//             max: widget.length.toDouble(),
//             divisions: 1,
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

