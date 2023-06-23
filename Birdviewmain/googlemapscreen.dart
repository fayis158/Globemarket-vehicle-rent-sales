import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/Screens/Login_page/Login_with_username.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../Screens/Drawer_inside_pages/Analytics/analytics.dart';
import '../Screens/Drawer_inside_pages/Report/reports.dart';
import '../Rent_App/rent/rent.dart';
import '../map/justtestingpurpose.dart';
import '../playroute/playRoute.dart';

class GoogleMapScreenBirdView extends StatefulWidget {
  const GoogleMapScreenBirdView({super.key});

  @override
  State<GoogleMapScreenBirdView> createState() =>
      _GoogleMapScreenBirdViewState();
}

class _GoogleMapScreenBirdViewState extends State<GoogleMapScreenBirdView> {
  bool isloaded = false;

  Uint8List? finalicon;
  Future<Uint8List> getBytesFromUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return Uint8List.fromList(bytes);
  }

  Future<Uint8List> getBytesFromAsset(
      {required String path, required int width}) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    List<String> markerIdsToTap = ["marker_id_1", "marker_id_2"];

    for (String markerId in markerIdsToTap) {
      controller.showMarkerInfoWindow(MarkerId(markerId));
    }
  }

  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = Set();
  Set<Marker> finalmarkers = Set();
  GoogleMapController? controller1;
  bool serverdataloaded = true;
  bool _isError = false;
  String markerid = "";

  Future<BitmapDescriptor> getCustomIcon(
      String imagePath, Color color, Size size) async {
    final imageBytes = await rootBundle.load(imagePath);
    final codec =
        await ui.instantiateImageCodec(imageBytes.buffer.asUint8List());
    final frame = await codec.getNextFrame();
    final image = frame.image;
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint()
      ..colorFilter = ColorFilter.mode(color, BlendMode.srcIn);
    final srcRect =
        Rect.fromLTRB(0, 0, image.width.toDouble(), image.height.toDouble());
    final dstRect = Rect.fromLTRB(0, 0, size.width, size.height);
    canvas.drawImageRect(image, srcRect, dstRect, paint);
    final picture = pictureRecorder.endRecording();
    final pngBytes = await picture
        .toImage(size.width.toInt(), size.height.toInt())
        .then((image) => image.toByteData(format: ui.ImageByteFormat.png));
    return BitmapDescriptor.fromBytes(pngBytes!.buffer.asUint8List());
  }

  apiforbirdview() async {
    try {
      var result = await http.get(
          Uri.parse("http://globalgps.in:8089/api/v6/Live/Details/$finalUid"));
      if (result.statusCode == 200) {
        Map decodedData = jsonDecode(result.body);
        List decodedDataagain = decodedData["all_vehicles"];

        for (var i = 0; i < decodedDataagain.length; i++) {
          markerid = decodedDataagain[i]["vehicleNo"];
          int vehicleid = decodedDataagain[i]["vehicleId"];
          String statusvehicle = decodedDataagain[i]["status"];

          BitmapDescriptor myCustomIcon = await getCustomIcon(
              'images/Bull.png', Colors.red, const Size(120, 120));
          Color colorss = statusvehicle == "Stopped"
              ? Colors.red
              : statusvehicle == "Idle"
                  ? const ui.Color.fromARGB(255, 215, 196, 22)
                  : statusvehicle == "Live"
                      ? const ui.Color.fromARGB(255, 20, 84, 22)
                      : Colors.black;
          vehicleid == 1
              ? myCustomIcon = await getCustomIcon(
                  'images/carnew.webp', colorss, const Size(140, 120))
              : vehicleid == 2
                  ? myCustomIcon = await getCustomIcon(
                      'images/truckc.png', colorss, const Size(140, 120))
                  : vehicleid == 3
                      ? myCustomIcon = await getCustomIcon(
                          'images/bus.png', colorss, const Size(140, 120))
                      : vehicleid == 4
                          ? myCustomIcon = await getCustomIcon(
                              'images/bike.png', colorss, const Size(140, 120))
                          : vehicleid == 5
                              ? myCustomIcon = await getCustomIcon(
                                  'images/amb.png',
                                  colorss,
                                  const Size(140, 120))
                              : vehicleid == 6
                                  ? myCustomIcon = await getCustomIcon(
                                      'images/jeep.png',
                                      colorss,
                                      const Size(140, 120))
                                  : vehicleid == 7
                                      ? myCustomIcon = await getCustomIcon(
                                          'images/van.png',
                                          colorss,
                                          const Size(140, 120))
                                      : vehicleid == 8
                                          ? myCustomIcon = await getCustomIcon(
                                              'images/Bull.png',
                                              colorss,
                                              const Size(140, 120))
                                          : vehicleid == 10
                                              ? myCustomIcon =
                                                  await getCustomIcon('images/traa.png', colorss, const Size(130, 120))
                                              : vehicleid == 11
                                                  ? myCustomIcon = await getCustomIcon('images/rolller.png', colorss, const Size(130, 120))
                                                  : vehicleid == 12
                                                      ? myCustomIcon = await getCustomIcon('images/tipper.png', colorss, const Size(130, 120))
                                                      : vehicleid == 13
                                                          ? myCustomIcon = await getCustomIcon('images/hitachi1.png', colorss, const Size(130, 120))
                                                          : vehicleid == 14
                                                              ? myCustomIcon = await getCustomIcon('images/tanker.png', colorss, const Size(130, 120))
                                                              : vehicleid == 15
                                                                  ? myCustomIcon = await getCustomIcon('images/grader.png', colorss, const Size(130, 120))
                                                                  : vehicleid == 16
                                                                      ? myCustomIcon = await getCustomIcon('images/jc.png', colorss, const Size(130, 120))
                                                                      : vehicleid == 17
                                                                          ? myCustomIcon = await getCustomIcon('images/crane.png', colorss, const Size(130, 120))
                                                                          : await getCustomIcon('images/Bull.png', colorss, const Size(130, 120));

          markers.add(
            Marker(
                onTap: () {
                  controller1!.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(decodedDataagain[i]["latitude"],
                        decodedDataagain[i]["longitude"]),
                    16.0,
                  ));
                },
                markerId: MarkerId(decodedDataagain[i]["vehicleNo"]),
                infoWindow: InfoWindow(
                  // onTap: () => true,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayTheRoute(
                              vid: decodedDataagain[i]["vid"],
                              vehiclenum: decodedDataagain[i]["vehicleNo"]),
                        ));
                  },
                  title:
                      "${decodedDataagain[i]["vehicleNo"]} ${Homepagedatasmap[i]["date"]} ",
                  snippet: " Speed:${Homepagedatasmap[i]["speed"]} ",
                ),
                position: LatLng(decodedDataagain[i]["latitude"],
                    decodedDataagain[i]["longitude"]),
                // icon: BitmapDescriptor.fromBytes((await getBytesFromAsset(
                //     path: vehicleid == 6 ? "images/jeep.png" : "images/van.png",
                icon: myCustomIcon
                //     width: 100,)))
                // icon: myCustomIcon

                // icon: BitmapDescriptor.fromBytes(
                //   size: const Size(1232, 2222),
                //   (await NetworkAssetBundle(Uri.parse("$mainurl"))
                //           .load(Uri.parse(mainurl).path))
                //       .buffer
                //       .asUint8List(),
                // ),
                ),
          );
          controller1?.showMarkerInfoWindow(decodedDataagain[i]["vehicleNo"]);
        }
        finalmarkers = markers;
        isloaded = true;

        setState(() {});
      }
    } catch (e) {
      // Handle errors and change error state

      setState(() {
        isloaded = true;
        _isError = true;
      });
    }
  }

  bool traffic = false;

