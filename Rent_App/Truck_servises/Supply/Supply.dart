// import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/Listwidget_of_supply.dart';
import 'package:gpsglobe/Screens/more_in_tabbar.dart/More.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/playroute/playRoute.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../Screens/Home_page/Home_page.dart';
import '../../../test.dart';
import '../Drawers/Drawers_for_rent.dart/Drawer_for_Rent.dart';
import '../ScrolldrowpdownLoading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../drawer_inside.dart/profilepage.dart/profile.dart';

// class Supply extends StatelessWidget {
//   // const Supply({super.key});

//   final ApiT myController = Get.put(ApiT()); // Instantiate the controller
//   String _selectedVehicle = "Truck";

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       drawer: const DrawerForRentPage(),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 39, 38, 36),
//         title: GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => changestate(),
//                   ));
//             },
//             child: const Text("Supply")),
//       ),

//       body: Obx(() {
//         if (myController.vehicles.isEmpty) {
//           // Show a loading indicator or skeleton screen while the API call is in progress
//           return Center(child: CircularProgressIndicator());
//         } else {
//           // Show the list of vehicles using ListView.builder
//           print(myController.vehicles);
//           return ListView.builder(
//             itemCount: myController.vehicles.length,
//             itemBuilder: (context, index) {
//               final vehicle = myController.vehicles[index];

//               return BookingContainer(
//                 From: vehicle["fromAddress"].toString(),
//               );
//             },
//           );
//         }
//       }),
//     );
//   }
// }

class Supply extends StatefulWidget {
  @override
  State<Supply> createState() => _SupplyState();
}

class _SupplyState extends State<Supply> {
  final ApiT myController = Get.put(ApiT());
  // Instantiate the controller
  String? selectedDropdownItem = "0";
  final ApiController anotherPageController = Get.put(ApiController());

  Future<void> _refreshData() async {
    // Call the fetchData() method of your controller to fetch the updated data
    await myController.fetchData(1);
  }

  Future<void> _refreshData2() async {
    // Call the fetchData() method of your controller to fetch the updated data
    await myController.fetchData(2);
  }

  final ApiT myController2 = Get.find();

  @override
  void initState() {
    super.initState();
    selectedDropdownItem = "0";
    ApicallmainApi();
    _refreshData();
    _refreshData2();
  }

  bool showFirstList = true;

