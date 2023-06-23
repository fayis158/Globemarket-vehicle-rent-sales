import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Constant.dart';
import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Home_page/Home_page.dart';
import '../../../../Screens/more_in_tabbar.dart/More.dart';
import '../../../../global/global.dart';
import '../../Api_Truck_service/ApiT.dart';
import '../../Api_Truck_service/controller.dart';
import '../../Rent_Home_Page.dart';
import '../../Supply/Supply.dart';

class Acceptedbookings extends StatelessWidget {
  Acceptedbookings({
    super.key,
  });
  // String title;

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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
    myController.acceptedbooking();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => Truck_services());
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Accepted Bookings"),
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
          itemCount: myController.acceptedbookings.length,
          itemBuilder: (context, index) {
            // Use the updated postedbookings list from the API response
            final List<dynamic> acceptedbookings =
                myController.acceptedbookings;

            return Acceptedbooking(
              vehiclename: acceptedbookings[index]["vehicle"] ?? "",
              name: acceptedbookings[index]["ownerName"] ?? "",
              from: acceptedbookings[index]["fromAddress"] ?? "",
              to: acceptedbookings[index]["toAddress"] ?? "",
              avaistatus: acceptedbookings[index]["availStatus"] ?? "",
              date: acceptedbookings[index]["postedDate"] ?? "",
              supplyid: acceptedbookings[index]["supplyId"] ?? "",
              accusername: acceptedbookings[index]["customerName"],
              accmobilenum: acceptedbookings[index]["mobile"],
              accuserwhatsapp: acceptedbookings[index]["whatsApp"],
              accuserdate: acceptedbookings[index]["acceptedDate"],
              rate: acceptedbookings[index]["rate"],
              ownermobile: acceptedbookings[index]["ownerMobile"],
            );
          },
        ),
      ),
    );
  }
}

class Acceptedbooking extends StatelessWidget {
  Acceptedbooking({
    super.key,
    required this.vehiclename,
    required this.name,
    required this.from,
    required this.to,
    required this.avaistatus,
    required this.date,
    required this.supplyid,
    required this.accusername,
    required this.accmobilenum,
    required this.accuserwhatsapp,
    required this.accuserdate,
    required this.rate,
    required this.ownermobile,
  });

  String vehiclename;
  String name;
  String from;
  String to;
  String avaistatus;
  String date;
  int rate;
  int supplyid;
  String ownermobile;

  String accusername;
  String accmobilenum;
  String accuserwhatsapp;
  String accuserdate;

  bool cancel = false;
  final ApiController anotherPageController = Get.put(ApiController());
  final ApiT myController = Get.put(ApiT());

  @override
  Widget build(BuildContext context) {
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
                      height: 12,
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
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Text("Rate :  "),
                              Text(
                                rate.toString(),
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          MaterialButton(
                              minWidth: 25,
                              height: 20,
                              color: Colors.green,
                              onPressed: () {
                                launch("tel://${ownermobile}");
                              },
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 19,
                              ))
                        ],
                      ),
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
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     MaterialButton(
                    //       color: const Color.fromARGB(255, 46, 127, 52),
                    //       onPressed: () {
                    //         // Get.to(() => Accepteduserdetails(
                    //         //       name: accusername,
                    //         //       mobile: accmobilenum,
                    //         //       accepteddate: accuserdate,
                    //         //       whatsappnum: accuserwhatsapp,
                    //         //     ));
                    //       },
                    //       child: const Text(
                    //         " Driver  Details",
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             fontSize: 18,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //   ],
                    // )
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
