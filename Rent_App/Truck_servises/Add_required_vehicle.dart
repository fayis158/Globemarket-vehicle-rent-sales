import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Rent_App/rent/rent.dart';
import 'package:image_picker/image_picker.dart';

class Add_required_vehicle extends StatefulWidget {
  const Add_required_vehicle({super.key});

  @override
  State<Add_required_vehicle> createState() => _Add_required_vehicleState();
}

class _Add_required_vehicleState extends State<Add_required_vehicle> {

  Uint8List? _file;

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







  bool _isLoadingSelected = false;
  bool _isPassengerSelected = false;
  String _selectedVehicle = "Truck";

  DateTime datetime = DateTime(2022, 11, 23, 5, 30);
  DateTime datetime2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Demand Vehicle Supply"),
        ),
        body: SingleChildScrollView(
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
                  "Post Demand vehicle Availability",
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width(context) * 0.6,
                      child: DropdownButton<String>(
                        alignment: AlignmentDirectional.topEnd,
                        value: _selectedVehicle,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedVehicle = newvalue!;
                          });
                        },
                        items: <String>[
                          'Truck',
                          'Car',
                          'Bicycle',
                          'Bus',
                          'container',
                          "300 kg - 1.5 Ton",
                          '2.5 Ton - 4 Ton'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(value == "Car"
                                    ? Icons.directions_car
                                    : value == "Bicycle"
                                        ? Icons.directions_bike
                                        : value == "Bus"
                                            ? Icons.directions_bus
                                            : value == "Truck"
                                                ? FontAwesomeIcons.truck
                                                : value == "300 kg - 1.5 Ton"
                                                    ? FontAwesomeIcons.truck
                                                    : value == "2.5 Ton - 4 Ton"
                                                        ? FontAwesomeIcons.truck
                                                        : Icons.train),
                                const SizedBox(width: 10),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: width(context),
                    color: Color.fromARGB(146, 34, 167, 81),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "From",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Select the city",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: width(context),
                    color: Color.fromARGB(255, 52, 156, 159),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "To ",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Select the city",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoadingSelected = true;
                          _isPassengerSelected = false;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              _isLoadingSelected ? Colors.green : Colors.grey,
                        ),
                        child: const Center(
                            child: Text(
                          "Loading",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoadingSelected = false;
                          _isPassengerSelected = true;
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          color:
                              _isPassengerSelected ? Colors.green : Colors.grey,
                        ),
                        child: const Center(
                            child: Text("Passenger",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
               
                
                const Text(
                    "Type Required Vehicle Details like Type, Capacity and Size..."),
                   
                 
                    Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    // controller: transpotnamec,
                    decoration: InputDecoration(
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
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    // controller: transpotnamec,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
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
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    maxLines: 3,
                    // controller: transpotnamec,
                    decoration: InputDecoration(
                      labelText: 'vehicle Details',
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
                 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    Column(
                      children: [
                        Container(
                          child: const Text("Select Date and Time",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 98, 145, 98),
                                  fontWeight: FontWeight.bold)),
                        ),
                        MaterialButton(
                          minWidth: width(context) * 0.9,
                          height: 55,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          onPressed: pickDateTime2,
                          child: Text(
                            "${datetime2.year}/ ${datetime2.month}/${datetime2.day}   ${datetime2.hour}: ${datetime2.minute}",
                            style: const TextStyle(
                                color: Color.fromARGB(255, 22, 21, 21)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Center(
                  child: MaterialButton(
                    minWidth: width(context) * 0.2,
                    height: 40,
                    color: Colors.greenAccent,
                    child: const Text("Submit",style: TextStyle(color: Color.fromARGB(255, 3, 9, 77)),),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newdateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.datetime = newdateTime;
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: datetime,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100));
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: datetime.hour, minute: datetime.minute));

  Future pickDateTime2() async {
    DateTime? date = await pickDate();
    if (date == null) return;
    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final newdateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() {
      this.datetime2 = newdateTime;
      //   if (datetime2.isBefore(datetime)) {
      //   showDialog(
      //     context: context,
      //     builder: (context) {
      //       return  AlertDialog(
      //         title: Text("error"),
      //         content: Text("msgabtsedate".tr()),
      //       );
      //     },
      //   );
      // }
    });
  }
}
