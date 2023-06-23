import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import 'package:file_picker/file_picker.dart';

List<String> days = [
  'KL18AA324',
  'GUAX0001',
  'GUAX9091',
  'GUAX0431',
  'GUAX00055'
];
String selectedDrop = 'KL18AA324';
List<String> today = ['KL18AA0001', 'KL18AA0002', 'KL18AA0003', "fayis543"];
List<String> yesterday = ['KL18AB0001', 'KL18AC0002'];
List<String> last7days = ['Last 7 days'];
List<String> last15days = ['Last 15 days', "b", "b", "b"];
List<String> last30days = [
  'Last 30 days',
  "b",
  "dfsd",
  "dfsd",
  "sdfs",
  "dfsd",
  "sdfs",
  "sdds"
];

// class rent extends StatefulWidget {
//   const rent({super.key});

//   @override
//   State<rent> createState() => _rentState();
// }

// class _rentState extends State<rent> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //  backgroundColor:  Color.fromARGB(255, 53, 42, 42),
//         title: Text("rent".tr()),
//       ),
//       body: Column(
//         children: [
//           const marquee(),
//           SizedBox(
//             // color: Colors.red,
//             width: double.infinity,
//             height: 60,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 30,
//               ),
//               child: DropdownButtonFormField<String>(
//                   // isDense: false,
//                   enableFeedback: false,
//                   // dropdownColor: Colors.green,
//                   value: selectedDrop,
//                   items: days.map((e) {
//                     return DropdownMenuItem(
//                         onTap: () {
//                           setState(() {
//                             selectedDrop = e;
//                           });
//                         },
//                         value: e,
//                         child: Text(e));
//                   }).toList(),
//                   onChanged: (val) {}),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: 1,
//               itemBuilder: (context, index) {
//                 return
//                 // selectedDrop != days[index]
//                 //     ? document_for_rent(
//                 //         vehiclenumber: days[index],
//                 //         color: Colors.red,
//                 //       )
//                 //     : Container();
//                 selectedDrop == 'KL18AA324'
//                     ? document_for_rent(
//                       vehiclenumber: "GUAX0001",
//                         color: Colors.red,
//                       )
//                     : selectedDrop == 'GJ06AX4458'
//                         ? document_for_rent(
//                           vehiclenumber: "GJ06AX4458",
//                             color: Color.fromARGB(255, 107, 93, 216))
//                         : selectedDrop == 'GJ06AU7623'
//                             ? document_for_rent(
//                               vehiclenumber: "GJ06AU7623",
//                                 color: Color.fromARGB(255, 222, 155, 191))
//                             : selectedDrop == 'GUAX0431'
//                                 ? document_for_rent(
//                                   vehiclenumber: "GUAX0431",
//                                     color: Color.fromARGB(255, 250, 118, 188))
//                                 : document_for_rent(
//                                   vehiclenumber: "GJ06AU7623",
//                                     color: Color.fromARGB(255, 4, 150, 52));
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class document_for_rent extends StatelessWidget {
  var color;
  String vehiclenumber;
  document_for_rent(
      {super.key, required this.color, required this.vehiclenumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: color,
      child: Center(
          child: Text(
        vehiclenumber,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      )),
    );
  }
}

// class rent2 extends StatefulWidget {
//   const rent2({super.key});

//   @override
//   State<rent2> createState() => _rent2State();
// }

// class _rent2State extends State<rent2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         //  backgroundColor:  Color.fromARGB(255, 53, 42, 42),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);

