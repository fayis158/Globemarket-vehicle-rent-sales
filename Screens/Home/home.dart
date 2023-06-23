import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Analytics/analytics.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Report/reports.dart';
import 'package:gpsglobe/Screens/Gps_payment/Gps_payment1.dart';
import 'package:gpsglobe/Screens/Home/condition_vehicle_state/All.dart';
import 'package:gpsglobe/Screens/Home/condition_vehicle_state/running.dart';
import 'package:gpsglobe/Screens/Home/condition_vehicle_state/stopped.dart';
import 'package:gpsglobe/Screens/Home/container_row_content/Relay.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/map/justtestingpurpose.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:humanitarian_icons/humanitarian_icons.dart';
import 'package:share_plus/share_plus.dart';
import '../../Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';
import '../../playroute/playRoute.dart';
import '../Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../Login_page/Login_with_username.dart';
import '../../Rent_App/Truck_servises/Rent_Home_Page.dart';
import '../../Rent_App/rent/rent.dart';
import 'Driver_Details.dart';
import 'RTO_letter_form.dart';
import 'Vehicle_Removed.dart';
import 'package:shared_preferences/shared_preferences.dart';

List myList1 = [];
List todaykmlist = [];
List document = [];
// var glosto;
List pro = [];
List hiolist = [];
var hio = [];
List expireveh = [];
bool pop = true;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> widgetlist = [
    const current1(),
    current2(),
    const current3(),
  ];

  int current = 0;

  @override
  void initState() {
    super.initState();
    homedatacoming();
    getdocumentdetails();
    // stoppager();
    expiryvehicle();
    popupwarning2();
    alertmessagepage();

    pop == true
        ? WidgetsBinding.instance.addPostFrameCallback((_) {
            expiredvehicledata.isNotEmpty
                ? showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: SizedBox(
                          // width: 30.0,
                          height: 96.0,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text("Renewal  "),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                          size: 20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "Vehicles:${expiredvehicledata.length}",
                                  style: const TextStyle(fontSize: 15.0),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: MaterialButton(
                                    color: Colors.green,
                                    child: const Text(
                                      "Pay",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Gps_payments_pending(),
                                          ));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : null;
          })
        : null;

    pop = false;
  }

  //popup message

  popupwarning2() async {
    await Api.popuppaymentwarning();
    await Api.Expiredveh();

    setState(() {});
  }

  homedatacoming() async {
    Homepagedatasmap = await Api.homepagedata();
    filteredData = await Api.homepagedata();
    setState(() {
      loaded = true;
    });
  }

  void showPopupMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            // title: Text("Reminder"),
            contentPadding: EdgeInsets.zero, // remove default padding
            content: SizedBox(
              height: 70,
              width: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text("Remainder"),
                  Text(
                    "expired vehicle count : ${expiredvehicledata.length}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  expiryvehicle() async {
    expireveh = await Api.Expiredveh();
    setState(() {});
  }

  getdocumentdetails() async {
    document = await Api.Documents();
  }

  //alertmessage page

  alertmessagepage() async {
    await Api.Alertmessagepage();
  }

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      "${'All'.tr()} ($allVehicle)",
      "${'Running'.tr()} ($runningVehicle)",
      "${'Stopped'.tr()} ($stoppedvehicle)",
    ];
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        current = index;
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.only(
                        top: 5, bottom: 5, right: 10, left: 10),
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 40,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.4),
                            offset: const Offset(-6.0, -6.0),
                            blurRadius: 16.0,
                          ),
                          BoxShadow(
                            color: const Color.fromARGB(255, 52, 255, 238)
                                .withOpacity(0.4),
                            offset: const Offset(6.0, 6.0),
                            blurRadius: 10.0,
                          ),
                        ],
                        shape: BoxShape.rectangle,
                        color: current == index
                            ? const Color.fromARGB(179, 142, 247, 160)
                            : Colors.white,
                        borderRadius: current == index
                            ? BorderRadius.circular(10)
                            : BorderRadius.circular(10),
                        border: current == index
                            ? null
                            : Border.all(color: Colors.white)),
                    child: Center(
                      child: Text(
                        items[index],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                current == index ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Expanded(
          flex: 3,
          child: widgetlist[current],
        ),
        Container(
          color: Colors.white,
          // height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  var data = await sp.clear();
                  Homepagedatasmap.clear();
                  filteredData.clear();
                  finalUid = 0;

                  if (data == true) {
                    const Login_with_username().navigateTo(context);
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
                  Rentingps.gpstorentnumberinsert(mobilenumber);
                  // const rent2().navigateTo(context);
                  rentmobilenum = mobilenumber;
                  
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Truck_services(),
                  ));
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
        ) // widgetlist[current],
      ],
    );
  }
}

