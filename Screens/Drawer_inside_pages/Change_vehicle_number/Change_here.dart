import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import '../../../Constant.dart';


List<String> dropdownlist = [];

String dropdownValuechange = "";

List Vehicllistmap = [];
List<String> vehiclenamelist = [];

class Change extends StatefulWidget {
  var control;
  var vid;

  Change({super.key, required this.control, required this.vid});

  @override
  State<Change> createState() => _ChangeState();
}

class _ChangeState extends State<Change> {
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  late TextEditingController changevnumc = TextEditingController();
  List<dynamic> vehiclelistoflist = [];

  @override
  void initState() {
    super.initState();
    changevnumc = TextEditingController();
    changevnumc.text = widget.control;
    // getvehiclelist();
    vehiclelist();
  }

  @override
  void dispose() {
    super.dispose();
    changevnumc.dispose();
  }

  // getvehiclelist() async {
  //   Vehicllistmap = await Api.getvehiclelist();

  //   setState(() {

  //   });
  // }

  vehiclelist() async {
    await Api.getvehiclelist();
    // vehiclelistoflist = Vehicllistmap;
    // vehiclelistoflist.map(
    //   (e) {
    //     return vehiclenamelist.add(e["vehicle"]);
    //     // var vehiclenamelistcd = (e["vehicle"]);
    //   },
    // ).toList();
    for (var i = 0; i < getvehicle.length; i++) {
      vehiclenamelist.add(getvehicle[i]["vehicle"]);
      // vehiclenamelist = [Vehicllistmap[i]["vehicle"]];

    }
    dropdownlist = vehiclenamelist.toSet().toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("changevehiclenumber".tr()),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
              onPressed: () {
                TabBarDemo().navigateTo(context);
              },
              icon: const Icon(Icons.home)),
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.02,
          )
        ],
      ),
      body: dropdownlist.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Form(
              key: _form,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: changevnumc,
                      decoration: InputDecoration(
                        labelText: 'Vehicle Number',
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
                  MyHomePage(),

//             DropdownButton(
//   items: [
//     DropdownMenuItem(
//       child: Container(
//         width: 200.0,
//         height: 300.0,
//         child: ListView.builder(
//           itemCount: Vehicllistmap.length,
//           itemBuilder: (context, index) {
//             return Text(Vehicllistmap[index]["vehicle"]);
//           },
//         ),
//       ),
//     ),
//   ],
//   onChanged: (value) {
//     // handle changes
//   },
// ),

                  // DropdownButton(
                  //   items: Vehicllistmap.map((item) {
                  //     return DropdownMenuItem(
                  //       child: Text(item['vehicle']),
                  //       value: item["vehicle"].toString(),
                  //     );
                  //   }).toList(),
                  //   onChanged: (newVal) {
                  //     setState(() {
                  //       selectedValue = newVal;
                  //     });
                  //   },
                  //   value: selectedValue,
                  // ),

                  //         Padding(padding:  EdgeInsets.symmetric(horizontal: 8),
                  //         child: DropdownButtonFormField2(
                  //   disabledHint: const Text("vehicle"),
                  //   decoration: InputDecoration(
                  //     contentPadding: EdgeInsets.zero,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  //   isExpanded: true,
                  //   hint: Text(
                  //    "Select You Vehicle here",
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  //   icon: const Icon(
                  //     Icons.arrow_drop_down,
                  //     color: Colors.black45,
                  //   ),
                  //   iconSize: 30,
                  //   buttonHeight: 60,
                  //   buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  //   dropdownDecoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   items: vehiclenamelist.map((item) => DropdownMenuItem<String>(
                  //         onTap: () {
                  //           setState(() {
                  //             selectedvehicledrop = item;
                  //           });
                  //         },
                  //         value: item,
                  //         child: Text(
                  //           item,
                  //           style: const TextStyle(
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       )).toList(),
                  //   validator: (value) {
                  //     if (value == null) {
                  //       return "Please Select You vehice";
                  //     }
                  //   },
                  //   onChanged: (value) {
                  //     //I will Do something when changing the item.
                  //   },
                  //   onSaved: (value) {
                  //     selectedValue = value.toString();
                  //   },
                  // ),
                  //         ),

                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8),
                  //   child: drop(
                  //     Details: "Select You Vehicle here",
                  //     Listofitems: vehiclenamelist,
                  //     Validationmessege: "Please Select You vehice",
                  //   ),
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        // Api.changevehiclenumber("26161", changevnumc.text, "8");

                        if (_form.currentState!.validate()) {
                          String vehiclerelatedid = selectedValue == "car"
                              ? "1"
                              : selectedValue == "Truck"
                                  ? "2"
                                  : selectedValue == "Bus"
                                      ? "3"
                                      : selectedValue == "Bike"
                                          ? "4"
                                          : selectedValue == "Ambulance"
                                              ? "5"
                                              : selectedValue == "Jeep"
                                                  ? "6"
                                                  : selectedValue == "Van"
                                                      ? "7":selectedValue == "bulldozer"
                                                      ? "8":selectedValue == "Man"
                                                      ? "9":selectedValue == "Tractor"
                                                      ? "10":selectedValue == "Roller"
                                                      ? "11":selectedValue == "Tipper"
                                                      ? "12":selectedValue == "Hitachi"
                                                      ? "13":selectedValue == "Tanker"
                                                      ? "14":selectedValue == "Grader"
                                                      ? "15":selectedValue == "JCB"
                                                      ? "16":selectedValue == "Crane"
                                                    ?"17"
                                                      : "1";

                         
                          Api.changevehiclenumber(
                              widget.vid, changevnumc.text, vehiclerelatedid);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Succesful')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Please Enter all required field')),
                          );
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 13, 122, 31)),
                        child: const Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Floatingaction_button(),
    );
  }
}

