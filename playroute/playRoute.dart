//play route

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import '../../Constant.dart';
import 'dart:ui' as ui;
import 'bearing.dart';

DateTime startdate = DateTime.now();
DateTime enddate = DateTime.now();
DateTime _selectedDateTime = DateTime.now();
var now = DateTime.now();
DateTime? _selectedDate;

String starteddateselected =
    DateFormat('yyyy-MM-dd 12:00:00').format(startdate);
String enddateselected = DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);

class PlayTheRoute extends StatefulWidget {
  String vid;
  String vehiclenum;
  PlayTheRoute({super.key, required this.vid, required this.vehiclenum});

  @override
  PlayTheRouteState createState() => PlayTheRouteState();
}

class PlayTheRouteState extends State<PlayTheRoute> {
  int vehiclespeed = 2;

  final Completer<GoogleMapController> _controller = Completer();

  late Marker _marker;
  late Marker _marker2;
  LatLng? _markerLocation;
  int _polylineIndex = 0;
  BitmapDescriptor? myIcon;
  List<dynamic> _data = [];
  List<LatLng> _points = [];
  late GoogleMapController mapController;
  GlobalKey actionKey = GlobalKey();
  bool selectedtoday = true;
  bool selectedyesterday = false;
  bool selecteddaybeforeyesterday = false;
  bool selecteddayrandom = false;
  bool _isLoading = false;
  bool showmessage = false;
  bool _isLoadingindicator = true;