// 2nd try

  @override
  void initState() {
    super.initState();
    apiforbirdview();
  }

  void _showPopupMenu(BuildContext context) async {
    await showMenu(
      context: context,
      position:
          RelativeRect.fromLTRB(width(context), height(context) * 0.4, 0, 0),
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
    ).then((value) {
// NOTE: even you didnt select item this method will be called with null of value so you should call your call back with checking if value is not null

      // if (value != null);
    });
  }

  var selected;
  List selectedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              TabBarDemo().navigateTo(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: const Text(
          "Bird View",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
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
                      //  trailingIcon: Icon(Icons.check),

                      title: Text(Homepagedatasmap[index]["vehicleNo"]),
                      // trailingIcon: Icon(IconData()),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return MyDialog(
                              vid: Homepagedatasmap[index]["vid"],
                            );
                          },
                        );
                      },
                    ),
                  );
                  return FocusedMenuHolder(
                      menuWidth: MediaQuery.of(context).size.width * 0.50,
                      // blurSize: 5.0,
                      // menuItemExtent: 45,
                      menuBoxDecoration: const BoxDecoration(
                        color: Color.fromARGB(0, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
                                Icons.share,
                                color: Colors.black,
                                size: 27,
                              ))));
                },
              ),
            ),
          ),
          //   IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     showSearch(
          //       context: context,
          //       delegate: DropdownSearch(items: items),
          //     );
          //   },
          // ),
        ],
      ),
      body: isloaded == false
          ? const Center(child: CircularProgressIndicator())
          : _isError
              ? Center(
                  child: Text(
                    "Oops, Something Went Wrong.Please try\n again later",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: height(context) * 0.02),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(children: [
                        GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            controller1 = controller;
                            controller
                                .showMarkerInfoWindow(MarkerId('$markerid'));
                            _onMapCreated(controller);
                          },
                          markers: markers,
                          trafficEnabled: traffic,
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(
                                20.5937,
                                78.9629,
                              ),
                              zoom: 5.1),
                          mapType: Normal == true
                              ? MapType.normal
                              : satellite == true
                                  ? MapType.satellite
                                  : Terrain == false
                                      ? MapType.terrain
                                      : MapType.normal,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: CustomSearchableDropDown(
                            menuPadding: const EdgeInsets.all(0),
                            menuHeight: 90,
                            backgroundColor: Colors.white,
                            dropdownHintText: 'Search For vehicle Num... ',
                            // showLabelInMenu: true,
                            // initialIndex: 0,
                            initialValue: const [
                              {
                                'parameter': 'vehicleNo',
                                'value': 'Search',
                              }
                            ],
                            dropdownItemStyle:
                                const TextStyle(color: Colors.black),
                            primaryColor:
                                const ui.Color.fromARGB(255, 13, 12, 12),
                            menuMode: true,
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            items: Homepagedatasmap,
                            label: '',
                            prefixIcon: const Icon(Icons.search),
                            dropDownMenuItems: Homepagedatasmap.map((item) {
                              return item['vehicleNo'];
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  selected = value['vehicleNo'];
                                  selectedList = Homepagedatasmap.where(
                                          (item) =>
                                              item['vehicleNo'] == selected)
                                      .toList();
                                });
                                if (selectedList.isNotEmpty) {
                                  controller1!
                                      .animateCamera(CameraUpdate.newLatLngZoom(
                                    LatLng(selectedList[0]['latitude'],
                                        selectedList[0]['longitude']),
                                    16.0,
                                  ));
                                }
                                controller1?.showMarkerInfoWindow(
                                    MarkerId('$selected'));
                              } else {
                                selected = null;
                              }
                            },
                          ),
                        ),
                        Positioned(
                          left: width(context) * 0.84,
                          top: height(context) * 0.4,
                          child: Column(
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
                            ],
                          ),
                        ),
                        Positioned(
                          top: height(context) * 0.29,
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              width: 50,
                              child: ListView.builder(
                                itemCount: Homepagedatasmap.length,
                                itemBuilder: (context, index) {
                                  // String title = widget.items[index];
                                  List<FocusedMenuItem> menuItems =
                                      List.generate(
                                    Homepagedatasmap.length,
                                    (index) => FocusedMenuItem(
                                      //  trailingIcon: Icon(Icons.check),

                                      title: Text(
                                          Homepagedatasmap[index]["vehicleNo"]),
                                      // trailingIcon: Icon(IconData()),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => Mytest2(
                                            vehicleid: Homepagedatasmap[index]
                                                ["vehicleId"],
                                            km: Homepagedatasmap[index]
                                                ["speed"],
                                            location: Homepagedatasmap[index]
                                                ["finallocation"],
                                            latitude: Homepagedatasmap[index]
                                                ["latitude"],
                                            longitude: Homepagedatasmap[index]
                                                ["longitude"],
                                            vid: Homepagedatasmap[index]["vid"],
                                            ignition: Homepagedatasmap[index]
                                                ["ignition"],
                                            vehiclecondition: Homepagedatasmap[
                                                                index]
                                                            ["ignition"] ==
                                                        "Off" &&
                                                    Homepagedatasmap[index]
                                                            ["speed"] ==
                                                        0
                                                ? "Stopped"
                                                : Homepagedatasmap[index]
                                                                ["ignition"] ==
                                                            "On" &&
                                                        Homepagedatasmap[index]
                                                                ["speed"] ==
                                                            0
                                                    ? "idle"
                                                    : "Live",
                                            vehiclenum: Homepagedatasmap[index]
                                                ["vehicleNo"],
                                            speed: Homepagedatasmap[index]
                                                ["speed"],
                                          ),
                                        ));
                                      },
                                    ),
                                  );
                                  return FocusedMenuHolder(
                                      menuWidth:
                                          MediaQuery.of(context).size.width *
                                              0.50,
                                      // blurSize: 5.0,
                                      // menuItemExtent: 45,
                                      menuBoxDecoration: const BoxDecoration(
                                        color: Color.fromARGB(0, 255, 255, 255),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                      ),
                                      duration:
                                          const Duration(milliseconds: 100),
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
                                              color: Color.fromARGB(
                                                  0, 255, 255, 255),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0))),
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
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        // height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                var data = await sp.clear();
                                Homepagedatasmap.clear();
                                filteredData.clear();
                                finalUid = 0;

                                if (data == true) {
                                  const Login_with_username()
                                      .navigateTo(context);
                                }
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.login,
                                  ),
                                  Text(
                                    'Logout'.tr(),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                const analytics().navigateTo(context);
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.analytics_outlined,
                                  ),
                                  Text(
                                    'Analytics'.tr(),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // const rent2().navigatpoeTo(context);
                              },
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.fire_truck,
                                  ),
                                  Text('Rent'),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Reports(),
                                ));
                              },
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.bar_chart_outlined,
                                  ),
                                  Text(
                                    'Reports'.tr(),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ) // widgetlist[current],
                  ],
                ),
    );
  }
}

