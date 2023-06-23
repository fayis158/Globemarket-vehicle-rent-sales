// ignore_for_file: unrelated_type_equality_checks

import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/rent/rent.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
// Replace with the correct path to your ApiController

import '../../../../Screens/Drawer_inside_pages/Buy_gps/buy_gps.dart';
import '../../../../Screens/Home_page/Home_page.dart';
import '../../../../Screens/more_in_tabbar.dart/More.dart';
import '../../Supply/Supply.dart';
import '../subscription/subscription.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Add_my_vehicle_from_edit extends StatefulWidget {
  Add_my_vehicle_from_edit(
      {super.key,
      required this.fromcityedit,
      required this.tocity,
      required this.transportname,
      required this.name,
      required this.vehiclenum,
      required this.vehicledetails,
      required this.vehicletypeid,
      required this.supplyid});
  String fromcityedit;
  String tocity;
  String transportname;
  String name;
  String vehiclenum;
  String vehicledetails;
  int vehicletypeid;
  int supplyid;
  @override
  State<Add_my_vehicle_from_edit> createState() =>
      _Add_my_vehicle_from_editState();
}

class _Add_my_vehicle_from_editState extends State<Add_my_vehicle_from_edit> {
  Uint8List? _file;
  final ApiController anotherPageController = Get.put(ApiController());
  // final dateTimePickerController = Get.put(DateTimePickerController());

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);
                  if (result == null) return;

                  // final file = result.files.first;
                  // openFile(file);
                  openFiles(result.files);
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilesPage(files: files, onOpenedFile: openFile),
        ),
      );

  void openFile(PlatformFile file) {
    // OpenFile.open(file.path!);
  }

  // bool _isPassengerSelected = false;
  // String _selectedVehicle = "Truck";

  DateTime datetime2 = DateTime.now();
  bool _isLoadingSelected = false;
  DropdownItem? selectedItem;
  DropdownItem? selectedItem2;

  //Passengers
  List<DropdownItem> items = [
    DropdownItem(
      text: 'Auto',
      imagePath: 'rentimages/auto.zip',
    ),
    DropdownItem(text: '2 wheeler', imagePath: 'rentimages/twowheeler.png'),
    DropdownItem(
        text: 'seden car(4-5 seats)', imagePath: 'rentimages/sedan.png'),
    DropdownItem(
        text: 'Luxury Car(5-6 seats)', imagePath: 'rentimages/luxurycar.png'),
    DropdownItem(text: 'SUV (6-9 seats)', imagePath: 'rentimages/suv.png'),
    DropdownItem(
        text: 'Tempo Traveller(9-16 seats)',
        imagePath: 'rentimages/traveller.png'),
    DropdownItem(
        text: 'Mini Bus(16-39 seats)', imagePath: 'rentimages/minibus.png'),
    DropdownItem(
        text: 'Big Bus (39-54 seats)', imagePath: 'rentimages/bigbus.png'),
    DropdownItem(text: 'Ambulance', imagePath: 'rentimages/ambulance.png'),
  ];

  //Loading
  List<DropdownItem> itemsloading = [
    DropdownItem(
        text: 'Tempoo  (3-4 Wheeler 300kg-1 Ton)',
        imagePath: 'rentimages/tempoo.png'),
    DropdownItem(
        text: 'Bolero  (4 wheeeler) 1.5 Ton',
        imagePath: 'rentimages/bolero.png'),
    DropdownItem(
        text: 'Tata 407 (4 wheeeler 2.5 Ton)',
        imagePath: 'rentimages/tata407.png'),
    DropdownItem(
        text: 'Truck (14 FT 4 Ton)', imagePath: 'rentimages/truck14.png'),
    DropdownItem(text: 'Truck (17 FT 5 Ton)', imagePath: 'rentimages/17ft.png'),
    DropdownItem(
        text: 'Truck (19 FT 6-9 Ton)', imagePath: 'rentimages/19ft.png'),
    DropdownItem(
        text: 'Truck (6 TYPE 9-12 Ton)', imagePath: 'rentimages/6type.png'),
    DropdownItem(
        text: 'Truck (10 TYPE 16-20 Ton)', imagePath: 'rentimages/1620t.png'),
    DropdownItem(
        text: 'Truck (12 TYPE 21-25 Ton)', imagePath: 'rentimages/12type.png'),
    DropdownItem(
        text: 'Truck (14 TYPE 25-30 Ton)', imagePath: 'rentimages/14type.png'),
    DropdownItem(
        text: 'Truck (16 TYPE 31-34 Ton)', imagePath: 'rentimages/16.png'),
    DropdownItem(
        text: 'Truck (18 TYPE 35-38 Ton)', imagePath: 'rentimages/18.png'),
    DropdownItem(
        text: 'Truck (22 TYPE 38-42 Ton)', imagePath: 'rentimages/22.png'),
    DropdownItem(
        text: 'Trailer (High Bed 20-50 Ton)',
        imagePath: 'rentimages/highbed.png'),
    DropdownItem(
        text: 'Trailer (Flat Bed 20-50 Ton)',
        imagePath: 'rentimages/flatbed.png'),
    DropdownItem(
        text: 'Trailer (Semi Bed 20-50 Ton)',
        imagePath: 'rentimages/semibed.png'),
    DropdownItem(
        text: 'Container (20 FT 5-10 Ton)',
        imagePath: 'rentimages/510container.png'),
    DropdownItem(
        text: 'Container (24 FT 9-14 Ton)', imagePath: 'rentimages/914.png'),
    DropdownItem(
        text: 'Container (32 FT 7-20 Ton)', imagePath: 'rentimages/32.png'),
    DropdownItem(text: 'Container (33 FT)', imagePath: 'rentimages/32ft.png'),
    DropdownItem(
        text: 'Container (Above 33 FT)', imagePath: 'rentimages/33ft.png'),
    DropdownItem(text: 'Crane', imagePath: 'rentimages/crane.png'),
    DropdownItem(text: 'Tipper', imagePath: 'rentimages/tipper.png'),
    DropdownItem(text: 'Tanker', imagePath: 'rentimages/tanker.png'),
    DropdownItem(text: 'refrigerator', imagePath: 'rentimages/ref.png'),
    DropdownItem(text: 'Tractor', imagePath: 'rentimages/tract.png'),
    DropdownItem(text: 'JCB', imagePath: 'rentimages/jcb.png'),
    DropdownItem(
        text: 'Packers And Movers', imagePath: 'rentimages/pakmov.png'),
    DropdownItem(
        text: 'Brokers And transporters', imagePath: 'rentimages/co.png'),
    DropdownItem(text: 'Hitachi', imagePath: 'rentimages/hitachi.png'),
    DropdownItem(text: 'Courier', imagePath: 'images/bell1.png'),
  ];

  String available = DateTime.now().toString();
  int vehicletype = 1;
  int typeofvehicle = 1;
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController transportnamecontroller = TextEditingController();
  TextEditingController customernamecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController vehicledetailscontoller = TextEditingController();
  TextEditingController vehiclenumbercontoller = TextEditingController();
  TextEditingController freekm = TextEditingController();
  TextEditingController freehr = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  DateTime selectedDateTime2 = DateTime.now();
  final ApiT myController = Get.put(ApiT());

  int getusercount = 0;
  int limitedcount = 0;
  @override
  void initState() {
    super.initState();
    // getcount();
    globefromcityedit = widget.fromcityedit;
    globeltocityedit = widget.tocity;
    transportnamecontroller = TextEditingController(text: widget.transportname);
    customernamecontroller = TextEditingController(text: widget.name);
    vehiclenumbercontoller = TextEditingController(text: widget.vehiclenum);
    vehicledetailscontoller =
        TextEditingController(text: widget.vehicledetails);

    _isLoadingSelected = widget.vehicletypeid > 9 ? true : false;
    typeofvehicle = widget.vehicletypeid > 9 ? 2 : 1;
    vehicletype = widget.vehicletypeid;

    int selectedItemId = widget.vehicletypeid;
    int defaultItemId = items.length - 1; // Set the default item index

    if (selectedItemId <= 9) {
      for (int i = 0; i < items.length; i++) {
        if (selectedItemId == i + 1) {
          selectedItem = items[i];

          break;
        }
      }
    } else {
      for (int i = 0; i < itemsloading.length; i++) {
        if (selectedItemId == 10 + i) {
          selectedItem2 = itemsloading[i];
          break;
        }
      }
    }
  }

  // getcount() {
  //   getusercount = myController.getcountuser.toInt();
  //   limitedcount = myController.gettotalcountuser.toInt();
  // }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // Process the picked image
      // e.g., upload to server or display in UI
      // You can access the image using pickedImage.path
    } else {
      // User canceled the picker
    }
  }

  void showAlertDialog() {
    Get.defaultDialog(
      title: "Your Free Limit is over",
      middleText: "Subscribe for more",
      textConfirm: 'Pay',
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        Get.to(const SubscribeT());
      },
      textCancel: 'OK',
      onCancel: () {
        Get.back(closeOverlays: true);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    ratecontroller.dispose();
    transportnamecontroller.dispose();
    customernamecontroller.dispose();
    mobilenumbercontroller.dispose();
    vehicledetailscontoller.dispose();
    vehiclenumbercontoller.dispose();
    freekm.dispose();
    freehr.dispose();
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


// Parse the string into a DateTime object

  // datevalidity() {
  //   String dateString = expiredate;
  //   DateFormat format = DateFormat('dd-MMM-yyyy hh:mm:ss a');
  //   DateTime date = format.parse(dateString);
  //   DateTime currentDate = DateTime.now();
  //   // DateTime validityDate = currentDate.add(Duration(days: 30));

  //   if (date.isBefore(currentDate)) {
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 38, 36),
          title: const Text("Add Vehicle For Rent"),
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
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  const Center(
                      child: Text(
                    "Post your vehicle Availability",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLoadingSelected = false;
                            // _isPassengerSelected = true;
                            typeofvehicle = 1;

                            selectedItem = null;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: _isLoadingSelected == false
                                ? Colors.green
                                : Colors.grey,
                          ),
                          child: const Center(
                              child: Text("Passenger",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLoadingSelected = true;

                            typeofvehicle = 2;

                            selectedItem2 = null;
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: _isLoadingSelected == true
                                ? Colors.green
                                : Colors.grey,
                          ),
                          child: const Center(
                              child: Text(
                            "Loading",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 500,
                    // color: Colors.red,
                    child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: _isLoadingSelected == false
                            ? DropdownButtonFormField<DropdownItem>(
                                menuMaxHeight: 400,
                                decoration: const InputDecoration(
                                  enabled: false,
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedItem,
                                hint: const Text('Select an Vehicle Type'),
                                onChanged: null,
                                // onChanged: (DropdownItem? value) {
                                //   selectedItem = value;

                                //   vehicletype = selectedItem.toString() ==
                                //           'Auto'
                                //       ? 1
                                //       : selectedItem.toString() == "2 wheeler"
                                //           ? 2
                                //           : selectedItem.toString() ==
                                //                   "seden car(4-5 seats)"
                                //               ? 3
                                //               : selectedItem.toString() ==
                                //                       "Luxury Car(5-6 seats)"
                                //                   ? 4
                                //                   : selectedItem.toString() ==
                                //                           "SUV (6-9 seats)"
                                //                       ? 5
                                //                       : selectedItem
                                //                                   .toString() ==
                                //                               "Tempo Traveller(9-16 seats)"
                                //                           ? 6
                                //                           : selectedItem
                                //                                       .toString() ==
                                //                                   "Mini Bus(16-39 seats)"
                                //                               ? 7
                                //                               : selectedItem
                                //                                           .toString() ==
                                //                                       "Big Bus (39-54 seats)"
                                //                                   ? 8
                                //                                   : selectedItem
                                //                                               .toString() ==
                                //                                           "Ambulance"
                                //                                       ? 9
                                //                                       : 120;

                                //   setState(() {});
                                // },
                                items: items.map((DropdownItem item) {
                                  return DropdownMenuItem<DropdownItem>(
                                    value: item,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          item.imagePath,
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(item.text),
                                      ],
                                    ),
                                  );
                                }).toList())
                            : DropdownButtonFormField<DropdownItem>(
                                menuMaxHeight: 400,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedItem2,
                                hint: const Text('Select an Vehicle Type'),
                                onChanged: null,
                                // onChanged: (DropdownItem? value2) {
                                //   selectedItem2 = value2;
                                //   vehicletype = selectedItem2.toString() ==
                                //           'Tempoo  (3-4 Wheeler 300kg-1 Ton)'
                                //       ? 10
                                //       : selectedItem2.toString() ==
                                //               "Bolero  (4 wheeeler) 1.5 Ton"
                                //           ? 11
                                //           : selectedItem2.toString() ==
                                //                   "Tata 407 (4 wheeeler 2.5 Ton)"
                                //               ? 12
                                //               : selectedItem2.toString() ==
                                //                       "Truck (14 FT 4 Ton)"
                                //                   ? 13
                                //                   : selectedItem2.toString() ==
                                //                           "Truck (17 FT 5 Ton)"
                                //                       ? 14
                                //                       : selectedItem2
                                //                                   .toString() ==
                                //                               "Truck (19 FT 6-9 Ton)"
                                //                           ? 15
                                //                           : selectedItem2
                                //                                       .toString() ==
                                //                                   "Truck (6 TYPE 9-12 Ton)"
                                //                               ? 16
                                //                               : selectedItem2
                                //                                           .toString() ==
                                //                                       "Truck (10 TYPE 16-20 Ton)"
                                //                                   ? 17
                                //                                   : selectedItem2
                                //                                               .toString() ==
                                //                                           "Truck (12 TYPE 21-25 Ton)"
                                //                                       ? 18
                                //                                       : selectedItem2.toString() ==
                                //                                               "Truck (14 TYPE 25-30 Ton)"
                                //                                           ? 19
                                //                                           : selectedItem2.toString() == "Truck (16 TYPE 31-34 Ton)"
                                //                                               ? 20
                                //                                               : selectedItem2.toString() == "Truck (18 TYPE 35-38 Ton)"
                                //                                                   ? 21
                                //                                                   : selectedItem2.toString() == "Truck (22 TYPE 38-42 Ton)"
                                //                                                       ? 22
                                //                                                       : selectedItem2.toString() == "Trailer (High Bed 20-50 Ton)"
                                //                                                           ? 23
                                //                                                           : selectedItem2.toString() == "Trailer (Flat Bed 20-50 Ton)"
                                //                                                               ? 24
                                //                                                               : selectedItem2.toString() == "Trailer (Semi Bed 20-50 Ton)"
                                //                                                                   ? 25
                                //                                                                   : selectedItem2.toString() == "Container (20 FT 5-10 Ton)"
                                //                                                                       ? 26
                                //                                                                       : selectedItem2.toString() == "Container (24 FT 9-14 Ton)"
                                //                                                                           ? 27
                                //                                                                           : selectedItem2.toString() == "Container (32 FT 7-20 Ton)"
                                //                                                                               ? 28
                                //                                                                               : selectedItem2.toString() == "Container (33 FT)"
                                //                                                                                   ? 29
                                //                                                                                   : selectedItem2.toString() == "Container (Above 33 FT)"
                                //                                                                                       ? 30
                                //                                                                                       : selectedItem2.toString() == "Crane"
                                //                                                                                           ? 31
                                //                                                                                           : selectedItem2.toString() == "Tipper"
                                //                                                                                               ? 32
                                //                                                                                               : selectedItem2.toString() == "Tanker"
                                //                                                                                                   ? 33
                                //                                                                                                   : selectedItem2.toString() == "refrigerator"
                                //                                                                                                       ? 34
                                //                                                                                                       : selectedItem2.toString() == "Tractor"
                                //                                                                                                           ? 35
                                //                                                                                                           : selectedItem2.toString() == "JCB"
                                //                                                                                                               ? 36
                                //                                                                                                               : selectedItem2.toString() == "Packers And Movers"
                                //                                                                                                                   ? 37
                                //                                                                                                                   : selectedItem2.toString() == "Brokers And transporters"
                                //                                                                                                                       ? 38
                                //                                                                                                                       : selectedItem2.toString() == "Hitachi"
                                //                                                                                                                           ? 39
                                //                                                                                                                           : selectedItem2.toString() == "Courier"
                                //                                                                                                                               ? 40
                                //                                                                                                                               : 120;

                                //   setState(() {});
                                // },
                                items: itemsloading.map((DropdownItem item2) {
                                  return DropdownMenuItem<DropdownItem>(
                                    value: item2,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          item2.imagePath,
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(item2.text),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              )),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Select_Cityedit(
                                      title: "Search the city",
                                    )));
                      },
                      child: Container(
                        // height: 60,
                        width: width(context),
                        color: const Color.fromARGB(255, 101, 93, 100),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "From",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                globefromcityedit ?? "Select from city",
                                // widget.fromcity??"Select from city",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Select_CityToedit(
                                      title: "Search the city",
                                    )));
                      },
                      child: Container(
                        // height: 60,
                        width: width(context),
                        color: const Color.fromARGB(255, 101, 93, 100),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                "To ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                globeltocityedit ?? "Select to city",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      controller: transportnamecontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: _isLoadingSelected == false
                            ? 'Travelers name (Not editable)'
                            : "Transporters Name (Not editable) ",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the field';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      maxLength: 25,
                      controller: customernamecontroller,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: 'Name (Not editable)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the field';
                        }
                        return null;
                      },
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     controller: customernamecontroller,
                  //     decoration: InputDecoration(
                  //       contentPadding: const EdgeInsets.symmetric(
                  //           horizontal: 8.0, vertical: 8),
                  //       labelText: '  Name',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please Enter the field';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(
                  //     maxLength: 10,
                  //     onChanged: (value) {
                  //       setState(() {});
                  //     },
                  //     controller: mobilenumbercontroller,
                  //     keyboardType: TextInputType.number,
                  //     decoration: InputDecoration(
                  //       prefix: const Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 8),
                  //         child: Text(
                  //           '(+91)',
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       ),
                  //       suffixIcon: mobilenumbercontroller.text.length == 10
                  //           ? const Icon(
                  //               Icons.check_circle,
                  //               color: Colors.green,
                  //               size: 20,
                  //             )
                  //           : const Icon(
                  //               Icons.check_circle,
                  //               color: Color.fromARGB(255, 47, 47, 47),
                  //               size: 20,
                  //             ),
                  //       contentPadding: const EdgeInsets.symmetric(
                  //           horizontal: 8.0, vertical: 8),
                  //       labelText: '  Mobile Number',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //         borderSide: const BorderSide(
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value == null || value.isEmpty) {
                  //         return 'Please Enter the field';
                  //       }
                  //       return null;
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      maxLength: 11,
                      controller: vehiclenumbercontoller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: '  Vehicle Number (Not editable)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLength: 8,
                      keyboardType: TextInputType.number,
                      controller: ratecontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: ' Minimum Charge (RS)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(
                          width: 5), // Adjust the spacing between fields
                      Expanded(
                        child: TextFormField(
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          controller: freekm,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            labelText: ' Free Km',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: 6), // Adjust the spacing between fields
                      Expanded(
                        child: TextFormField(
                          maxLength: 8,
                          keyboardType: TextInputType.number,
                          controller: freehr,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            labelText: ' Free Hr',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      maxLines: 3,
                      controller: vehicledetailscontoller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText:
                            '  vehicle Details(Capcity , Size etc..) (Not Editable)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter the field';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   // width: width(context) * 0.3,
                        //   child: Text("Available Now",
                        //       style: TextStyle(
                        //           color: Color.fromARGB(255, 98, 145, 98),
                        //           fontWeight: FontWeight.bold)),
                        // ),
                        // MaterialButton(
                        //   minWidth: width(context) * 0.9,
                        //   height: 55,
                        //   color: const Color.fromARGB(255, 30, 102, 32),
                        //   onPressed: () async {
                        //     if (_form.currentState!.validate()) {
                        //       available = DateTime.now().toString();

                        //       // getusercount = myController.getcountuser.toInt();
                        //       // limitedcount =
                        //       //     myController.gettotalcountuser.toInt();
                        //       // myController.counttouchbyuser(1);

                        //       // await myController.getUserTouchCount();

                        //       // (selectedItem2 == null && selectedItem == null) ||

                        //       globefromcityedit == null ||
                        //               globeltocityedit == null
                        //           ? Get.showSnackbar(const GetSnackBar(
                        //               backgroundColor: Colors.red,
                        //             ))
                        //           : anotherPageController
                        //               .callpostaddvehicleSupply(
                        //                   vehicletype,
                        //                   globefromcityedit,
                        //                   globeltocityedit,
                        //                   typeofvehicle,
                        //                   ratecontroller.text,
                        //                   freekm.text,
                        //                   freehr.text,
                        //                   transportnamecontroller.text,
                        //                   customernamecontroller.text,
                        //                   mobilenumbercontroller.text,
                        //                   vehicledetailscontoller.text,
                        //                   vehiclenumbercontoller.text,
                        //                   available,
                        //                   rentuid);

                        //       Get.back();
                        //     }
                        //   },
                        //   child: const Text(
                        //     "Available Now",
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 255, 255, 255)),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 8,
                        // ),
                        Column(
                          children: [
                            const Text("Select Date"),
                            MaterialButton(
                              minWidth: width(context) * 0.9,
                              height: 55,
                              color: const Color.fromARGB(255, 1, 124, 11),
                              onPressed: () {
                                //         String dateString = expiredate;
                                // DateFormat format =
                                //     DateFormat('dd-MMM-yyyy hh:mm:ss a');
                                // DateTime date = format.parse(dateString);
                                // DateTime currentDate = DateTime.now();

                                // dateTimePickerController.openDateTimePicker();
                                // getusercount =
                                //     myController.getcountuser.toInt();
                                // limitedcount =
                                //     myController.gettotalcountuser.toInt();
                                // limitedcount < getusercount
                                //     ? await myController.counttouchbyuser(1)
                                //     : null;
                                // await myController.getUserTouchCount();
                                showDatePicker(
                                  context: context,
                                  initialDate: selectedDateTime2,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.dark().copyWith(
                                        // Customize the colors and styles of the date picker
                                        primaryColor: Colors.teal,
                                        accentColor: Colors.tealAccent,
                                        colorScheme: const ColorScheme.dark(
                                          primary: Colors.teal,
                                          onPrimary: Colors.white,
                                          surface: Colors.teal,
                                          onSurface: Colors.white,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                ).then((selectedDate) {
                                  if (selectedDate != null) {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          selectedDateTime2),
                                    ).then((selectedTime) {
                                      if (selectedTime != null) {
                                        final dateTime = DateTime(
                                          selectedDate.year,
                                          selectedDate.month,
                                          selectedDate.day,
                                          selectedTime.hour,
                                          selectedTime.minute,
                                        );
                                        setState(() {
                                          selectedDateTime2 = dateTime;
                                          available =
                                              selectedDateTime2.toString();
                                        });
                                      }
                                    });
                                  }
                                });

                                // DatePicker.showDateTimePicker(
                                //   theme: const DatePickerTheme(
                                //       backgroundColor:
                                //           Color.fromARGB(255, 152, 152, 156),
                                //       headerColor:
                                //           Color.fromARGB(255, 179, 177, 177)),
                                //   Get.context!,
                                //   currentTime: selectedDateTime2,
                                //   onConfirm: (DateTime dateTime) {
                                //     selectedDateTime2 = dateTime;
                                //     available = selectedDateTime2.toString();
                                //   },
                                // );

                                // Get.back();
                              },
                              child: Text(
                                " ${selectedDateTime2.day.toString()}- ${selectedDateTime2.month.toString().padLeft(2, '0')}-${selectedDateTime2.year.toString()}   ${selectedDateTime2.hour.toString()}:${selectedDateTime2.minute.toString()}:${selectedDateTime2.second.toString()}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            MaterialButton(
                              minWidth: width(context) * 0.9,
                              height: 55,
                              color: const Color.fromARGB(255, 40, 105, 43),
                              onPressed: () async {
                                if (_form.currentState!.validate()) {
                                  // await anotherPageController
                                  //     .cancelrentbooking(widget.supplyid);
                                  // myController.postedbooking();
                                  print(widget.supplyid);

                                  myController.upodateedit(
                                      widget.supplyid,
                                      globefromcityedit,
                                      globeltocityedit,
                                      ratecontroller.text,
                                      freekm.text,
                                      freehr.text,
                                      available);
                                  // available = DateTime.now().toString();

                                  // getusercount = myController.getcountuser.toInt();
                                  // limitedcount =
                                  //     myController.gettotalcountuser.toInt();
                                  // myController.counttouchbyuser(1);

                                  // await myController.getUserTouchCount();

                                  // (selectedItem2 == null && selectedItem == null) ||
                                  //commented for adding
                                  // globefromcityedit == null ||
                                  //         globeltocityedit == null
                                  //     ? Get.showSnackbar(const GetSnackBar(
                                  //         backgroundColor: Colors.red,
                                  //       ))
                                  //     : anotherPageController
                                  //         .callpostaddvehicleSupply(
                                  //             vehicletype,
                                  //             globefromcityedit,
                                  //             globeltocityedit,
                                  //             typeofvehicle,
                                  //             ratecontroller.text,
                                  //             freekm.text,
                                  //             freehr.text,
                                  //             transportnamecontroller.text,
                                  //             customernamecontroller.text,
                                  //             mobilenumbercontroller.text,
                                  //             vehicledetailscontoller.text,
                                  //             vehiclenumbercontoller.text,
                                  //             available,
                                  //             rentuid);
                                  // Get.back();

                                  // await myController.counttouchbyuser(1);
                                  // await myController.getUserTouchCount();
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // const SizedBox(
                  //   height: 16,
                  // ),
                  // const SizedBox(
                  //   height: 12,
                  // ),
                  // Center(
                  //   child: MaterialButton(
                  //     minWidth: width(context) * 0.8,
                  //     height: 50,
                  //     color: Colors.greenAccent,
                  //     child: const Text(
                  //       "Submit",
                  //       style: TextStyle(color: Color.fromARGB(255, 3, 9, 77)),
                  //     ),
                  //     onPressed: () {},
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownItem {
  final String text;
  final String imagePath;

  DropdownItem({required this.text, required this.imagePath});
  @override
  String toString() {
    return text;
  }
}

class DateTimePickerController extends GetxController {
  Rx<DateTime> selectedDateTime = Rx<DateTime>(DateTime.now());

  void openDateTimePicker() {
    DatePicker.showDateTimePicker(
      theme: const DatePickerTheme(
          backgroundColor: Color.fromARGB(255, 152, 152, 156),
          headerColor: Color.fromARGB(255, 179, 177, 177)),
      Get.context!,
      currentTime: selectedDateTime.value,
      onConfirm: (DateTime dateTime) {
        selectedDateTime.value = dateTime;
      },
    );
  }
}

///city

String? globefromcityedit;
String? globeltocityedit;

class Select_Cityedit extends StatefulWidget {
  Select_Cityedit({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_CityeditState createState() => _Select_CityeditState();
}

class _Select_CityeditState extends State<Select_Cityedit> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 38, 36),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: googleAPiKey,
        inputDecoration:
            const InputDecoration(hintText: "Search your location"),
        debounceTime: 800,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // print("placeDetails" + prediction.lng.toString());
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;

          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
          globefromcityedit = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}

//To City

class Select_CityToedit extends StatefulWidget {
  Select_CityToedit({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  _Select_CityToeditState createState() => _Select_CityToeditState();
}

class _Select_CityToeditState extends State<Select_CityToedit> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: googleAPiKey,
        inputDecoration:
            const InputDecoration(hintText: "Search your location"),
        debounceTime: 800,
        countries: ["in", "fr"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          // print("placeDetails" + prediction.lng.toString());
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description!;

          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description!.length));
          globeltocityedit = controller.text;
          Navigator.pop(context);
        },
      ),
    );
  }
}
