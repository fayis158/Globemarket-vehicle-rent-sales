import 'dart:convert';

// import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home_page/Drawer/Drawermain.dart';

class Ums extends StatefulWidget {
  const Ums({super.key});

  @override
  State<Ums> createState() => _UmsState();
}

class _UmsState extends State<Ums> {
  List<String> days = ['Manager', 'Admin', "Other"];
  String selectedDrop = 'Admin';

  List listToSearch = [
    {'name': 'KAZZ23445', 'class': 12},
    {'name': 'KA 11 AB 1233', 'class': 11},
    {'name': 'KA 11 6B45', 'class': 10},
    {'name': 'KA 11 6995', 'class': 9},
    {'name': 'KA 11 6555', 'class': 8},
    {'name': 'KA 01 1233', 'class': 7},
    {'name': 'KA 09 11 8988', 'class': 6},
    {'name': 'KA 09 11 3685', 'class': 5},
    {'name': 'KAZZ23445', 'class': 12},
    {'name': 'KA 11 AB 1233', 'class': 11},
    {'name': 'KA 11 6B45', 'class': 10},
    {'name': 'KA 11 6995', 'class': 9},
    {'name': 'KA 11 6555', 'class': 8},
    {'name': 'KA 01 1233', 'class': 7},
    {'name': 'KA 09 11 8988', 'class': 6},
    {'name': 'KA 09 11 3685', 'class': 5},
    {'name': 'KAZZ23445', 'class': 12},
    {'name': 'KA 11 AB 1233', 'class': 11},
    {'name': 'KA 11 6B45', 'class': 10},
    {'name': 'KA 11 6995', 'class': 9},
    {'name': 'KA 11 6555', 'class': 8},
    {'name': 'KA 01 1233', 'class': 7},
    {'name': 'KA 09 11 8988', 'class': 6},
    {'name': 'KA 09 11 3685', 'class': 5},
    {'name': 'KAZZ23445', 'class': 12},
    {'name': 'KA 11 AB 1233', 'class': 11},
    {'name': 'KA 11 6B45', 'class': 10},
    {'name': 'KA 11 6995', 'class': 9},
    {'name': 'KA 11 6555', 'class': 8},
    {'name': 'KA 01 1233', 'class': 7},
    {'name': 'KA 09 11 8988', 'class': 6},
    {'name': 'KA 09 11 3685', 'class': 5},
    {'name': 'KAZZ23445', 'class': 12},
    {'name': 'KA 11 AB 1233', 'class': 11},
    {'name': 'KA 11 6B45', 'class': 10},
    {'name': 'KA 11 6995', 'class': 9},
    {'name': 'KA 11 6555', 'class': 8},
    {'name': 'KA 01 1233', 'class': 7},
    {'name': 'KA 09 11 8988', 'class': 6},
    {'name': 'KA 09 11 3685', 'class': 5},
  ];

  List? selectedList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: Drawermain(),
      ),
      appBar: AppBar(
        title: Text('assignvehicle'.tr()),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                  flex: 9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                        TextFormField(
                          // controller: /,
                          decoration: InputDecoration(
                            labelText: 'Enter your first name',
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
                          height: 12,
                        ),
                        TextFormField(
                          // controller: /,
                          decoration: InputDecoration(
                            labelText: 'Enter Your Second Name ',
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
                          height: 12,
                        ),
                        TextFormField(
                          // controller: /,
                          decoration: InputDecoration(
                            labelText: 'Enter your Phone Number',
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
                          height: 12,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text("assignrole".tr()),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: const [
                            Text("  Assign Vehicle*"),
                          ],
                        ),
              
                      ],
                    ),
                  )),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
                      splashColor: Colors.orange,
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.blue,
                      splashColor: const Color.fromARGB(255, 30, 255, 0),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