//             },
//             icon: Icon(Icons.arrow_back)),
//         title: const Text("Rent Vehicle"),
//       ),
//       body: Column(
//         children: [
//           const marquee(),
//           Expanded(
//             flex: 8,
//             child: ListView.builder(
//               itemCount: 12,
//               itemBuilder: (context, index) {
//                 return const rentcontainer();
//               },
//             ),
//           ),
//           Expanded(
//               flex: 1,
//               child: SingleChildScrollView(
//                 child: Container(
//                   width: double.infinity,
//                   color: const Color.fromARGB(17, 255, 255, 255),
//                   child: Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Truck_services()));
//                               },
//                               child: const CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor:
//                                     Color.fromARGB(255, 237, 173, 255),
//                                 child: Icon(
//                                   FontAwesomeIcons.truck,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "Demand",
//                               style: TextStyle(fontSize: 12),
//                             )
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Truck_services()));
//                               },
//                               child: const CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor:
//                                     Color.fromARGB(255, 255, 233, 173),
//                                 child: Icon(
//                                   FontAwesomeIcons.truck,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "Supply",
//                               style: TextStyle(fontSize: 12),
//                             )
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) => Truck_services()));
//                               },
//                               child: const CircleAvatar(
//                                 radius: 25,
//                                 backgroundColor:
//                                     Color.fromARGB(255, 173, 185, 255),
//                                 child: Icon(
//                                   FontAwesomeIcons.truck,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                             const Text(
//                               "sales",
//                               style: TextStyle(fontSize: 12),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ))
//         ],
//       ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       // floatingActionButton: Padding(
//       //   padding: const EdgeInsets.all(4.0),
//       //   child: Row(
//       //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       //     children: <Widget>[
//       //       SizedBox(
//       //         width: 70,
//       //         child: FloatingActionButton(
//       //           // shape: const RoundedRectangleBorder(
//       //           //     borderRadius: BorderRadius.all(Radius.circular(12))),
//       //           onPressed: () {},
//       //           child: Column(
//       //             mainAxisAlignment: MainAxisAlignment.center,
//       //             children: [
//       //               Center(child: Icon(Icons.car_crash)),
//       //               // Text(
//       //               //   "Demand",
//       //               //   style: TextStyle(fontSize: 12),
//       //               // ),
//       //             ],
//       //           ),
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         width: 70,
//       //         child: FloatingActionButton(
//       //           // shape: const RoundedRectangleBorder(
//       //           //     borderRadius: BorderRadius.all(Radius.circular(12))),
//       //           onPressed: () {},
//       //           child: Text("Supply"),
//       //         ),
//       //       ),
//       //       SizedBox(
//       //         width: 70,
//       //         child: FloatingActionButton(
//       //           // shape: const RoundedRectangleBorder(
//       //           //     borderRadius: BorderRadius.all(Radius.circular(12))),
//       //           onPressed: () {},
//       //           child: Text("sales"),
//       //         ),
//       //       )
//       //     ],
//       //   ),
//       // )
//       //   floatingActionButton: Stack(
//       //   children: <Widget>[
//       //     Padding(padding: EdgeInsets.only(left:31),
//       //     child: Align(
//       //       alignment: Alignment.centerRight,
//       //       child: FloatingActionButton(
//       //         onPressed: () {

//       //         },
//       //         child: Icon(Icons.camera_alt),),
//       //     ),),

//       //     Align(
//       //       alignment: Alignment.,
//       //       child: FloatingActionButton(
//       //         onPressed: () {

//       //         },
//       //       child: Icon(Icons.add_photo_alternate),),
//       //     ),
//       //   ],
//       // )
//       // floatingActionButton: Container(
//       //   height: 50,
//       //   width: 100,
//       //   decoration: const BoxDecoration(
//       //       color: Color.fromARGB(255, 76, 91, 175),
//       //       borderRadius: BorderRadius.all(Radius.circular(20))),
//       //   child: FloatingActionButton(
//       //     shape: const RoundedRectangleBorder(
//       //         borderRadius: BorderRadius.all(Radius.circular(12))),
//       //     onPressed: () {},
//       //     backgroundColor: const Color.fromARGB(255, 50, 44, 139),
//       //     tooltip: 'Capture Picture',
//       //     elevation: 5,
//       //     splashColor: Colors.grey,
//       //     child: const Text(
//       //       "button",
//       //       style: TextStyle(color: Colors.white),
//       //     ),
//       //   ),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