// class drop extends StatelessWidget {
//   List<String> Listofitems;
//   String Validationmessege;
//   String Details;
//   drop({super.key, required this.Listofitems, required this.Validationmessege, required this.Details});
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField2(

//       disabledHint: Text("data"),
//       decoration: InputDecoration(

//       // prefixText: "mother tongue",
//       // prefixStyle: TextStyle(fontSize: 10),
//         //Add isDense true and zero Padding.
//         //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
//         isDense: true,
//         contentPadding: EdgeInsets.zero,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         //Add more decoration as you want here
//         //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
//       ),
//       isExpanded: true,

//       hint: Text(
//         Details,
//         style: TextStyle(fontSize: 14),
//       ),
//       icon: const Icon(
//         Icons.arrow_drop_down,
//         color: Colors.black45,
//       ),
//       iconSize: 30,
//       buttonHeight: 60,
//       buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//       dropdownDecoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       items: Listofitems.map((item) => DropdownMenuItem<String>(
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           )).toList(),
//       validator: (value) {
//         if (value == null) {
//           return Validationmessege;
//         }
//       },
//       onChanged: (value) {
//         //Do something when changing the item if you want.
//       },
//       onSaved: (value) {
//         selectedValue = value.toString();
//       },
//     );
//   }
// }

// DropdownButton

// String selectedvehicledrop = "Please select vehicle type";

// class drop extends StatefulWidget {
//   List<dynamic> Listofitems;
//   String Validationmessege;
//   String Details;
//   drop(
//       {super.key,
//       required this.Listofitems,
//       required this.Validationmessege,
//       required this.Details});

//   @override
//   State<drop> createState() => _dropState();
// }

// class _dropState extends State<drop> {
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField2(
//       disabledHint: const Text("vehicle"),
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.zero,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//       isExpanded: true,
//       hint: Text(
//         widget.Details,
//         style: const TextStyle(fontSize: 14),
//       ),
//       // icon: const Icon(
//       //   Icons.arrow_drop_down,
//       //   color: Colors.black45,
//       // ),
//       // iconSize: 30,
//       // buttonHeight: 60,
//       // buttonPadding: const EdgeInsets.only(left: 20, right: 10),
//       // dropdownDecoration: BoxDecoration(
//       //   borderRadius: BorderRadius.circular(15),
//       // ),
//       items: dropdownlist.map((item) => DropdownMenuItem<String>(
//             onTap: () {
//               setState(() {
//                 selectedvehicledrop = item;
//               });
//             },
//             value: item,
//             child: Text(
//               item,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//           )).toList(),
//       validator: (value) {
//         if (value == null) {
//           return widget.Validationmessege;
//         }
//       },
//       onChanged: (value) {
//         //I will Do something when changing the item.
//       },
//       onSaved: (value) {
//         selectedValue = value.toString();
//       },
//     );
//   }
// }

// // dropdown final

// // class dropvehiclelist extends StatefulWidget {
// //   @override
// //   _dropvehiclelistState createState() => _dropvehiclelistState();
// // }

// // class _dropvehiclelistState extends State<dropvehiclelist> {
// //   String dropdownValue = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Dropdown Button Demo',
// //       home: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Dropdown Button Demo'),
// //         ),
// //         body: Center(
// //           child: DropdownButton<String>(
// //             icon: Icon(Icons.arrow_drop_down),
// //             iconSize: 24,
// //             elevation: 16,
// //             style: TextStyle(color: Colors.black),
// //             underline: Container(
// //               height: 2,
// //               color: Colors.grey,
// //             ),
// //             value: dropdownValue,
// //             onChanged: (String? newValue) {
// //               setState(() {
// //                 dropdownValue = newValue!;
// //               });
// //             },
// //             items: map<DropdownMenuItem<String>>((String value) {
// //               return DropdownMenuItem<String>(
// //                 value: value,
// //                 child: Text(value),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// class Dropvehiclelist extends StatefulWidget {

//   Dropvehiclelist({super.key,});

//   @override
//   State<Dropvehiclelist> createState() => _DropvehiclelistState();
// }

// class _DropvehiclelistState extends State<Dropvehiclelist> {
//   @override
//   Widget build(BuildContext context) {

//     return DropdownButton<String>(
//       icon: Icon(Icons.arrow_drop_down),
//       iconSize: 24,
//       elevation: 16,
//       style: TextStyle(color: Colors.black),
//       underline: Container(
//         height: 2,
//         color: Colors.grey,
//       ),
//       value: dropdownValuechange,
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValuechange = newValue!;
//         });
//       },
//       items: dropdownlist.map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
String? selectedValue;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = dropdownlist;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: const [
            Icon(
              Icons.list,
              size: 16,
              color: Colors.black,
            ),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                'Select vehicle',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
        
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.98,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.white,
            ),
            color: Colors.white,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.white,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.95,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          elevation: 8,
          offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
