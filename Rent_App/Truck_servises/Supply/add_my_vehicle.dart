// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
// import 'package:file_picker/file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/ApiT.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/rent/rent.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:image_picker/image_picker.dart';
// Replace with the correct path to your ApiController
import '../drawer_inside.dart/subscription/subscription.dart';
import 'SelectTheCity.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Add_my_vehicle extends StatefulWidget {
  Add_my_vehicle({
    super.key,
  });

  @override
  State<Add_my_vehicle> createState() => _Add_my_vehicleState();
}

class _Add_my_vehicleState extends State<Add_my_vehicle> {
  Uint8List? _file;
  final ApiController anotherPageController = Get.put(ApiController());
  // final dateTimePickerController = Get.put(DateTimePickerController());

  // _selectImage(BuildContext parentContext) async {
  //   return showDialog(
  //     context: parentContext,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: const Text('Create a Post'),
  //         children: <Widget>[
  //           SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text('Take a photo'),
  //               onPressed: () async {
  //                 Navigator.pop(context);
  //                 Uint8List file = await pickImage(ImageSource.camera);
  //                 setState(() {
  //                   _file = file;
  //                 });
  //               }),
  //           SimpleDialogOption(
  //               padding: const EdgeInsets.all(20),
  //               child: const Text('Choose from Gallery'),
  //               onPressed: () async {
  //                 final result =
  //                     await FilePicker.platform.pickFiles(allowMultiple: true);
  //                 if (result == null) return;

