import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/View_details.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/drawer_inside.dart/subscription/subscription.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Constant.dart';
import '../Api_Truck_service/ApiT.dart';
import 'supply_container_details.dart';

class BookingContainer extends StatefulWidget {
  BookingContainer(
      {super.key,
      required this.From,
      required this.vehiclename,
      required this.ownername,
      required this.toaddres,
      required this.availStatus,
      required this.date,
      required this.typeofvehicle,
      required this.transportname,
      required this.rate,
      required this.vehicledetails,
      required this.supplyid,
      required this.typeOfVehicle,
      required this.ruid,
      required this.freekm,
      required this.freehr,
      required this.mobilenum,
      required this.vehnumber,
      required this.vehiclefrontphotopath,
      required this.vehiclebackphotopath});
  String From;
  String vehiclename;
  String ownername;
  String toaddres;
  String availStatus;
  String date;
  String typeofvehicle;
  String transportname;
  String rate;
  String vehicledetails;
  int supplyid;
  String typeOfVehicle;
  int ruid;
  String freekm;
  String freehr;
  String mobilenum;
  String vehnumber;
  String vehiclefrontphotopath;
  String vehiclebackphotopath;

  @override
  State<BookingContainer> createState() => _BookingContainerState();
}

class _BookingContainerState extends State<BookingContainer> {
  final ApiT myController = Get.put(ApiT());

  int getusercount = 0;
  int limitedcount = 0;

  @override
  void initState() {
    super.initState();
    // getusercount = myController.getcountuser.toInt();
    // limitedcount = myController.gettotalcountuser.toInt();
    dategetter();
    // print(typeofuser);

    callcountapi();
  }

  callcountapi() async {
    await myController.getUserTouchCount();
    getusercountapi();
  }

  getusercountapi() {
    limitedcount = myController.getcountuser.toInt();
    getusercount = myController.gettotalcountuser.toInt();
  }

  // void showAlertDialog() {
  //   Get.defaultDialog(
  //     title: "Your Free Limit is over",
  //     middleText: "Subscribe for more",
  //     textConfirm: 'Pay',
  //     confirmTextColor: Colors.white,
  //     onConfirm: () {
  //       Get.back();
  //       Get.to(const SubscribeT());
  //     },
  //     textCancel: 'OK',
  //     onCancel: () {
  //       Navigator.pop(context);
  //       // Get.back(closeOverlays: true);
  //     },
  //   );
  // }
  DateTime currentDate = DateTime.now();
  DateTime? date;

  dategetter() {
    String dateString = expiredate;
    DateFormat format = DateFormat('dd-MMM-yyyy hh:mm:ss a');
    date = format.parse(dateString);
  }

  bool cancel = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String dateString = expiredate;
        DateFormat format = DateFormat('dd-MMM-yyyy hh:mm:ss a');
        DateTime date = format.parse(dateString);
        DateTime currentDate = DateTime.now();

        widget.ruid != rentuid && limitedcount >= getusercount
            ? await myController.counttouchbyuser(1)
            : null;
        await myController.getUserTouchCount();