  ApicallmainApi() async {
    await anotherPageController.mainpageapi();

    dynamic firstElement = myController2.mainuserdata[0] ?? [{}];
    SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('rentuid', firstElement["uid"]);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int rentuserid = (prefs.getInt("rentuid") ?? 0);

    rentuid = rentuserid;

    List profiledata = myController.mainuserdata;

    final data = profiledata.first;

    if (data['name'] == "" ||
        data['companyName'] == "" ||
        data['emailId'] == "" ||
        data['address'] == "") {
      const bool userDetailsMissing = true;

      // Show the "Fill Details" dialog
      Get.dialog(
        const AlertDialog(
          title: Text('Please Fill Details'),
          content: Text('Please provide your details before proceeding.'),
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      Get.to(() => ProfilePage());
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      // ),
      // floatingActionButton: DraggableFab(
      //   child: FloatingActionButton(
      //     onPressed: () {},
      //     child: Icon(Icons.add),
      //   ),
      // ),
      drawer: DrawerForRentPage(),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
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
      body: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    // width: 150,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          // color: Colors.grey.withOpacity(0.5),
                          color: showFirstList == true
                              ? const Color.fromARGB(255, 3, 53, 171)
                                  .withOpacity(0.5)
                              : const Color.fromARGB(255, 161, 163, 162)
                                  .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            selectedDropdownItem = "0";
                            showFirstList = true;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            primary: showFirstList == true
                                ? const Color.fromARGB(255, 3, 71, 5)
                                : Colors.grey, // Button background color
                            onPrimary: Colors.black, // Button text color
                          ),
                          child: Text(
                            'Travellers',
                            style: TextStyle(
                                color: showFirstList == true
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: showFirstList == false
                              ? const Color.fromARGB(255, 18, 25, 144)
                                  .withOpacity(0.5)
                              : const Color.fromARGB(255, 161, 163, 162)
                                  .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(
                              0, 3), // changes the position of the shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: ElevatedButton(
                          onPressed: () {
                            selectedDropdownItem = "0";
                            showFirstList = false;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            primary: showFirstList == false
                                ? const Color.fromARGB(255, 3, 71, 5)
                                : const Color.fromARGB(255, 180, 179,
                                    179), // Button background color
                            onPrimary: Colors.black, // Button text color
                          ),
                          child: Text(
                            'Transporters',
                            style: TextStyle(
                                color: showFirstList == false
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          showFirstList
              ? ScrollableDropdown(
                  onItemSelected: (item) {
                    setState(() {
                      selectedDropdownItem = item;
                      // print("myb $selectedDropdownItem");
                    });
                  },
                )
              : ScrollableDropdownloading(
                  onItemSelected: (p0) {
                    setState(() {
                      selectedDropdownItem = p0;
                      // print("myb $selectedDropdownItem");
                    });
                  },
                ),
          showFirstList
              ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: FutureBuilder(
                      future: myController.fetchData(1),
                      builder: (context, snapshot) {
                        // _refreshData;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Obx(() {
                            final selectedValue =
                                selectedDropdownItem?.toLowerCase();

                            final filteredVehicles = myController.vehicles
                                .where((vehicle) =>
                                    vehicle["vehicleTypeId"].toString() ==
                                    selectedValue)
                                .toList();

                            final filteredVehiclesNot = myController.vehicles
                                .where((vehicle) =>
                                    vehicle["vehicleTypeId"].toString() !=
                                    selectedValue)
                                .toList();

                            if (selectedValue == "0") {
                              return ListView.builder(
                                itemCount: myController.vehicles.length,
                                itemBuilder: (context, index) {
                                  final vehicle = myController.vehicles[index];
                                  return BookingContainer(
                                    From: vehicle["fromAddress"].toString(),
                                    vehiclename:
                                        vehicle["vehicleAvailable"].toString(),
                                    ownername:
                                        vehicle["customerName"].toString(),
                                    toaddres: vehicle["toAddress"].toString(),
                                    availStatus:
                                        vehicle["availStatus"].toString(),
                                    date: vehicle["date"].toString(),
                                    typeofvehicle:
                                        vehicle["vehicleAvailable"].toString(),
                                    transportname:
                                        vehicle["transportName"].toString(),
                                    rate: vehicle["rate"].toString(),
                                    vehicledetails:
                                        vehicle["vehicleDetails"].toString(),
                                    supplyid: vehicle["supplyId"],
                                    typeOfVehicle:
                                        vehicle["typeOfVehicle"].toString(),
                                    ruid: vehicle["uId"],
                                    freekm: vehicle["freeKm"].toString(),
                                    freehr: vehicle["freeHr"].toString(),
                                    mobilenum: vehicle["mobileNo"],
                                    vehnumber: vehicle["vehicleNo"],
                                    // vehicleFrontPath
                                    vehiclefrontphotopath:
                                        vehicle["vehicleFrontPath"],
                                    vehiclebackphotopath:
                                        vehicle["vehicleBackPath"],
                                  );
                                },
                              );
                            } else if (filteredVehicles.isEmpty) {
                              return const Center(
                                  child: Text('No vehicles available'));
                            } else {
                              return ListView.builder(
                                itemCount: filteredVehicles.length,
                                itemBuilder: (context, index) {
                                  final vehicle = filteredVehicles[index];
                                  return BookingContainer(
                                    From: vehicle["fromAddress"].toString(),
                                    vehiclename:
                                        vehicle["vehicleAvailable"].toString(),
                                    ownername:
                                        vehicle["customerName"].toString(),
                                    toaddres: vehicle["toAddress"].toString(),
                                    availStatus:
                                        vehicle["availStatus"].toString(),
                                    date: vehicle["date"].toString(),
                                    typeofvehicle:
                                        vehicle["vehicleAvailable"].toString(),
                                    transportname:
                                        vehicle["transportName"].toString(),
                                    rate: vehicle["rate"].toString(),
                                    vehicledetails:
                                        vehicle["vehicleDetails"].toString(),
                                    supplyid: vehicle["supplyId"],
                                    typeOfVehicle:
                                        vehicle["typeOfVehicle"].toString(),
                                    ruid: vehicle["uId"],
                                    freekm: vehicle["freeKm"].toString(),
                                    freehr: vehicle["freeHr"].toString(),
                                    mobilenum: vehicle["mobileNo"],
                                    vehnumber: vehicle["vehicleNo"],
                                    vehiclefrontphotopath:
                                        vehicle["vehicleFrontPath"],
                                    vehiclebackphotopath:
                                        vehicle["vehicleBackPath"],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData2,
                    child: FutureBuilder(
                      future: myController.fetchData(2),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Obx(() {
                            final selectedValue =
                                selectedDropdownItem?.toLowerCase();

                            final filteredVehicles = myController.vehicles
                                .where((vehicle) =>
                                    vehicle["vehicleTypeId"].toString() ==
                                    selectedValue)
                                .toList();

                            if (selectedValue == "0") {
                              return ListView.builder(
                                itemCount: myController.vehicles.length,
                                itemBuilder: (context, index) {
                                  final vehicle = myController.vehicles[index];
                                  return BookingContainer(
                                    From: vehicle["fromAddress"].toString(),
                                    vehiclename:
                                        vehicle["vehicleAvailable"].toString(),
                                    ownername:
                                        vehicle["customerName"].toString(),
                                    toaddres: vehicle["toAddress"].toString(),
                                    availStatus:
                                        vehicle["availStatus"].toString(),
                                    date: vehicle["date"].toString(),
                                    typeofvehicle:
                                        vehicle["vehicleAvailable"].toString(),
                                    transportname:
                                        vehicle["transportName"].toString(),
                                    rate: vehicle["rate"].toString(),
                                    vehicledetails:
                                        vehicle["vehicleDetails"].toString(),
                                    supplyid: vehicle["supplyId"],
                                    typeOfVehicle:
                                        vehicle["typeOfVehicle"].toString(),
                                    ruid: vehicle["uId"],
                                    freekm: vehicle["freeKm"].toString() == ""
                                        ? "0"
                                        : vehicle["freeKm"].toString(),
                                    freehr: vehicle["freeHr"].toString() == ""
                                        ? "0"
                                        : vehicle["freeHr"].toString(),
                                    mobilenum: vehicle["mobileNo"],
                                    vehnumber: vehicle["vehicleNo"],
                                    vehiclefrontphotopath:
                                        vehicle["vehicleFrontPath"],
                                    vehiclebackphotopath:
                                        vehicle["vehicleBackPath"],
                                  );
                                },
                              );
                            } else if (filteredVehicles.isEmpty) {
                              return const Center(
                                  child: Text('No vehicles available'));
                            } else {
                              return ListView.builder(
                                itemCount: filteredVehicles.length,
                                itemBuilder: (context, index) {
                                  final vehicle = filteredVehicles[index];
                                  return BookingContainer(
                                    From: vehicle["fromAddress"].toString(),
                                    vehiclename:
                                        vehicle["vehicleAvailable"].toString(),
                                    ownername:
                                        vehicle["customerName"].toString(),
                                    toaddres: vehicle["toAddress"].toString(),
                                    availStatus:
                                        vehicle["availStatus"].toString(),
                                    date: vehicle["date"].toString(),
                                    typeofvehicle:
                                        vehicle["vehicleAvailable"].toString(),
                                    transportname:
                                        vehicle["transportName"].toString(),
                                    rate: vehicle["rate"].toString(),
                                    vehicledetails:
                                        vehicle["vehicleDetails"].toString(),
                                    supplyid: vehicle["supplyId"],
                                    typeOfVehicle:
                                        vehicle["typeOfVehicle"].toString(),
                                    ruid: vehicle["uId"],
                                    freekm: vehicle["freeKm"].toString() == ""
                                        ? "0"
                                        : vehicle["freeKm"].toString(),
                                    freehr: vehicle["freeHr"].toString() == ""
                                        ? "0"
                                        : vehicle["freeKm"].toString(),
                                    mobilenum: vehicle["mobileNo"],
                                    vehnumber: vehicle["vehicleNo"].toString(),
                                    vehiclefrontphotopath:
                                        vehicle["vehicleFrontPath"],
                                    vehiclebackphotopath:
                                        vehicle["vehicleBackPath"],
                                  );
                                },
                              );
                            }
                          });
                        }
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class DropdownItem {
  final String text;
  final String imagePath;
  final String idvehicel;
  DropdownItem(
      {required this.text, required this.imagePath, required this.idvehicel});
  @override
  String toString() {
    return text;
  }
}
