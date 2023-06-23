import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/drawer_inside.dart/posted_bookings/posted_bookings.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Rent_App/Truck_servises/Rent_Home_Page.dart';
import '../../Rent_App/rent/rent.dart';

class More extends StatelessWidget {
  const More({super.key});

  void showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text("Institute"),
              SizedBox(
                height: 7,
              ),
              Text(title),
            ],
          ),
          content: Text(message),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    launch("tel://7026623139");
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text('Call 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    launch("tel://8296111444");
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Text('Call 2'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 62, 128, 154)),
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Buy_GPS2(
                        text: 'BUY GPS',
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: Image.asset(
                                "images/RV09d.webp",
                              )),
                          Text(
                            "BuyGPS".tr(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Buy_GPS2(
                        text: 'BUY FASTAG',
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Image.asset(
                                "images/fastag.jpg",
                              )),
                          Text(
                            "fastag".tr(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.26,
                          child: Image.asset(
                            "images/dicard.png",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Diesel card",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 13,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: Image.asset(
                                "images/global.png",
                              )),
                          Text(
                            "matrimony".tr(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.26,
                              child: Image.asset(
                                "images/java.jpeg",
                              )),
                          const Text(
                            "java institute",
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.26,
                    child: Image.asset(
                      "images/download.png",
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => Truck_services(),
                    // ));
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Truck_services(),
                    ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          Icons.fire_truck,
                          size: 40,
                          color: Color.fromARGB(255, 75, 156, 222),
                        ),
                        Text(
                          "Vehicle Rental",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const Expired_vehicle(),
                    // ));
                    // const rent2().navigateTo(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: const [
                        Icon(
                          CupertinoIcons.bus,
                          size: 40,
                          color: Color.fromARGB(255, 75, 156, 222),
                        ),
                        Text(
                          "Vehicle Sales",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => const Expired_vehicle(),
                    // ));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.pin_drop,
                          size: 40,
                          color: Color.fromARGB(255, 75, 156, 222),
                        ),
                        Text(
                          "porter".tr(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //     height: 50,
                //     width: MediaQuery.of(context).size.width * 0.26,
                //     child: Image.asset(
                //       "images/download.png",
                //     )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: Image.asset(
                          "images/building.png",
                        )),
                    const Text(
                      "Site Sales",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.26,
                        child: Image.asset(
                          "images/gst.jpeg",
                        )),
                    const Text(
                      "GST file",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Image.asset(
                          "images/freelancers.jpg",
                        )),
                    const Text(
                      "Freelancing Website",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     showAlertDialog(context, "IOS And Android Training ",
                //         "To know more information Please Contact us");
                //   },
                //   child: Container(
                //       color: const Color.fromARGB(255, 206, 200, 200),
                //       height: 60,
                //       width: MediaQuery.of(context).size.width * 0.2,
                //       child: Center(
                //           child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: const [
                //           Text(
                //             "IOS And ",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //           Text(
                //             "Android",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //           Text(
                //             "Training",
                //             style: TextStyle(fontWeight: FontWeight.bold),
                //           )
                //         ],
                //       ))),
                // ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context, "Tally Training ",
                            "To know more information Please Contact us");
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset(
                            // "rentimages/gg.jpeg",
                            "rentimages/tally.jpg",
                          )),
                    ),
                    const Text(
                      "Tally Training",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),

                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context, "GST Training ",
                            "To know more information Please Contact us");
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset(
                            "rentimages/gg.jpeg",
                          )),
                    ),
                    const Text(
                      "GST Training",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context, "IOS And Android Training ",
                            "To know more information Please Contact us");
                      },
                      child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset(
                            "rentimages/flu.png",
                          )),
                    ),
                    const Text(
                      "Flutter Training",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),

                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.2,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
