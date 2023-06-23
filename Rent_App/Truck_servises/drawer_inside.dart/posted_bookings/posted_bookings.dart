import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Constant.dart';
import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Home_page/Home_page.dart';
import '../../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../../global/global.dart';
import '../../Api_Truck_service/controller.dart';
import '../../Supply/Supply.dart';
import '../../Supply/supply_container_details.dart';
import 'editadd.dart';

// class Posted_bookings extends StatelessWidget {
//   Posted_bookings({super.key, required this.title});
//   String title;
//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//         backgroundColor: const Color.fromARGB(255, 11, 36, 43),
//       ),
//       body: ListView.builder(
//         itemBuilder: (context, index) {
//           final ApiT myController = Get.put(ApiT());
//           print(myController.postedbookings);
//           return postedbookingview(
//             vehiclename: "tempooo",
//             name: "muhammed",
//             from:
//                 "2nd floor,8th mile Near Axis bank Tumkuru, highway, Road, T. Dasarahalli, Bengaluru, Karnataka 560057 ",
//             to: "2nd floor,8th mile Near Axis bank Tumkuru, highway, Road, T. Dasarahalli, Bengaluru, Karnataka ",
//             avaistatus: "Available",
//             date: "",
//           );
//         },
//       ),
//     );
//   }
// }

class Posted_bookings extends StatelessWidget {
  Posted_bookings({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {

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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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

    final ApiT myController = Get.put(ApiT());

    // Call the postedbooking API method
    myController.postedbooking();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => Truck_services());
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 11, 36, 43),
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
      body: Obx(
        () => ListView.builder(
          itemCount: myController.postedbookings.length,
          itemBuilder: (context, index) {
            // Use the updated postedbookings list from the API response
            final List<dynamic> postedBookings = myController.postedbookings;

            return postedbookingview(
              vehiclename: postedBookings[index]["vehicle"],
              name: postedBookings[index]["customerName"],
              from: postedBookings[index]["fromAddress"],
              to: postedBookings[index]["toAddress"],
              avaistatus: postedBookings[index]["availStatus"],
              date: postedBookings[index]["date"],
              supplyid: postedBookings[index]["supplyId"],
              transportname: postedBookings[index]["transportName"],
              vehiclenumber: postedBookings[index]["vehicleNo"],
              vehicledetails: postedBookings[index]["vehicleDetails"],
              vehicletypeid: postedBookings[index]["vehicleTypeId"],
              rate: postedBookings[index]["rate"],
              freekm: postedBookings[index]["freeKm"],
              freehr: postedBookings[index]["freeHr"],
              mobilenumber: postedBookings[index]["mobileNo"],
              vehdetails: postedBookings[index]["vehicleDetails"],
            );
          },
        ),
      ),
    );
  }
}

class postedbookingview extends StatelessWidget {
  postedbookingview(
      {super.key,
      required this.vehiclename,
      required this.name,
      required this.from,
      required this.to,
      required this.avaistatus,
      required this.date,
      required this.supplyid,
      required this.transportname,
      required this.vehiclenumber,
      required this.vehicledetails,
      required this.vehicletypeid,
      required this.rate,
      required this.freekm,
      required this.freehr,
      required this.mobilenumber,
      required this.vehdetails});

  String vehiclename;
  String name;
  String from;
  String to;
  String avaistatus;
  String date;
  int supplyid;
  // transportName
  String transportname;
  String vehiclenumber;
  String vehicledetails;
  int vehicletypeid;
  int rate;
  String freekm;
  String freehr;
  String mobilenumber;
  String vehdetails;

  bool cancel = false;
  final ApiController anotherPageController = Get.put(ApiController());
  final ApiT myController = Get.put(ApiT());
  final RxBool isSwitched = false.obs;

