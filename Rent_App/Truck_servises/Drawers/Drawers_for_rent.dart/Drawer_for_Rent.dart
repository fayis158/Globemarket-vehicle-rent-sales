//Drawer for rent

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/add_my_vehicle.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/drawer_inside.dart/profilepage.dart/profile.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Contactus/contactus.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Login_page/Login_with_username.dart';
import '../../../../test.dart';
import '../../Api_Truck_service/ApiT.dart';
import '../../Demand.dart/Current_status_of_vehicle.dart/CurrentStateOfBooking.dart';
import '../../drawer_inside.dart/Received_bookings/received_bookings.dart';
import '../../drawer_inside.dart/accepted_bookings/acceptedBooking.dart';
import '../../drawer_inside.dart/posted_bookings/posted_bookings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../drawer_inside.dart/subscription/subscription.dart';

class DrawerForRentPage extends StatelessWidget {
  DrawerForRentPage({Key? key}) : super(key: key);

  final ApiT myController2 = Get.find();

  @override
  Widget build(BuildContext context) {
    //  final profileController = Get.find<ProfileController>();
    final ProfileController profileController = Get.find<ProfileController>();
    // Access the selected image
    final selectedImage = profileController.image;

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
                      //  launch("tel://$numberfastag");
                      // SizedBox(
                      //   width: 90,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [],
                      //   ),
                      // ),
                      // const Text(
                      //   "",
                      //   style: TextStyle(fontSize: 15.0),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    // dynamic firstElement = myController2.mainuserdata;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 10, 58, 30),
            ),
            child: Column(
              children: [
                const Text(
                  'Globe GPS Market',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Obx(() {
                    if (profileController.selectedImage.value != null) {
                      return CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            FileImage(profileController.selectedImage.value!),
                      );
                    } else {
                      return const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('rentimages/profile.png'),
                        // child: Align(
                        //   alignment: Alignment.bottomRight,
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.white,
                        //     radius: 16,
                        //     child: Icon(
                        //       Icons.edit,
                        //       color: Colors.black,
                        //       size: 16,
                        //     ),
                        //   ),
                        // ),
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 3,
                ),
                // Text(
                //   firstElement[0]["name"] ?? "",
                //   style: const TextStyle(color: Colors.white),
                // )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Truck_services(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('GPS Home Page'),
            onTap: () {
              finalUid == 0
                  ? showmessage()
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TabBarDemo(),
                      ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('My Profile'),
            onTap: () {
              Get.to(() => ProfilePage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits_rounded),
            title: const Text('Buy GPS'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Buy_GPS(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              CupertinoIcons.news,
            ),
            title: const Text('Renewal'),
            onTap: () {
              Get.to(() => const SubscribeT());
            },
          ),
          // ListTile(
          //   title: const Text('For Users'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: const Icon(Icons.turned_in_outlined),
          //   title: const Text('Current Status of My Booking'),
          //   onTap: () {

          //     Get.to(() => const Current_State_of_bookings());
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.task_alt_outlined,
          //     color: Colors.green,
          //   ),
          //   title: const Text('Accepted Bookings'),
          //   onTap: () {},
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.edit,
          //     color: Color.fromARGB(255, 5, 50, 86),
          //   ),
          //   title: const Text('Demand Vehicle Edit'),
          //   onTap: () {},
          // ),
          // Li
          // const ListTile(
          //   title: Text("For Users"),
          // ),
          ListTile(
            leading: const Icon(Icons.bookmark_added_rounded),
            title: const Text('Accepted Booking'),
            onTap: () {
              Get.to(() => Acceptedbookings());
            },
          ),

          // const ListTile(
          //   title: Text("For Drivers"),
          // ),

          ListTile(
            leading: const Icon(Icons.timelapse),
            title: const Text('Posted Booking'),
            onTap: () {
              Get.to(() => Posted_bookings(
                    title: "Posted Booking",
                  ));
            },
          ),

          ListTile(
            leading: const Icon(Icons.call_received),
            title: const Text('Received Booking'),
            onTap: () {
              Get.to(() => ReceivedBookings(
                    title: "Received Booking",
                  ));
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.edit,
          //     color: Color.fromARGB(255, 5, 50, 86),
          //   ),
          //   title: const Text(' Vehicle Rent Edit'),
          //   onTap: () {
          //     Get.to(() => Add_my_vehicle());
          //   },
          // ),
          ListTile(
            title: const Text('Company Side Details'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms And Condition'),
            onTap: () {
              launchUrl(Uri.parse('https://www.globalgps.in/terms.aspx'));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              finalUid = 0;
              prefs.remove("isLoggedIn");
              prefs.remove("isLoggedInforrent");
              prefs.remove("expiredate");
              prefs.remove("typeofuser");
              rentmobilenum = "";
              const Login_with_username().navigateTo(context);
            },
          ),
        ],
      ),
    );
  }
}
