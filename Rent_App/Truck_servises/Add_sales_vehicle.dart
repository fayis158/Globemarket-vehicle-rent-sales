import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/extensions/extensions.dart';

class Add_sales_vehicle extends StatelessWidget {
  const Add_sales_vehicle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Sales Vehicle"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                const Loading_vehicle_add_sale().navigateTo(context);
              },
              child: Container(
                height: 60,
                width: width(context),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 46, 49),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Center(
                  child: Text(
                    "LOADING",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                const Passenger_vehicle_add().navigateTo(context);
              },
              child: Container(
                height: 60,
                width: width(context),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 3, 34, 55),
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: const Center(
                  child: Text(
                    "PASSENGER",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Loading_vehicle_add_sale extends StatefulWidget {
  const Loading_vehicle_add_sale({super.key});

  @override
  State<Loading_vehicle_add_sale> createState() =>
      _Loading_vehicle_add_saleState();
}

class _Loading_vehicle_add_saleState extends State<Loading_vehicle_add_sale> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOADING"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/ultra2.jpeg"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/ultra2.jpeg"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/ultra2.jpeg"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Passenger_vehicle_add extends StatefulWidget {
  const Passenger_vehicle_add({super.key});

  @override
  State<Passenger_vehicle_add> createState() => _Passenger_vehicle_addState();
}

class _Passenger_vehicle_addState extends State<Passenger_vehicle_add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOADING"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/carsa.jpeg"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/carsa.jpeg"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    const sale_vehicle_details_entry().navigateTo(context);
                  },
                  child: Container(
                    height: 100,
                    width: 80,
                    child: Image.asset("images/carsa.jpeg"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class sale_vehicle_details_entry extends StatefulWidget {
  const sale_vehicle_details_entry({super.key});

  @override
  State<sale_vehicle_details_entry> createState() =>
      _sale_vehicle_details_entryState();
}

class _sale_vehicle_details_entryState
    extends State<sale_vehicle_details_entry> {
  List<String> days = [
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010",
    "2009"
  ];
  String selectedDrop = '1999';

  List<String> varient = ['Petrol', 'Diesel', 'CNG', 'LPG'];
  String selectedDrop1 = 'Petrol';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Add Vehicle Details for Sale",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  // controller: transpotnamec,
                  decoration: InputDecoration(
                    labelText: 'Type your Vehicle Brand and Company Name',
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
                    labelText: 'Total Running in km',
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
                children: const [
                  Text(
                    "Variant",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Padding(
              //   padding: const EdgeInsets.all(14.0),
              //   child: DropdownButtonFormField2(
              //     disabledHint: const Text("ss"),
              //     decoration: InputDecoration(
              //       isDense: true,
              //       contentPadding: EdgeInsets.zero,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     isExpanded: true,
              //     hint: const Text(
              //       "Variant",
              //       style: TextStyle(fontSize: 11),
              //     ),
              //     icon: const Icon(
              //       Icons.arrow_drop_down,
              //       color: Colors.black45,
              //     ),
              //     iconSize: 30,
              //     buttonHeight: 60,
              //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              //     dropdownDecoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     items: varient
              //         .map((item) => DropdownMenuItem<String>(
              //               value: item,
              //               child: Text(
              //                 item,
              //                 style: const TextStyle(
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ))
              //         .toList(),
              //     validator: (value) {
              //       if (value == null) {
              //         return "Validationmessege";
              //       }
              //     },
              //     onChanged: (value) {
              //       //Do something when changing the item if you want.
              //     },
              //     onSaved: (value) {
              //       // selectedDrop = value.toString();
              //     },
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(14.0),
              //   child: DropdownButtonFormField2(
              //     disabledHint: const Text(""),
              //     decoration: InputDecoration(
              //       isDense: true,
              //       contentPadding: EdgeInsets.zero,
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //     isExpanded: true,
              //     hint: const Text(
              //       "Manufacture or Purchase Year",
              //       style: TextStyle(fontSize: 14),
              //     ),
              //     icon: const Icon(
              //       Icons.arrow_drop_down,
              //       color: Colors.black45,
              //     ),
              //     iconSize: 30,
              //     buttonHeight: 60,
              //     buttonPadding: const EdgeInsets.only(left: 20, right: 10),
              //     dropdownDecoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     items: days
              //         .map((item) => DropdownMenuItem<String>(
              //               value: item,
              //               child: Text(
              //                 item,
              //                 style: const TextStyle(
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ))
              //         .toList(),
              //     validator: (value) {
              //       if (value == null) {
              //         return "Validationmessege";
              //       }
              //     },
              //     onChanged: (value) {
              //       //Do something when changing the item if you want.
              //     },
              //     onSaved: (value) {
              //       selectedDrop = value.toString();
              //     },
              //   ),
              // ),
               Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  // controller: transpotnamec,
                  decoration: InputDecoration(
                    labelText: 'Selling City',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please  the field';
                    }
                    return null;
                  },
                ),
              ),
              // Container(
              //   height: 40,
              //   width: width(context)*0.8,
              //   color: Colors.black,
              //   child: Center(child: Text("Select City",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
              // ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  // controller: transpotnamec,
                  decoration: InputDecoration(
                    labelText: 'Selling Price(RS. )',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please  the field';
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
                    labelText: 'Remark',
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
                child: MaterialButton(
                  height: 40,
                  color: Colors.blue,
                  minWidth: width(context),
                  onPressed: () {
                  
                },
                child: const Text("Post",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