  @override
  Widget build(BuildContext context) {
    avaistatus == "Available" ? isSwitched.value = true : false;
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => Supply_container(
        //     fromlocation: widget.From,
        //     tolocation: widget.toaddres,
        //     vehicle: widget.typeofvehicle,
        //     ownername: widget.ownername,
        //     date: widget.date,
        //     transportname: widget.transportname,
        //     rate: widget.rate,
        //   ),
        // ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              // height: 200,
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [

                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          FontAwesomeIcons.truck,
                          size: 30,
                        ),
                        Text(
                          vehiclename,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Text(
                              name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                // MaterialButton(
                                //   color: Colors.green,
                                //   height: 30,
                                //   minWidth: 60,
                                //   onPressed: () {
                                //     launch("tel://$numberaccrelated");
                                //   },
                                //   child: const Text(
                                //     "Call",
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: width(context) * 0.05,
                                // ),
                                // IconButton(
                                //     onPressed: () {},
                                //     icon: const Icon(
                                //       Icons.whatsapp,
                                //       color: Colors.green,
                                //     )),
                                SizedBox(
                                  width: width(context) * 0.05,
                                ),
                                const Icon(
                                  Icons.share,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: width(context) * 0.05,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: width(context) * 0.06,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      vehiclenumber,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 17),
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
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(" - "),
                        SizedBox(
                            width: width(context) * 0.8,
                            child: Text(
                              from,
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
                        const Text(" - "),
                        SizedBox(
                            width: width(context) * 0.8,
                            child: Text(
                              to,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 76, 104, 175),
                                  fontSize: 12),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Status :  "),
                        Text(
                          avaistatus,
                          style: TextStyle(
                              color: avaistatus == "Available"
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Date :  "),
                        Text(
                          date,
                          style: const TextStyle(color: Colors.green),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        // avaistatus == "Available"
                        //     ? GetBuilder<ApiController>(
                        //         builder: (controller) => MaterialButton(
                        //               color: Colors.red,
                        //               onPressed: () async {
                        //                 await anotherPageController
                        //                     .cancelrentbooking(supplyid);
                        //                 myController.postedbooking();
                        //               },
                        //               child: const Text(
                        //                 "Cancel",
                        //                 style: TextStyle(color: Colors.white),
                        //               ),
                        //             ))
                        //     : SizedBox()

                        // avaistatus == "Available"
                        //     ? MaterialButton(
                        //         color: Colors.red,
                        //         onPressed: () async {
                        //           Get.dialog(
                        //             AlertDialog(
                        //               title: const Text(''),
                        //               content: const Text(
                        //                   'Are You sure That You want to cancel the request'),
                        //               actions: [
                        //                 TextButton(
                        //                   onPressed: () {
                        //                     Get.back();
                        //                   },
                        //                   child: const Text('No'),
                        //                 ),
                        //                 TextButton(
                        //                   onPressed: () async {
                        //                     await anotherPageController
                        //                         .cancelrentbooking(supplyid);
                        //                     myController.postedbooking();
                        //                     Get.back(); // Close the alert dialog
                        //                   },
                        //                   child: const Text('Yes'),
                        //                 ),
                        //               ],
                        //             ),
                        //           );

                        //           // await anotherPageController
                        //           //     .cancelrentbooking(supplyid);
                        //           // myController.postedbooking();
                        //         },
                        //         child: const Text(
                        //           "Cancel",
                        //           style: TextStyle(color: Colors.white),
                        //         ),
                        //       )
                        //     : const SizedBox(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          height: 25,
                          minWidth: 12,
                          color: Colors.blue,
                          onPressed: () {
                            Get.to(() => Add_my_vehicle_from_edit(
                                  fromcityedit: from,
                                  tocity: to,
                                  transportname: transportname,
                                  name: name,
                                  vehiclenum: vehiclenumber,
                                  vehicledetails: vehicledetails,
                                  vehicletypeid: vehicletypeid,
                                  supplyid: supplyid,
                                ));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Text(
                                "Edit",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Row(
                            children: [
                              const Text("Please Active -"),
                              Obx(
                                () => Switch(
                                  value: isSwitched.value,
                                  onChanged: (value) async {
                                    isSwitched.value = value;
                                    // print("switch ${isSwitched.value}");
                                    if (isSwitched.value == false) {
                                      await anotherPageController
                                          .cancelrentbooking(supplyid, 2);
                                      myController.postedbooking();
                                    } else {
                                      String available =
                                          DateTime.now().toString();
                                      await anotherPageController
                                          .cancelrentbooking(supplyid, 1);
                                      myController.postedbooking();
                                      // anotherPageController
                                      //     .callpostaddvehicleSupply(
                                      //         vehicletypeid,
                                      //         from,
                                      //         to,
                                      //         1,
                                      //         rate,
                                      //         freekm,
                                      //         freehr,
                                      //         transportname,
                                      //         name,
                                      //         mobilenumber,
                                      //         vehdetails,
                                      //         vehiclenumber,
                                      //         available,
                                      //         rentuid);
                                    }
                                  },
                                  activeColor: const Color.fromARGB(255, 13,
                                      112, 17), // Color when the switch is on
                                  inactiveThumbColor: const Color.fromARGB(
                                      255,
                                      183,
                                      37,
                                      37), // Color of the switch thumb when it's off
                                  inactiveTrackColor:
                                      const Color.fromARGB(255, 222, 120, 120),
                                ),
                              ),
                              Obx(
                                () => Text(
                                  isSwitched.value ? 'On' : 'Off',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
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

class sharee extends StatefulWidget {
  @override
  _shareeState createState() => _shareeState();
}

class _shareeState extends State<sharee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () async {
            // await FlutterShare.share(
            //     title: 'Share text',
            //     text: 'This is an example of sharing text in Flutter.',
            //     linkUrl: 'https://web.whatsapp.com',
            //     chooserTitle: 'Share');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const <Widget>[
                Text(
                  'Share',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.share,
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
