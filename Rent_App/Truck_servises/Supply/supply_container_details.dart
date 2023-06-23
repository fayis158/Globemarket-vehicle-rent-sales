import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import 'package:gpsglobe/Screens/more_in_tabbar.dart/More.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Screens/Home_page/Home_page.dart';
import '../Api_Truck_service/ApiT.dart';
import 'Supply.dart';

Color white = Colors.black;
Color yellow = const Color.fromARGB(255, 6, 101, 6);

// int uniqued = 0;

class Supply_container extends StatefulWidget {
  Supply_container(
      {super.key,
      required this.fromlocation,
      required this.tolocation,
      required this.vehicle,
      required this.ownername,
      required this.date,
      required this.transportname,
      required this.rate,
      required this.vehicleDetails,
      required this.rruid,
      required this.Supplyid,
      required this.freekm,
      required this.freehr,
      required this.mobilenum,
      required this.vehnumber});
  String fromlocation;
  String tolocation;
  String vehicle;
  String ownername;
  String date;
  String transportname;
  String rate;
  String vehicleDetails;
  int rruid;
  int Supplyid;
  String freekm;
  String freehr;
  String mobilenum;
  String vehnumber;

  @override
  State<Supply_container> createState() => _Supply_containerState();
}

class _Supply_containerState extends State<Supply_container> {
  final ApiController anotherPageController = Get.put(ApiController());

  final ApiT myController = Get.put(ApiT());

  RxBool accepted = false.obs;

  @override
  void initState() {
    super.initState();
    accepted = myController.acceptapi;
    myController.acceptapiforbutton(widget.Supplyid);
  }

  void openWhatsApp() async {
    String phoneNumber =
        widget.mobilenum; // Replace with the desired phone number

    // Use the 'whatsapp://send' URL scheme to open WhatsApp
    String url = 'whatsapp://send?phone=$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showmessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            width: 260.0,
            height: 180.0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Globe GPS",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Text(
                      "Notice : - ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text("Buy GPS To Access our GPS services"),
                    GestureDetector(
                      onTap: () {
                        launch("tel://87922897640");
                      },
                      child: const Text(
                        "87922897640",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        launch("tel://9148998994");
                      },
                      child: const Text(
                        "9148998994",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("--> Click --> "),
                        const SizedBox(
                          width: 9,
                        ),
                        TextButton(
                          child: const Text('Buy GPS'),
                          onPressed: () {
                            Get.back();
                            Get.to(() => const Buy_GPS());
                          },
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Get.back();
                            // Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 36, 43),
        title: const Text("Vehicle For Rent"),
        actions: [
          IconButton(
              onPressed: () {
                finalUid == 0
                    ? showmessage()

                    //  showAlert(
                    //     context, 'Notice', 'Buy GPS To Access our GPS services')
                    : Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TabBarDemo(),
                        ));
              },
              icon: const Icon(Icons.gps_fixed)),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const More(),
                ),
              );
            },
            icon: Image.asset(
              'rentimages/cart.png',
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Owner: ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.ownername,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'TransportName: ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.transportname,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text(
                    "Vehicle Number : ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Colors.green),
                  ),
                  Text(
                    widget.vehnumber,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'From : ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    TextSpan(
                      text: widget.fromlocation,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'To: ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.tolocation,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Details: ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: "${widget.vehicle} , ${widget.vehicleDetails}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Date: ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.date,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Amount(Rs): ',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.rate,
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Free hour :',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.freehr == ""
                          ? " 0 hr"
                          : " ${widget.freehr} hr",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Free km :',
                      style: TextStyle(
                          color: yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    TextSpan(
                      text: widget.freekm == ""
                          ? "0 km"
                          : "   ${widget.freekm} km",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  widget.rruid == rentuid
                      ? SizedBox()
                      : IconButton(
                          onPressed: () {
                            launch("tel://${widget.mobilenum}");
                          },
                          icon: const Icon(
                            Icons.call,
                            color: Colors.green,
                          )),
                  IconButton(
                      onPressed: () {
                        openWhatsApp();
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.whatsapp,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        Sharecontents.shareLink222(
                            "Transport: ${widget.transportname} \r\n  \r\n OwnerName: ${widget.ownername} \r\n \r\n ${widget.vehicle} \r\n \r\n  vehicle :{sharingdata["
                            "]} \r\n \r\n From: \r\n ${widget.fromlocation} \r\n \r\n To: \r\n ${widget.tolocation} \r\n \r\n vehicleDetails:${widget.vehicleDetails} \r\n \r\n Date:${widget.date}\r\n \r\n\r\n \r\n https://play.google.com/store/apps/details?id=app.globalgps");
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.green,
                      )),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              widget.rruid == rentuid
                  ? SizedBox()
                  : Obx(
                      () => Column(
                        children: [
                          (MaterialButton(
                            minWidth: width(context),
                            height: 40,
                            color: accepted.value
                                ? const Color.fromARGB(255, 138, 54, 146)
                                : Colors.green,
                            onPressed: accepted.value
                                ? () {}
                                : () {
                                    DateTime now = DateTime.now();
                                    anotherPageController.accepttrip(
                                        widget.Supplyid,
                                        now.toString(),
                                        widget.rruid);

                                    // Get.snackbar(
                                    //   // snackPosition: SnackPosition.values[1],
                                    //   "",
                                    //   "",
                                    //   backgroundColor: Colors.black,
                                    //   titleText: const Text(
                                    //     "Accepted",
                                    //     style: TextStyle(
                                    //         color: Color.fromARGB(
                                    //             255, 255, 255, 255),
                                    //         fontWeight: FontWeight.bold),
                                    //   ),
                                    //   messageText: const Text(
                                    //     "Now they can see Your Request",
                                    //     style: TextStyle(
                                    //       color: Color.fromARGB(
                                    //           255, 255, 255, 255),
                                    //     ),
                                    //   ),
                                    // );
                                    myController
                                        .acceptapiforbutton(widget.Supplyid);

                                    // uniqued = widget.rruid;
                                  },
                            child: Text(
                              accepted.value ? "Accepted" : "Accept The Trip",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                          accepted.value == true
                              // && uniqued == widget.rruid
                              ? const Text(
                                  "Accepted, Now they can see Your Request",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 31, 56, 2)),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
              const SizedBox(
                height: 5,
              ),
              Table(
                children: [
                  TableRow(
                    children: [
                      GestureDetector(
                        onTap: () => Get.to(() => const Buy_GPS()),
                        child: BoxWidget(
                            color: const Color.fromARGB(255, 39, 45, 44),
                            subject: "BUY GPS",
                            icon: const Icon(
                              Icons.gps_fixed,
                              color: Colors.white,
                            )),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const More()),
                        child: BoxWidget(
                            color: Colors.blue,
                            subject: "BASKET",
                            icon: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      GestureDetector(
                          onTap: () {
                            launch("tel://$numberbuygps");
                          },
                          child: BoxWidget(
                              color: Colors.green,
                              subject: "HELP LINE",
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                              ))),
                      BoxWidget(
                          color: const Color.fromARGB(255, 80, 73, 11),
                          subject: "RECORD",
                          icon: const Icon(
                            Icons.record_voice_over,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final Color color;
  String subject;
  Widget icon;

  BoxWidget({required this.color, required this.subject, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: color,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.gps_fixed,
            //   color: Colors.white,
            // ),
            icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              subject,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sharecontents {
  static shareLink222(var link) {
    Share.share(link,
        subject: 'Check out this link',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
  }
}