  //                 // final file = result.files.first;
  //                 // openFile(file);
  //                 openFiles(result.files);
  //               }),
  //           SimpleDialogOption(
  //             padding: const EdgeInsets.all(20),
  //             child: const Text("Cancel"),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }

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
  TextEditingController vehiclemodelcontroller = TextEditingController();
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
    getcount();
    // datevalidity();
  }

  getcount() {
    getusercount = myController.getcountuser.toInt();
    limitedcount = myController.gettotalcountuser.toInt();
  }

  // final MyController alertcontroller = Get.put(MyController());

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

  String? base64Image;
  String fileNamefor = "";
  // String base64imageaddress = '';

  // Future<String?> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     final File file = File(image.path);
  //     final List<int> imageBytes = await file.readAsBytes();
  //     base64Image = base64Encode(imageBytes);

  //     // base64imageaddress = base64Image!;

  //     final String fileName = image.path.split('/').last;
  //     fileNamefor = fileName;

  //     Uint8List hi = base64Decode(base64Image!);

  //     setState(() {});
  //     return base64Image;
  //   }
  // }

  Future<ImageData?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final List<int> imageBytes = await file.readAsBytes();
      final String base64Image = base64Encode(imageBytes);

      final String fileName = image.path.split('/').last;

      // Save the image to the desired location
      //  final String fileName = image.path.split('/').last;
      // fileNameforprof = fileName;
      // final String filePath = '/path/to/your/destination/$fileName';
      // final File destinationFile = File(filePath);
      // await destinationFile.writeAsBytes(imageBytes);

      return ImageData(base64Image, fileName);
    }

    return null;
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
    // TODO: implement dispose
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

  //base64 stored here

  String vehbackbase64 = '';
  String vehfrontbase64 = '';
  String adharcard = '';
  String pancard = '';
  String rcbook = '';
  String permit = '';
  String insurance = '';

  // image path stored here

  String vehfronpath = '';
  String vehbackpath = '';
  String adharcardpath = '';
  String pancardpath = '';
  String rcbookpath = '';
  String permitpth = '';
  String insurancepath = '';

  //
  RxBool checkvehexcist = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 38, 36),
          title: const Text("Add Vehicle For Rent"),
        ),
        body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Only One time post  here"),
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
                            // _isPassengerSelected = false;
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
                                  border: OutlineInputBorder(),
                                ),
                                value: selectedItem,
                                hint: const Text('Select an Vehicle Type'),
                                onChanged: (DropdownItem? value) {
                                  selectedItem = value;

                                  vehicletype = selectedItem.toString() ==
                                          'Auto'
                                      ? 1
                                      : selectedItem.toString() == "2 wheeler"
                                          ? 2
                                          : selectedItem.toString() ==
                                                  "seden car(4-5 seats)"
                                              ? 3
                                              : selectedItem.toString() ==
                                                      "Luxury Car(5-6 seats)"
                                                  ? 4
                                                  : selectedItem.toString() ==
                                                          "SUV (6-9 seats)"
                                                      ? 5
                                                      : selectedItem
                                                                  .toString() ==
                                                              "Tempo Traveller(9-16 seats)"
                                                          ? 6
                                                          : selectedItem
                                                                      .toString() ==
                                                                  "Mini Bus(16-39 seats)"
                                                              ? 7
                                                              : selectedItem
                                                                          .toString() ==
                                                                      "Big Bus (39-54 seats)"
                                                                  ? 8
                                                                  : selectedItem
                                                                              .toString() ==
                                                                          "Ambulance"
                                                                      ? 9
                                                                      : 120;

                                  setState(() {});
                                },
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
                                onChanged: (DropdownItem? value2) {
                                  selectedItem2 = value2;
                                  vehicletype = selectedItem2.toString() ==
                                          'Tempoo  (3-4 Wheeler 300kg-1 Ton)'
                                      ? 10
                                      : selectedItem2.toString() ==
                                              "Bolero  (4 wheeeler) 1.5 Ton"
                                          ? 11
                                          : selectedItem2.toString() ==
                                                  "Tata 407 (4 wheeeler 2.5 Ton)"
                                              ? 12
                                              : selectedItem2.toString() ==
                                                      "Truck (14 FT 4 Ton)"
                                                  ? 13
                                                  : selectedItem2.toString() ==
                                                          "Truck (17 FT 5 Ton)"
                                                      ? 14
                                                      : selectedItem2
                                                                  .toString() ==
                                                              "Truck (19 FT 6-9 Ton)"
                                                          ? 15
                                                          : selectedItem2
                                                                      .toString() ==
                                                                  "Truck (6 TYPE 9-12 Ton)"
                                                              ? 16
                                                              : selectedItem2
                                                                          .toString() ==
                                                                      "Truck (10 TYPE 16-20 Ton)"
                                                                  ? 17
                                                                  : selectedItem2
                                                                              .toString() ==
                                                                          "Truck (12 TYPE 21-25 Ton)"
                                                                      ? 18
                                                                      : selectedItem2.toString() ==
                                                                              "Truck (14 TYPE 25-30 Ton)"
                                                                          ? 19
                                                                          : selectedItem2.toString() == "Truck (16 TYPE 31-34 Ton)"
                                                                              ? 20
                                                                              : selectedItem2.toString() == "Truck (18 TYPE 35-38 Ton)"
                                                                                  ? 21
                                                                                  : selectedItem2.toString() == "Truck (22 TYPE 38-42 Ton)"
                                                                                      ? 22
                                                                                      : selectedItem2.toString() == "Trailer (High Bed 20-50 Ton)"
                                                                                          ? 23
                                                                                          : selectedItem2.toString() == "Trailer (Flat Bed 20-50 Ton)"
                                                                                              ? 24
                                                                                              : selectedItem2.toString() == "Trailer (Semi Bed 20-50 Ton)"
                                                                                                  ? 25
                                                                                                  : selectedItem2.toString() == "Container (20 FT 5-10 Ton)"
                                                                                                      ? 26
                                                                                                      : selectedItem2.toString() == "Container (24 FT 9-14 Ton)"
                                                                                                          ? 27
                                                                                                          : selectedItem2.toString() == "Container (32 FT 7-20 Ton)"
                                                                                                              ? 28
                                                                                                              : selectedItem2.toString() == "Container (33 FT)"
                                                                                                                  ? 29
                                                                                                                  : selectedItem2.toString() == "Container (Above 33 FT)"
                                                                                                                      ? 30
                                                                                                                      : selectedItem2.toString() == "Crane"
                                                                                                                          ? 31
                                                                                                                          : selectedItem2.toString() == "Tipper"
                                                                                                                              ? 32
                                                                                                                              : selectedItem2.toString() == "Tanker"
                                                                                                                                  ? 33
                                                                                                                                  : selectedItem2.toString() == "refrigerator"
                                                                                                                                      ? 34
                                                                                                                                      : selectedItem2.toString() == "Tractor"
                                                                                                                                          ? 35
                                                                                                                                          : selectedItem2.toString() == "JCB"
                                                                                                                                              ? 36
                                                                                                                                              : selectedItem2.toString() == "Packers And Movers"
                                                                                                                                                  ? 37
                                                                                                                                                  : selectedItem2.toString() == "Brokers And transporters"
                                                                                                                                                      ? 38
                                                                                                                                                      : selectedItem2.toString() == "Hitachi"
                                                                                                                                                          ? 39
                                                                                                                                                          : selectedItem2.toString() == "Courier"
                                                                                                                                                              ? 40
                                                                                                                                                              : 120;

                                  setState(() {});
                                },
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
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    vehfrontbase64 = base64Image.base64!;
                                    vehfronpath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: vehfronpath == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                vehfrontbase64)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "Add Vehicle Front Photo",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  // final String? base64Image = await pickImage();

                                  // if (base64Image != null) {
                                  //   String base64imageaddress = base64Image;
                                  //   // String hi = base64Decode(base64Image) as String;
                                  //   vehbackbase64 = base64imageaddress;
                                  // } else {
                                  //   print('Image picking canceled or failed.');
                                  // }
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    vehbackbase64 = base64Image.base64!;
                                    vehbackpath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                  // alertcontroller.showMyDialog();
                                },
                                child: vehbackpath == ''
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                vehbackbase64)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "Add Vehicle Back Photo",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
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
                                builder: (context) => Select_City(
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
                                globefromcity ?? "Select from city",
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
                                builder: (context) => Select_CityTo(
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
                                globeltocity ?? "Select to city",
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
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                        // FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                      ],
                      controller: transportnamecontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: _isLoadingSelected == false
                            ? 'Travelers name'
                            : "Transporters Name",
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
                      controller: customernamecontroller,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(25),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\s]')),
                      ],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: 'Name',
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
                      // maxLength: 11,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      // maxLengthEnforcement:false,
                      controller: vehiclenumbercontoller,
                      onChanged: (value) async {
                        await myController
                            .checkexcistingveh(vehiclenumbercontoller.text);
                        checkvehexcist = await myController.checkvehexcist;

                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: '  Vehicle Number',
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
                  checkvehexcist == false
                      ? const SizedBox()
                      : const Text(
                          "Vehicle already exist",
                          style: TextStyle(color: Colors.red),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(9),
                      ],
                      controller: vehiclemodelcontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: '  Vehicle Type(model)',
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
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // const SizedBox(
                        //     width: 5), // Adjust the spacing between fields
                        Expanded(
                          child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(8),
                            ],
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      maxLines: 3,
                      controller: vehicledetailscontoller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: '  vehicle Details(Capcity , Size etc..)',
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
                  const Text("      Upload Your Documents"),
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      runSpacing: 30,
                      spacing: 12,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    adharcard = base64Image.base64!;
                                    adharcardpath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: adharcardpath == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                adharcard)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const Text("Adhaar")
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  // final String? base64Image = await pickImage();

                                  // if (base64Image != null) {
                                  //   String base64imageaddress = base64Image;
                                  //   // String hi = base64Decode(base64Image) as String;
                                  //   pancard = base64imageaddress;
                                  // } else {
                                  //   print('Image picking canceled or failed.');
                                  // }
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    pancard = base64Image.base64!;
                                    pancardpath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: pancardpath == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                pancard)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const Text("Pan card")
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  // final String? base64Image = await pickImage();

                                  // if (base64Image != null) {
                                  //   String base64imageaddress = base64Image;
                                  //   // String hi = base64Decode(base64Image) as String;
                                  //   rcbook = base64imageaddress;
                                  //   print(rcbook);
                                  // } else {
                                  //   print('Image picking canceled or failed.');
                                  // }
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    rcbook = base64Image.base64!;
                                    rcbookpath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: rcbookpath == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                rcbook)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const Text("RC book")
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  // final String? base64Image = await pickImage();

                                  // if (base64Image != null) {
                                  //   String base64imageaddress = base64Image;
                                  //   // String hi = base64Decode(base64Image) as String;
                                  //   permit = base64imageaddress;
                                  //   print(permit);
                                  // } else {
                                  //   print('Image picking canceled or failed.');
                                  // }
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    permit = base64Image.base64!;
                                    permitpth = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: permitpth == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                permit)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const Text("Permit")
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                onTap: () async {
                                  // final String? base64Image = await pickImage();

                                  // if (base64Image != null) {
                                  //   String base64imageaddress = base64Image;
                                  //   // String hi = base64Decode(base64Image) as String;
                                  //   insurance = base64imageaddress;
                                  //   print(insurance);
                                  // } else {
                                  //   print('Image picking canceled or failed.');
                                  // }
                                  ImageData? base64Image = await pickImage();
                                  vehfronpath = base64Image!.filePath!;
                                  if (base64Image != null) {
                                    insurance = base64Image.base64!;
                                    insurancepath = base64Image.filePath!;
                                  }
                                  setState(() {});
                                },
                                child: insurancepath == ""
                                    ? Container(
                                        height: 50,
                                        width: 50,
                                        color: const Color.fromARGB(
                                            255, 110, 96, 95),
                                        child: const Center(
                                            child: Text(
                                          "+",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      )
                                    : Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 110, 96, 95),
                                          image: DecorationImage(
                                            image: MemoryImage(base64Decode(
                                                insurance)), // Provide the base64 string here
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )),
                            const Text("Insurance")
                          ],
                        ),
                      ],
                    ),
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

                        //       globefromcity == null || globeltocity == null
                        //           ? Get.showSnackbar(const GetSnackBar(
                        //               backgroundColor: Colors.red,
                        //             ))
                        //           : anotherPageController
                        //               .callpostaddvehicleSupply(
                        //                   vehicletype,
                        //                   globefromcity,
                        //                   globeltocity,
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
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            MaterialButton(
                              minWidth: width(context) * 0.9,
                              height: 55,
                              color: const Color.fromARGB(255, 18, 101, 26),
                              onPressed: () async {
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
                                //     selectedItem2 == null &&
                                //             globefromcity == null &&
                                //             globeltocity == null
                                //         ? Get.snackbar(
                                //             backgroundColor: Colors.black,
                                //             titleText: const Text(
                                //               "Note:-",
                                //               style: TextStyle(
                                //                   color: Color.fromARGB(
                                //                       255, 255, 255, 255),
                                //                   fontWeight:
                                //                       FontWeight.bold),
                                //             ),
                                //             messageText: const Text(
                                //               "Please Choose  from,to locations and Vehicle Type",
                                //               style: TextStyle(
                                //                 color: Color.fromARGB(
                                //                     255, 255, 255, 255),
                                //               ),
                                //             ),
                                //             "",
                                //             "",
                                //           )
                                //         : anotherPageController
                                //             .callpostaddvehicleSupply(
                                //                 vehicletype,
                                //                 globefromcity,
                                //                 globeltocity,
                                //                 typeofvehicle,
                                //                 ratecontroller.text,
                                //                 freekm.text,
                                //                 freehr.text,
                                //                 transportnamecontroller.text,
                                //                 customernamecontroller.text,
                                //                 mobilenumbercontroller.text,
                                //                 vehicledetailscontoller.text,
                                //                 vehiclenumbercontoller.text,
                                //                 selectedDateTime2.toString(),
                                //                 rentuid);
                                //   },
                                // );
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

                                await myController.counttouchbyuser(1);
                                await myController.getUserTouchCount();
                                // Get.back();
                              },
                              child: Text(
                                " ${selectedDateTime2.day.toString()}- ${selectedDateTime2.month.toString().padLeft(2, '0')}-${selectedDateTime2.year.toString()}   ${selectedDateTime2.hour.toString()}:${selectedDateTime2.minute.toString()}:${selectedDateTime2.second.toString()}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        MaterialButton(
                          minWidth: width(context) * 0.9,
                          height: 55,
                          color: const Color.fromARGB(255, 30, 102, 32),
                          onPressed: () async {
                            // available = DateTime.now().toString();

                            // getusercount = myController.getcountuser.toInt();
                            // limitedcount =
                            //     myController.gettotalcountuser.toInt();
                            // myController.counttouchbyuser(1);

                            // await myController.getUserTouchCount();

                            // (selectedItem2 == null && selectedItem == null) ||

                            ///     vehiclemodel,
                            //  aadharcard,
                            //  pancard,
                            //  rcbook,
                            //  permit,
                            //  insurance,
                            //  vehfrontphoto,
                            // vehbackphoto,
                            // aadharpath,
                            // pancardpath,
                            // rcbookpath,
                            // permitpath,
                            // insurancepath,
                            // vehfrontpath,
                            // vehbackpath,

                            if (checkvehexcist == false) {
                              if (_form.currentState!.validate()) {
                                globefromcity == null ||
                                        globeltocity == null ||
                                        adharcardpath == "" ||
                                        pancardpath == "" ||
                                        rcbookpath == "" ||
                                        permitpth == "" ||
                                        insurancepath == '' ||
                                        vehfronpath == "" ||
                                        vehbackpath == ""
                                    ? Get.dialog(
                                        AlertDialog(
                                          title: const Text('Uncomplete'),
                                          content: const Text(
                                              'Please Complete all the field to proceed ,'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Close the dialog
                                                Get.back();
                                              },
                                              child: const Text('Close'),
                                            ),
                                          ],
                                        ),
                                      )
                                    : anotherPageController
                                        .callpostaddvehicleSupply(
                                            vehicletype,
                                            globefromcity,
                                            globeltocity,
                                            typeofvehicle,
                                            ratecontroller.text,
                                            freekm.text,
                                            freehr.text,
                                            transportnamecontroller.text,
                                            customernamecontroller.text,
                                            mobilenumbercontroller.text,
                                            vehicledetailscontoller.text,
                                            vehiclenumbercontoller.text,
                                            available,
                                            rentuid,
                                            vehiclemodelcontroller.text,
                                            adharcard,
                                            pancard,
                                            rcbook,
                                            permit,
                                            insurance,
                                            vehfrontbase64,
                                            vehbackbase64,
                                            adharcardpath,
                                            pancardpath,
                                            rcbookpath,
                                            permitpth,
                                            insurancepath,
                                            vehfronpath,
                                            vehbackpath);

                                globefromcity == null ||
                                        globeltocity == null ||
                                        adharcardpath == "" ||
                                        pancardpath == "" ||
                                        rcbookpath == "" ||
                                        permitpth == "" ||
                                        insurancepath == '' ||
                                        vehfronpath == "" ||
                                        vehbackpath == ""
                                    ? const GetSnackBar(
                                        title: "hiiiiii",
                                      )
                                    : Get.back();
                              }
                            } else {
                              Get.dialog(
                                AlertDialog(
                                  title: const Text('Vehicle Exist'),
                                  content: const Text(
                                      'This vehicle is Already Exist'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        // Close the dialog
                                        Get.back();
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              );
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

//dialog show

// class MyController extends GetxController {
//   final ImagePicker _picker = ImagePicker();

//   void showMyDialog() {
//     Get.dialog(
//       AlertDialog(
//         title: const Text('Confirmation'),
//         content: const Text('Choose an option:'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               pickImageFromGallery();
//               Get.back();
//             },
//             child: const Text('choose from Gallery'),
//           ),
//           TextButton(
//             onPressed: () {
//               captureImageFromCamera();
//               Get.back();
//             },
//             child: const Text('Take Photo'),
//           ),
//         ],
//       ),
//     );
//   }

//   void pickImageFromGallery() async {
//     final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedImage != null) {
//       // Process the picked image
//       // Do something with the image file
//     }
//   }

//   void captureImageFromCamera() async {
//     final capturedImage = await _picker.pickImage(source: ImageSource.camera);
//     if (capturedImage != null) {
//       // Process the captured image
//       // Do something with the image file
//     }
//   }
// }

class ImageData {
  final String? base64;
  final String? filePath;

  ImageData(this.base64, this.filePath);
}
