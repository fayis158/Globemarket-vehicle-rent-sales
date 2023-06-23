import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../Constant.dart';
import '../../rent/rent.dart';
import '../Api_Truck_service/ApiT.dart';
import '../Supply/SelectTheCity.dart';
import 'Select_city_demand.dart';

class Add_demand_vehicles extends StatefulWidget {
  Add_demand_vehicles({
    super.key,
  });

  @override
  State<Add_demand_vehicles> createState() => _Add_demand_vehiclesState();
}

class _Add_demand_vehiclesState extends State<Add_demand_vehicles> {
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

  String available = "Available Now";
  int vehicletype = 1;
  int typeofvehicle = 1;
  TextEditingController ratecontroller = TextEditingController();
  TextEditingController customernamecontroller = TextEditingController();
  TextEditingController vehicledetailscontoller = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  DateTime selectedDateTime2 = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    ratecontroller.dispose();
    customernamecontroller.dispose();
    vehicledetailscontoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 38, 36),
          title: const Text("Add Vehicle Required"),
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
                                ? const Color.fromARGB(255, 25, 96, 27)
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
                                ? const Color.fromARGB(255, 25, 96, 27)
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
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Select_City_demand(
                                      title: "Search the city",
                                    )));
                      },
                      child: Container(
                        // height: 60,
                        width: width(context),
                        color: const Color.fromARGB(255, 29, 27, 28),
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
                                globefromcitydemand ?? "Select from city",
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
                                builder: (context) => Select_CityTodemand(
                                      title: "Search the city",
                                    )));
                      },
                      child: Container(
                        // height: 60,
                        width: width(context),
                        color: const Color.fromARGB(255, 39, 34, 44),
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
                                globeltocitydemand ?? "Select to city",
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
                      controller: customernamecontroller,
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
                          return 'Please Enter the field';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: ratecontroller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: 'Your Budget',
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
                      maxLines: 3,
                      controller: vehicledetailscontoller,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8),
                        labelText: 'vehicle Details(Capcity , Size etc..)',
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
                        MaterialButton(
                          minWidth: width(context) * 0.9,
                          height: 55,
                          color: const Color.fromARGB(255, 30, 102, 32),
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              available = DateTime.now().toString();

                              // (selectedItem2 == null && selectedItem == null) ||

                              Get.back();
                              setState(() {});
                            }
                          },
                          child: const Text(
                            "Required Now",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          children: [
                            Container(
                              //  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              // width: width(context) * 0.3,
                              child: const Text(
                                  "Required Later(Select Date Below)",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 98, 145, 98),
                                      fontWeight: FontWeight.bold)),
                            ),
                            MaterialButton(
                              minWidth: width(context) * 0.9,
                              height: 55,
                              color: const Color.fromARGB(255, 18, 101, 26),
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  // dateTimePickerController.openDateTimePicker();

                                  DatePicker.showDateTimePicker(
                                    theme: const DatePickerTheme(
                                        backgroundColor:
                                            Color.fromARGB(255, 152, 152, 156),
                                        headerColor:
                                            Color.fromARGB(255, 179, 177, 177)),
                                    Get.context!,
                                    currentTime: selectedDateTime2,
                                    onConfirm: (DateTime dateTime) {
                                      Get.back();
                                    },
                                  );
                                  setState(() {});
                                }
                              },
                              child: Text(
                                " ${selectedDateTime2.day.toString()}- ${selectedDateTime2.month.toString().padLeft(2, '0')}-${selectedDateTime2.year.toString()}   ${selectedDateTime2.hour.toString()}:${selectedDateTime2.minute.toString()}:${selectedDateTime2.second.toString()}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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

// class DateTimePickerController extends GetxController {
//   Rx<DateTime> selectedDateTime = Rx<DateTime>(DateTime.now());

//   void openDateTimePicker() {
//     DatePicker.showDateTimePicker(
//       theme: const DatePickerTheme(
//           backgroundColor: Color.fromARGB(255, 152, 152, 156),
//           headerColor: Color.fromARGB(255, 179, 177, 177)),
//       Get.context!,
//       currentTime: selectedDateTime.value,
//       onConfirm: (DateTime dateTime) {
//         selectedDateTime.value = dateTime;
//       },
//     );
//   }
// }