class MyDialog extends StatefulWidget {
  String vid;
  MyDialog({Key? key, required this.vid})
      : super(
          key: key,
        );

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  var now = DateTime.now();

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Share'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text("30 ${'minutes'.tr()}"),
            onTap: () async {
              var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
              var startdatemain = formatter.format(now);
              var earlier = now.add(const Duration(minutes: 30));
              var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
              var enddate30 = formatterend.format(earlier);

              await Api.sharebutton(widget.vid, startdatemain, enddate30);

              _shareLink(sharebuttonmap["linkShareText"]);
              Navigator.pop(context);
            },
          ),
          ListTile(
              title: Text("2 ${'hour'.tr()}"),
              onTap: () async {
                var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                var startdatemain = formatter.format(now);

                var earlier = now.add(const Duration(hours: 2));
                var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                var enddate2 = formatterend.format(earlier);

                await Api.sharebutton(widget.vid, startdatemain, enddate2);

                _shareLink(sharebuttonmap["linkShareText"]);
              }),
          ListTile(
              title: Text("4 ${'hour'.tr()}"),
              onTap: () async {
                var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                var startdatemain = formatter.format(now);

                var earlier = now.add(const Duration(hours: 4));
                var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                var enddate2 = formatterend.format(earlier);

                await Api.sharebutton(widget.vid, startdatemain, enddate2);

                _shareLink(sharebuttonmap["linkShareText"]);
              }),
          ListTile(
              title: Text("8 ${'hour'.tr()}"),
              onTap: () async {
                var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                var startdatemain = formatter.format(now);

                var earlier = now.add(const Duration(hours: 8));
                var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                var enddate2 = formatterend.format(earlier);

                await Api.sharebutton(widget.vid, startdatemain, enddate2);

                _shareLink(sharebuttonmap["linkShareText"]);
              }),
          ListTile(
              title: Text("12 ${'hour'.tr()}"),
              onTap: () async {
                var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                var startdatemain = formatter.format(now);

                var earlier = now.add(const Duration(hours: 12));
                var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                var enddate2 = formatterend.format(earlier);

                await Api.sharebutton(widget.vid, startdatemain, enddate2);

                _shareLink(sharebuttonmap["linkShareText"]);
              }),
          ListTile(
              title: Text("24 ${'hour'.tr()}"),
              onTap: () async {
                var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
                var startdatemain = formatter.format(now);

                var earlier = now.add(const Duration(days: 1));
                var formatterend = DateFormat('yyyy-MM-dd HH:mm:ss');
                var enddate2 = formatterend.format(earlier);

                await Api.sharebutton(widget.vid, startdatemain, enddate2);

                _shareLink(sharebuttonmap["linkShareText"]);
              }),
          ListTile(
              title: Text("${'custom'.tr()}"),
              onTap: () async {
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
                await Api.sharebutton(widget.vid, startdatemain, _selectedDate);

                _shareLink(sharebuttonmap["linkShareText"]);
              })
        ],
      ),
    );
  }

  _shareLink(var link) {
    Share.share(link,
        subject: 'Check out this link',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
  }
}