  bool _isPlaying = false;

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
        lastkm = _data.last["distence"];
      });
      if (extractedData["historyData"] != null) {
        setState(() {});
      }

      List lengthsspoint = (extractedData["stoppagePoints"]);
      lengthofstoppagepoint = lengthsspoint.length;
    } else {}
  }

  String stoptym = '';
  String todaykm = '';
  int lengthofstoppagepoint = 0;
  String lastkm = '';
  String intervel = '0';
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

  Future pickDateTime() async {
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
    setState(() {
      startdate = newdateTime;
    });
  }

  Future pickDateTime2() async {
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
    setState(() {
      enddate = newdateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: startdate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: startdate.hour, minute: startdate.minute));

  // Future<Uint8List> getBytesFromAsset(String path, int width) async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
  //       targetWidth: width);
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
  //       .buffer
  //       .asUint8List();
  // }

  // Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
  //     String path, int width) async {
  //   final Uint8List imageData = await getBytesFromAsset(path, width);
  //   return BitmapDescriptor.fromBytes(imageData);
  // }

  // loadicon() async {
  //   final icon = await getBitmapDescriptorFromAssetBytes("images/car2.png", 35);
  // }
  List<Marker> markersListui = [];
  Set<Marker> markersui = {};
  initMarkers() async {
    // markers = {};

    for (var i = 0; i < 2; i++) {
      int j = i + 1;
      markersui.add(Marker(
        markerId: MarkerId("$j"),
        position: LatLng(0.00, 0.00),
        icon: await CountWidget(count: j).toBitmapDescriptor(),
      ));
      markersListui = markersui.toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    initMarkers();

    super.initState();
    setInitialMarkerLocation();
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(0, 0), devicePixelRatio: 0.1),
            'images/car2.png',
            mipmaps: true)
        .then((onValue) {
      myIcon = onValue;
    });
    // loadicon();
    String formattedTime = DateFormat('hh:mm:ss').format(startdate);

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
    String formattedYesterdayStart =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(startdate);
    String formattedYesterdayend =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
    starteddateselected = formattedYesterdayStart;
    enddateselected = formattedYesterdayend;

    _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
    setInitialMarkerLocation();
    intervel = "0";
    loa();
    stoptimeapicall();
  }

  loa() {
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoadingindicator = false;
      });
    });
    convertingto12h();
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
            intervel = "1";
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

              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              stoptimeapicall();

              convertingto12h();
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
            intervel = "2";
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

              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              stoptimeapicall();
              convertingto12h();
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
            intervel = "3";
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
              _fetchDataHistory(widget.vid).then((_) => _drawPolyline());
              setInitialMarkerLocation();
              loa();
              stoptimeapicall();
              convertingto12h();
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

  //end of init state

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

  buildLanguageDialog2(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            // title: const Text(''),
            content: SizedBox(
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
                      onPressed: () {
                        setState(() {
                          pickDateTime();
                        });
                      },
                      child: Text(
                        "$startdate",
                        // "${datetime.year}/ ${datetime.month}/${datetime.day}   ${datetime.hour}: ${datetime.minute}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 22, 21, 21)),
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
                      onPressed: () {
                        setState(() {
                          pickDateTime2();
                        });
                      },
                      child: Text(
                        "$enddate",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 22, 21, 21)),
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
                          stoptimeapicall();
                          _points.clear();
                          selectedtoday = false;
                          selectedyesterday = false;
                          selecteddaybeforeyesterday = false;
                          selecteddayrandom = true;

                          final userdefinedstartdate =
                              DateFormat('yyyy-MM-dd HH:mm:ss')
                                  .format(startdate);
                          final userdefinedenddate =
                              DateFormat('yyyy-MM-dd HH:mm:ss').format(enddate);
                          starteddateselected = userdefinedstartdate;
                          enddateselected = userdefinedenddate;

                          _fetchDataHistory(widget.vid)
                              .then((_) => _drawPolyline());
                          setInitialMarkerLocation();
                        });
                        convertingto12h();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )),
          );
        });
  }

  Marker? _myMarker;
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
    _myMarker = Marker(
        markerId: const MarkerId("marker2"),
        position: _points.last,
        infoWindow: InfoWindow(
            title: "End Time ${_data.last["trackDateTime"]}",
            snippet: " Distance: ${_data.last["distence"]}"));
  }

  _shareLink(var link) {
    Share.share(link,
        subject: 'Check out this link',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
  }

  String? startdate12;
  String? endate12;

  convertingto12h() {
    startdate12 = DateFormat('yyyy-MM-dd hh:mm:ss a').format(startdate);
    endate12 = DateFormat('yyyy-MM-dd hh:mm:ss a').format(enddate);
  }

  @override
  Widget build(BuildContext context) {
    // convertingto12h();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // TextButton(onPressed: () {}, child: const Text("check")),
            Text(widget.vehiclenum),
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
                        Text("   Slow"),
                      ],
                    ),
                    onPressed: () {
                      setState(() {
                        speedofmovement = 900;
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
                        speedofmovement = 400;
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
                    title: Text('custom'.tr()),
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
                width: 30,
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: myIcon == null || _points.isEmpty
          ? Stack(
              children: [
                const GoogleMap(
                  myLocationEnabled: true,
                  zoomControlsEnabled: true,
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                    right: 30,
                    top: 10,
                  ),
                  child: Container(
                    // height: 25,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 0,
                        right: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text("Start : $startdate12")
                              // "Start:${startdate.day}-${startdate.month}-${startdate.year}  ${startdate.hour}:${startdate.minute}:${startdate.second} -"),
                              ),
                          // Text("-"),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Text("End   : $endate12")
                              // "End  :${enddate.day}-${enddate.month}-${enddate.year}  ${enddate.hour}:${enddate.minute}:${enddate.minute}"),
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
                                  Text(lastkm,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Idle: $idlehr"),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("Idle Count: $idlecount"),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 9,
                  child: Stack(children: [
                    GoogleMap(
                      zoomControlsEnabled: true,
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _points.first,
                        zoom: 12,
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
                        // markersListui,
                        _marker,
                        _myMarker ??
                            Marker(
                                markerId: const MarkerId("marker2"),
                                position: _points.last,
                                infoWindow: InfoWindow(
                                    title:
                                        "End Time ${_data.last["trackDateTime"]}",
                                    snippet:
                                        " Distance: ${_data.last["distence"]}")),
                      },
                      onMapCreated: _onMapCreated,
                    ),
                  ]),
                ),
                Expanded(
                    flex: 2,
                    child: Container(
                      height: 60,
                      color: const Color.fromRGBO(195, 191, 191, 0.286),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _isPlaying
                                  ? IconButton(
                                      icon: _isPlaying
                                          ? const Icon(Icons.pause)
                                          : const Icon(Icons.play_arrow),
                                      onPressed: () {
                                        setState(() {
                                          if (_isPlaying) {
                                            _stop();
                                            setState(() {});
                                          } else {
                                            if (_polylineIndex >=
                                                _points.length) {
                                              _polylineIndex = 0;
                                            }
                                            _start(0);
                                            moveMarker();
                                          }
                                          _isPlaying = !_isPlaying;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: _isPlaying
                                          ? const Icon(Icons.pause)
                                          : const Icon(Icons.play_arrow),
                                      onPressed: () {
                                        setState(() {
                                          if (_isPlaying) {
                                            _stop();
                                            setState(() {});
                                          } else {
                                            if (_polylineIndex >=
                                                _points.length) {
                                              _polylineIndex = 0;
                                            }
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(date,
                                    style: const TextStyle(fontSize: 12)),
                                Text(
                                  "Dis : $dis",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 12),
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

  Timer? _timer;

  void setInitialMarkerLocation() {
    if (_points.isNotEmpty) {
      _markerLocation = _points.first;
      _marker = Marker(
        markerId: const MarkerId('marker'),
        position: _markerLocation!,
        rotation: 2.0,
        icon: myIcon!,
      );
    }
    setState(() {});
  }

  int speedofmovement = 400;
  double _sliderValue = 0.0;
  String dis = '';
  String speed = '';
  String date = '';

  void _stop() {
    _timer?.cancel();
    _timer = null;
    setState(() {});
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
            rotation: Bearing.getBearing(m.position, _markerLocation!));
        var _cameraPosition = CameraPosition(
          target: _markerLocation!,
          zoom: 15.0,
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
}

//slider field

class SliderPlayButton extends StatefulWidget {
  const SliderPlayButton({super.key});

  @override
  SliderPlayButtonState createState() => SliderPlayButtonState();
}

class SliderPlayButtonState extends State<SliderPlayButton> {
  double _sliderValue = 0.0;
  bool _isPlaying = false;

  Timer? _timer;
  bool run = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _start() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _sliderValue += 1;
        if (_sliderValue >= 100) {
          _stop();
        }
      });
    });
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: _isPlaying
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
          onPressed: () {
            setState(() {
              if (_isPlaying) {
                _stop();
              } else {
                _start();
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
            max: 101.0,
            divisions: 100,
            onChanged: (newValue) {
              setState(() {
                _sliderValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