        (currentDate.isBefore(date) ||
                limitedcount > getusercount ||
                widget.ruid == rentuid)
            ? Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Supply_container(
                  fromlocation: widget.From,
                  tolocation: widget.toaddres,
                  vehicle: widget.typeofvehicle,
                  ownername: widget.ownername,
                  date: widget.date,
                  transportname: widget.transportname,
                  rate: widget.rate,
                  vehicleDetails: widget.vehicledetails,
                  rruid: widget.ruid,
                  Supplyid: widget.supplyid,
                  freehr: widget.freehr,
                  freekm: widget.freekm,
                  mobilenum: widget.mobilenum,
                  vehnumber: widget.vehnumber,
                ),
              ))
            // : showAlertDialog();
            : showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MyDialog();
                },
              );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: width(context),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(10, 10),
                    blurRadius: 10,
                    spreadRadius: -5,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-10, -10),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 1, bottom: 16, top: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Image.network(
                                          '${widget.vehiclefrontphotopath}',
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.network(
                                    '${widget.vehiclefrontphotopath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Image.network(
                                          '${widget.vehiclebackphotopath}',
                                          fit: BoxFit.contain,
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Image.network(
                                    '${widget.vehiclebackphotopath}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // const Text("Status :  "),

                          Row(
                            children: [
                              Text(
                                "   ${widget.availStatus}  ",
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 26),
                              ),
                              const Icon(
                                Icons.remove_red_eye,
                                color: Colors.grey,
                                size: 15,
                              ),
                              const Text(
                                "  376",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // ClipRect(
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(
                    //         sigmaX: -2,
                    //         sigmaY:
                    //             -10), // Adjust the sigma values for desired blur strength
                    //     child: Text(
                    //       'Blurred',
                    //       style: TextStyle(
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.bold,
                    //         color: Color.fromARGB(255, 172, 164, 164).withOpacity(
                    //             0.05), // Adjust the opacity to control the blur effect
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    // currentDate.isBefore(date!) ||
                    //         widget.ruid == rentuid ||
                    //         typeofuser == true
                    (currentDate.isBefore(date!) ||
                            limitedcount > getusercount ||
                            widget.ruid == rentuid)
                        ? widget.typeOfVehicle == "Transporters"
                            ? Text(
                                "${widget.typeOfVehicle} :   ${widget.transportname}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )
                            : Text("Travels  : ${widget.transportname}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold))
                        : const SizedBox(),
                    Text(
                      "Owner    : ${widget.ownername}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.truck,
                          size: 30,
                        ),
                        SizedBox(
                          // width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "       : ${widget.vehiclename}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width(context) * 0.02,
                            ),
                            (currentDate.isBefore(date!) ||
                                    limitedcount > getusercount ||
                                    widget.ruid == rentuid)
                                ? IconButton(
                                    onPressed: () async {
                                      widget.ruid == rentuid &&
                                              limitedcount < getusercount
                                          ? await myController
                                              .counttouchbyuser(1)
                                          : null;
                                      await myController.getUserTouchCount();
                                      await myController
                                          .sharecontentfn(widget.supplyid);

                                      Map<String, dynamic> sharingdata =
                                          myController.sharecontents[0];

                                      Sharecontents.shareLink222(
                                          "Transport: ${sharingdata["transportName"]} \r\n  \r\n OwnerName: ${sharingdata["customerName"]} \r\n \r\n ${sharingdata["vehicleAvailable"]} \r\n \r\n  vehicle :${sharingdata["typeOfVehicle"]} \r\n \r\n From: \r\n ${sharingdata["fromAddress"]} \r\n \r\n To: \r\n ${sharingdata["toAddress"]} \r\n \r\n vehicleDetails:${sharingdata["vehicleDetails"]} \r\n \r\n Date:${sharingdata["date"]} \r\n \r\n Status:${sharingdata["availStatus"]} \r\n \r\n https://play.google.com/store/apps/details?id=app.globalgps");
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      color: Colors.green,
                                    ))
                                : const SizedBox()
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.phone,
                            //       color: Colors.green,
                            //     )),
                            // ElevatedButton(
                            //     onPressed: () {},
                            //     child: Row(
                            //       children: [
                            //         Text("Call  "),
                            //         Icon(Icons.phone),
                            //       ],
                            //     )),
                          ],
                        ),
                        SizedBox(
                          width: width(context) * 0.03,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "V Num   : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.vehnumber,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "From",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("      - "),
                        SizedBox(
                            width: width(context) * 0.7,
                            child: Text(
                              widget.From,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 175, 76, 149),
                                  fontSize: 12),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "To     ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text("      - "),
                        SizedBox(
                            width: width(context) * 0.7,
                            child: Text(
                              widget.toaddres,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 76, 104, 175),
                                  fontSize: 12),
                            )),
                      ],
                    ),

                    Row(
                      children: [
                        const Text(
                          "Date       : ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.date,
                          style: const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 3,
                    ),

                    const SizedBox(
                      height: 3,
                    ),

                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              "Rate       : ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "[RS-${widget.rate}] ",
                              style: const TextStyle(
                                  color: Colors.green, fontSize: 15),
                            ),
                          ],
                        ),
                        widget.freekm == ""
                            ? const Text("[Free km : 0 Km]")
                            : Text(
                                "[Free :${widget.freekm} km]",
                                style: const TextStyle(fontSize: 15),
                              ),
                        widget.freehr == ""
                            ? const Text("[Free Hour : 0 hr]")
                            : Text(
                                "[Free  :${widget.freehr} hr]",
                                style: const TextStyle(fontSize: 15),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//whats app

class whatsapp extends StatefulWidget {
  @override
  _whatsappState createState() => _whatsappState();
}

class _whatsappState extends State<whatsapp> {
  final String name = "John Doe";
  final String whatsAppUrl =
      "https://api.whatsapp.com/send?phone=9961052060&text=Hi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            if (await canLaunch(whatsAppUrl)) {
              await launch(whatsAppUrl);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: <Widget>[
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.message,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class sharee extends StatefulWidget {
//   @override
//   _shareeState createState() => _shareeState();
// }

// class _shareeState extends State<sharee> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: InkWell(
//           onTap: () async {
//             // await FlutterShare.share(
//             //     title: 'Share text',
//             //     text: 'This is an example of sharing text in Flutter.',
//             //     linkUrl: 'https://web.whatsapp.com',
//             //     chooserTitle: 'Share');
//           },
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: const <Widget>[
//                 Text(
//                   'Share',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(width: 16),
//                 Icon(
//                   Icons.share,
//                   size: 20,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class Sharecontents {
  static shareLink222(var link) {
    Share.share(link,
        subject: 'Check out this link',
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1));
  }
}

//

class MyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Your Free Limit is over'),
      content: const Text('Renewe for more'),
      actions: <Widget>[
        MaterialButton(
          color: const Color.fromARGB(255, 98, 220, 102),
          onPressed: () {
            Navigator.of(context).pop();
            Get.to(const SubscribeT());
          },
          child: const Text(
            'Pay',
            style: TextStyle(color: Colors.white),
          ),
        ),
        MaterialButton(
          color: const Color.fromARGB(255, 76, 94, 175),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