class NumberGenerator {
  Future<List<String>> slowNumbers() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => numbers,
    );
  }

  List<String> get numbers => List.generate(5, (index) => number);

  String get number => Random().nextInt(99999).toString();
}

class Bottom_Sheet extends StatelessWidget {
  String vehnum;
  int vehicletype;
  String installationdate;
  String expdate;
  String vid;

  Bottom_Sheet(
      {super.key,
      required this.vehnum,
      required this.vehicletype,
      required this.installationdate,
      required this.expdate,
      required this.vid});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: height(context) * 0.25,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color.fromARGB(169, 231, 231, 231),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22), topRight: Radius.circular(22))),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Driver_Details(
                      vehiclenum: vehnum,
                      vid: vid,
                    ),
                  ));
                },
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const Driver_Details(),
                // )),
                title: Text(
                  "driverdetails".tr(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Rto_letter_form(
                      vehiclenum: vehnum,
                      installeddate: installationdate,
                      expdate: expdate,
                      type: vehicletype,
                      vid: vid,
                    ),
                  ));
                },

                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => Rto_letter_form(
                //     vehiclenum: vehnum,
                //     installeddate: installationdate,
                //     expdate: expdate,
                //     type: vehicletype,
                //     vid:vid ,
                //   ),
                // )),
                title: Text(
                  "rtoletterform".tr(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 61, 58, 58),
                      fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Vehicle_Removed(),
                  ));
                },
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => const Vehicle_Removed(),
                // )),
                title: Text(
                  "vehicleremoved".tr(),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 24, 21, 21),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int? length123 = 0;

class impo2 extends StatefulWidget {
  String vehiclenum;
  var speedkm;
  String location;
  String ignition;
  var color;
  var colortext;
  int batterypercentage;
  var length;
  var date;
  String isbatteryconnected;
  var todaykilometer;
  String todaykm;
  String vehiclecondition;
  String vid;
  double latitude;
  int vehid;
  String installationdate;
  String expiringdate;

  double longitude;

  impo2(
      {super.key,
      required this.vehiclenum,
      required this.speedkm,
      required this.location,
      required this.ignition,
      required this.color,
      required this.batterypercentage,
      required this.colortext,
      required this.date,
      required this.isbatteryconnected,
      required this.todaykilometer,
      required this.todaykm,
      required this.vehiclecondition,
      required this.vid,
      required this.latitude,
      required this.longitude,
      required this.vehid,
      this.length,
      required this.installationdate,
      required this.expiringdate});

  @override
  State<impo2> createState() => _impo2State();
}