class rentcontainer extends StatelessWidget {
  const rentcontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 150,
          width: width(context) * 0.08,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  offset: const Offset(-6.0, -6.0),
                  blurRadius: 15.0,
                ),
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 153, 151, 151).withOpacity(0.4),
                  offset: const Offset(6.0, 6.0),
                  blurRadius: 15.0,
                ),
              ],
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "GJ06AU7899",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        documentfor_vehicle(
                          transname: "Balaji Transport",
                          name: "Balaji",
                        ).navigateTo(context);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          Text(
                            "Edit",
                            style: TextStyle(
                                color: Color.fromARGB(255, 142, 76, 175)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 40,
                      width: width(context) * 0.4,
                      child: TextFormField(
                        // controller: operatornamec,
                        decoration: InputDecoration(
                          labelText: "Select Drop City",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Colors.blue, width: 0.5),
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
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       color: Colors.green,
                    //       borderRadius: BorderRadius.all(Radius.circular(12))),
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text("Select pick City",
                    //         style:
                    //             TextStyle(fontSize: 16, color: Colors.white)),
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                      width: width(context) * 0.4,
                      child: TextFormField(
                        // controller: operatornamec,
                        decoration: InputDecoration(
                          labelText: "Select Pick City",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.green,
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
                    // Container(
                    //   decoration: const BoxDecoration(
                    //       color: Colors.green,
                    //       borderRadius: BorderRadius.all(Radius.circular(12))),
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child: Text("Select Drop City",
                    //         style:
                    //             TextStyle(fontSize: 16, color: Colors.white)),
                    //   ),
                    // ),
                  ],
                ),
                const Text("Owner  : 9656832396",
                    style: TextStyle(fontSize: 16, color: Colors.black)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        documentfor_vehicle(
                          transname: "Balaji Transport",
                          name: "Balaji",
                        ).navigateTo(context);
                      },
                      child: const Text(
                        "Not Ready for Trip",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const Text(
                      "Inactive",
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
                // Text("Ready for Trip",style: TextStyle(color: Colors.green),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class documentfor_vehicle extends StatefulWidget {
  var transname;
  var name;
  documentfor_vehicle({super.key, required this.transname, required this.name});

  @override
  State<documentfor_vehicle> createState() => _documentfor_vehicleState();
}

class _documentfor_vehicleState extends State<documentfor_vehicle> {
  //  Future<File> SavefilePermanntly(PlatformFile file) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final newFile = File('${appStorage.path}/${file.name}');
  //   return File(file.path!).copy(newFile.path);
  // }

  //  void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => FilesPage(files: files, onOpenedFile: openFile),
  //       ),
  //     );

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
                  // Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    // _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  // final result =
                  //     await FilePicker.platform.pickFiles(allowMultiple: true);
                  // if (result == null) return;

                  // // final file = result.files.first;
                  // // openFile(file);
                  // openFiles(result.files);
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

  // void openFiles(List<PlatformFile> files) => Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => FilesPage(files: files, onOpenedFile: openFile),
  //       ),
  //     );

  // void openFile(PlatformFile file) {
  //   // OpenFile.open(file.path!);
  // }

  late TextEditingController transpotnamec = TextEditingController();
  late TextEditingController namec = TextEditingController();
  late TextEditingController address = TextEditingController();
  late TextEditingController mobilenum = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transpotnamec.text = widget.transname;
    namec.text = widget.name;
    address.text =
        "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057";
    mobilenum.text = "96568323966";
  }

  DateTime datetime = DateTime(2022, 11, 23, 5, 30);
  DateTime datetime2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill Travel Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.green,
              //           borderRadius: BorderRadius.all(Radius.circular(12))),
              //       child: const Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text("Select pick location",
              //             style: TextStyle(fontSize: 16, color: Colors.white)),
              //       ),
              //     ),
              //     Container(
              //       decoration: const BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.all(Radius.circular(12))),
              //       child: const Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text("Select Drop location",
              //             style: TextStyle(fontSize: 16, color: Colors.white)),
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(
              //   height: 14,
              // ),
              // // const Text("Transport Name"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                enabled: false,
                controller: transpotnamec,
                decoration: InputDecoration(
                  labelText: ' Transport name',
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
              const SizedBox(
                height: 14,
              ),
              // const Text("Name* "),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                enabled: false,
                controller: namec,
                decoration: InputDecoration(
                  labelText: "Name",
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
              const SizedBox(
                height: 14,
              ),
              // const Text("Address "),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                enabled: false,
                maxLines: 2,
                controller: address,
                decoration: InputDecoration(
                  hintMaxLines: 4,
                  labelText: "Address",
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
              const SizedBox(
                height: 14,
              ),
              // const Text("Mobile Number*"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                enabled: false,
                controller: mobilenum,
                decoration: InputDecoration(
                  labelText: "Mobile Number",
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
              const SizedBox(
                height: 14,
              ),
              const Text("Mobile Number 2"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                // controller: operatornamec,
                decoration: InputDecoration(
                  labelText: "Mobile Number 2",
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
              const SizedBox(
                height: 14,
              ),
              const Text("Vehicle load Capacity"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                // controller: operatornamec,
                decoration: InputDecoration(
                  labelText: "Ton",
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
              const SizedBox(
                height: 14,
              ),
              const Text("Minimum Charge"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                // controller: operatornamec,
                decoration: InputDecoration(
                  labelText: "Minimum Charge",
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
              const SizedBox(
                height: 14,
              ),
              const Text("Minimum km"),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                // controller: operatornamec,
                decoration: InputDecoration(
                  labelText: "Minimum km",
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

              const SizedBox(
                height: 14,
              ),
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Column(
              //       children: [
              //         Container(
              //           height: 80,
              //           width: 90,
              //           color: Color.fromARGB(255, 169, 222, 171),
              //           child: Icon(Icons.add),
              //         ),
              //          SizedBox(height: 12,),
              //         Text("Add vehicle RC")
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         Container(
              //           color: Color.fromARGB(255, 78, 77, 77),
              //           height: 80,
              //           width: 90,
              //           child: Icon(Icons.add),
              //         ),
              //         SizedBox(height: 12,),
              //         Text("Add your aadharcard")
              //       ],
              //     ),
              //      const SizedBox(
              //   height: 300,
              // ),
              //   ],
              // ),
              const Text("Select Vehicle Type"),
              const SizedBox(
                height: 8,
              ),

              SizedBox(
                // color: Colors.red,
                // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1,
                  ),
                  child: DropdownButtonFormField<String>(
                      // isDense: false,
                      enableFeedback: false,
                      // dropdownColor: Colors.green,
                      value: selectedDrop,
                      items: days.map((e) {
                        return DropdownMenuItem(
                            onTap: () {
                              setState(() {
                                selectedDrop = e;
                              });
                            },
                            value: e,
                            child: Text(e));
                      }).toList(),
                      onChanged: (val) {}),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        // width: width(context) * 0.3,
                        child: const Text("Available Now",
                            style: TextStyle(
                                color: Color.fromARGB(255, 98, 145, 98),
                                fontWeight: FontWeight.bold)),
                      ),
                      MaterialButton(
                        minWidth: width(context) * 0.9,
                        height: 55,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        onPressed: () {},
                        child: Text(
                          DateTime.now().toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 22, 21, 21)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      Container(
                        //  margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        // width: width(context) * 0.3,
                        child: const Text("Available Later",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectImage(context);
                        },
                        child: Container(
                          height: 80,
                          width: 90,
                          color: const Color.fromARGB(255, 169, 222, 171),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Vehicle RC")
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _selectImage(context);
                        },
                        child: Container(
                          height: 80,
                          width: 90,
                          color: const Color.fromARGB(255, 101, 213, 182),
                          child: const Icon(Icons.add),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text("Addhar card")
                    ],
                  ),
                ],
              ),
              // SliderExample(),
              // SliderPlayButton(),

              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 100,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 76, 91, 175),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: FloatingActionButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12))),
          onPressed: () {},
          backgroundColor: const Color.fromARGB(255, 50, 44, 139),
          tooltip: 'Capture Picture',
          elevation: 5,
          splashColor: Colors.grey,
          child: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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

//files

//2nd
class FilesPage extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  FilesPage({super.key, required this.files, required this.onOpenedFile});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("files"),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: widget.files.length,
          itemBuilder: (context, index) {
            final file = widget.files[index];
            return buildFile(file);
          },
        ),
      ),
    );
  }

  Widget buildFile(PlatformFile file) {
    final kb = file.size / 1024;
    final mb = kb / 1024;
    final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB' : '${kb.toStringAsFixed(2)} kb';
    final extension = file.extension ?? "none";
    // final color = getColor(extension);
    return InkWell(
      onTap: () => widget.onOpenedFile(file),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: file.extension == "jpg" && file.extension == 'jpeg'
                      ? Colors.red
                      : file.extension == "mp4"
                          ? Colors.blue
                          : Colors.green,
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                extension,
              ),
            )),
            const SizedBox(
              height: 8,
            ),
            Text(file.name),
            Text(fileSize)
          ],
        ),
      ),
    );
  }
}