class _impo2State extends State<impo2> {
  DateTime datetime = DateTime(2022, 11, 23, 5, 30);
  var now = DateTime.now();
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
  }

  String stoppagetime = "Today stoppage 00 hrs 00 mins";

  stoptym(String vid) async {
    stoppagetime = await Api.stopagetime(vid);
    if (mounted) {
      setState(() {});
    }
  }

  String tdykm = "Today 0 km";

  todaykm(String vid) async {
    tdykm = await Api.todaykm(vid);
    if (mounted) {
      setState(() {});
    }
  }

  _shareLink(var link) {
    Share.share(link,
        subject: 'Check out this link',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
  }

  @override
  Widget build(BuildContext context) {
    length123 = widget.length;

    return Container(
      // ignore: unrelated_type_equality_checks
      height: widget.isbatteryconnected == 1 ? 300 : 275,
      // MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: Colors.green,
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: const Offset(-6.0, -6.0),
            blurRadius: 15.0,
          ),
          BoxShadow(
            color: const Color.fromARGB(255, 153, 151, 151).withOpacity(0.4),
            offset: const Offset(6.0, 6.0),
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
              // ignore: unrelated_type_equality_checks
              flex: widget.isbatteryconnected != 1 ? 7 : 6,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                child: Row(
                  children: [
                    Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onTap: () {
                            ///main uncomment
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Mytest2(
                                vehicleid: widget.vehid,
                                km: widget.speedkm,
                                location: widget.location,
                                latitude: widget.latitude,
                                longitude: widget.longitude,
                                vid: widget.vid,
                                ignition: widget.ignition,
                                vehiclecondition: widget.vehiclecondition,
                                vehiclenum: widget.vehiclenum,
                                speed: "${widget.speedkm}",
                              ),
                            ));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 1, top: 8),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              widget.vehid == 8
                                                  ? Image.asset(
                                                      "images/Bull.png",
                                                      color: widget.color,
                                                      height: 40,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 16
                                                  ? Image.asset(
                                                      "images/jc.png",
                                                      color: widget.color,
                                                      height: 28,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 10
                                                  ? FaIcon(
                                                      FontAwesomeIcons.tractor,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 7
                                                  ? Image.asset(
                                                      "images/van.png",
                                                      height: 30,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 6
                                                  ? Image.asset(
                                                      "images/jeep.png",
                                                      height: 30,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 11
                                                  ? Image.asset(
                                                      "images/rolller.png",
                                                      height: 30,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 12
                                                  ? Image.asset(
                                                      "images/tipper.png",
                                                      height: 35,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 13
                                                  ? Image.asset(
                                                      "images/hitachi1.png",
                                                      height: 40,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 14
                                                  ? Image.asset(
                                                      "images/tanker.png",
                                                      height: 40,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 15
                                                  ? Image.asset(
                                                      "images/grader.png",
                                                      height: 40,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 17
                                                  ? Image.asset(
                                                      "images/crane.png",
                                                      height: 40,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              widget.vehid == 4
                                                  ? Image.asset(
                                                      "images/bike.png",
                                                      height: 30,
                                                      color: widget.color,
                                                    )
                                                  : const SizedBox(),
                                              Icon(
                                                widget.vehid == 1
                                                    ? CupertinoIcons
                                                        .car_detailed
                                                    : widget.vehid == 2
                                                        ? FontAwesomeIcons.truck
                                                        : widget.vehid == 3
                                                            ? Icons
                                                                .directions_bus_rounded
                                                            : widget.vehid == 5
                                                                ? HumanitarianIcons
                                                                    .ambulance
                                                                : widget.vehid ==
                                                                        9
                                                                    ? Icons.man
                                                                    : null,
                                                color: widget.color,
                                                size: widget.vehid == 1 ||
                                                        widget.vehid == 2 ||
                                                        widget.vehid == 3 ||
                                                        widget.vehid == 5 ||
                                                        widget.vehid == 9
                                                    ? 30
                                                    : 0,
                                              ),
                                              Text(
                                                "${widget.speedkm} km/h",
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.08,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                widget.vehiclenum,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                widget.date,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: const [
                                              Padding(
                                                padding: EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.green,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: SizedBox(
                                              width: width(context) * 0.56,
                                              child: Text(
                                                widget.location,
                                                style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              stoptym(widget.vid);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: Color.fromARGB(
                                                    255, 197, 197, 197),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  "${'Stopped'.tr()} ",
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "      -${stoppagetime.toString().substring(14)}",
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              todaykm(widget.vid);
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8)),
                                                color: Color.fromARGB(
                                                    255, 197, 197, 197),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Text(
                                                  'todaykm'.tr(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "     - $tdykm",
                                            style: TextStyle(
                                                color: whiteecolor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w800),
                                          ),
                                        ],
                                      ),
                                      // ignore: unrelated_type_equality_checks
                                      widget.isbatteryconnected == 1
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                  width: 4,
                                                  child: Text(
                                                    "wire cut",
                                                    style: TextStyle(
                                                        color: whiteecolor),
                                                  ),
                                                )
                                              ],
                                            )
                                          : const Text(""),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    const VerticalDivider(thickness: 2),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.ignition,
                                style: TextStyle(
                                    color: widget.colortext,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                "🔑",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 161, 161, 153),
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.battery_charging_full_outlined,
                                color: Colors.black,
                              ),
                              Text(
                                "${widget.batterypercentage} %",
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
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
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);
                                    var earlier =
                                        now.add(const Duration(minutes: 30));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var enddate30 =
                                        formatterend.format(earlier);

                                    await Api.sharebutton(
                                        widget.vid, startdatemain, enddate30);

                                    _shareLink(sharebuttonmap["linkShareText"]);
                                  }),
                              FocusedMenuItem(
                                  title: Text("2 ${'hour'.tr()}"),
                                  onPressed: () async {
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);

                                    var earlier =
                                        now.add(const Duration(hours: 2));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var enddate2 = formatterend.format(earlier);

                                    await Api.sharebutton(
                                        widget.vid, startdatemain, enddate2);

                                    _shareLink(sharebuttonmap["linkShareText"]);
                                  }),
                              FocusedMenuItem(
                                  title: Text("4 ${'hour'.tr()}"),
                                  onPressed: () async {
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);

                                    var earlier =
                                        now.add(const Duration(hours: 4));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var enddate2 = formatterend.format(earlier);

                                    await Api.sharebutton(
                                        widget.vid, startdatemain, enddate2);

                                    _shareLink(sharebuttonmap["linkShareText"]);
                                  }),
                              FocusedMenuItem(
                                  title: Text("8 ${'hour'.tr()}"),
                                  onPressed: () async {
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);

                                    var earlier =
                                        now.add(const Duration(hours: 8));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var enddate2 = formatterend.format(earlier);

                                    await Api.sharebutton(
                                        widget.vid, startdatemain, enddate2);

                                    _shareLink(sharebuttonmap["linkShareText"]);
                                  }),
                              FocusedMenuItem(
                                  title: Text("12 ${'hour'.tr()}"),
                                  onPressed: () async {
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);

                                    var earlier =
                                        now.add(const Duration(hours: 12));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var enddate2 = formatterend.format(earlier);

                                    await Api.sharebutton(
                                        widget.vid, startdatemain, enddate2);

                                    _shareLink(sharebuttonmap["linkShareText"]);
                                  }),
                              FocusedMenuItem(
                                  title: Text("24 ${'hour'.tr()}"),
                                  onPressed: () async {
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);

                                    var earlier =
                                        now.add(const Duration(days: 1));
                                    var formatterend =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
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
                                      lastDate: DateTime.now()
                                          .add(const Duration(hours: 24)),
                                    ).then((selectedDate) {
                                      if (selectedDate != null) {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              selectedDate),
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
                                    var formatter =
                                        DateFormat('yyyy-MM-dd HH:mm:ss');
                                    var startdatemain = formatter.format(now);
                                    await Api.sharebutton(widget.vid,
                                        startdatemain, _selectedDate);

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
                    )),
                  ],
                ),
              )),
          Container(
            height: 0,
            decoration: BoxDecoration(
                color: blackcolor,
                border: const Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 0,
                  ),
                )),
          ),
          Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 28,
                            width: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.green,
                            ),
                            child: Image.asset(
                              "images/odo2.png",
                              fit: BoxFit.fill,
                              color: whiteecolor,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${widget.speedkm} Km/h",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      const VerticalDivider(),
                      InkWell(
                        hoverColor: Colors.red,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlayTheRoute(
                                    vehiclenum: widget.vehiclenum,
                                    vid: widget.vid,
                                  )));
                        },
                        child: Container(
                          color: blackcolor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => PlayTheRoute(
                                            vehiclenum: widget.vehiclenum,
                                            vid: widget.vid,
                                          )));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => backplay(
                                  //         vehiclenum: widget.vehiclenum,
                                  //           vid: widget.vid,
                                  //       ),
                                  //     ));
                                },
                                child: Container(
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: blackcolor,
                                    // color: Colors.green,
                                  ),
                                  child: Image.asset(
                                    "images/pla.png",
                                    color: whiteecolor,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'playroute'.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: whiteecolor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const VerticalDivider(),
                      GestureDetector(
                        onTap: () {
                          Api.Relay(widget.vid);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Relay(vid: widget.vid),
                          ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "images/lock.png",
                                fit: BoxFit.fill,
                                color: whiteecolor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'relay'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: whiteecolor),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 20,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                // color: Colors.green,
                              ),
                              child: Image.asset(
                                "images/sos.png",
                                color: whiteecolor,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'sos'.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: whiteecolor),
                          ),
                        ],
                      ),
                      const VerticalDivider(),
                      GestureDetector(
                        onTap: () {
                          showBottomSheet(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            context: context,
                            builder: (context) => Bottom_Sheet(
                              vehnum: widget.vehiclenum,
                              vehicletype: widget.vehid,
                              installationdate: widget.installationdate,
                              expdate: widget.expiringdate,
                              vid: widget.vid,
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    context: context,
                                    builder: (context) => Bottom_Sheet(
                                      vehnum: widget.vehiclenum,
                                      vehicletype: widget.vehid,
                                      installationdate: widget.installationdate,
                                      expdate: widget.expiringdate,
                                      vid: widget.vid,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "images/more.png",
                                  fit: BoxFit.fill,
                                  color: whiteecolor,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'more'.tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: whiteecolor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
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
      this.datetime = newdateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));
}
