import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Drawer_inside_pages/Documents/details_like_insurance_etc.dart';
import 'package:gpsglobe/Screens/Home/home.dart';
import 'package:gpsglobe/extensions/extensions.dart';
import '../../Home_page/Drawer/Drawermain.dart';

class Documents extends StatelessWidget {
  const Documents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const Floatingaction_button(),
      drawer: const Drawer(
        backgroundColor: Colors.black,
        child: Drawermain(),
      ),
      appBar: AppBar(
          backgroundColor: Colors.green, title: Text("companyname".tr())),
      body: const All_expiring_document(),
    );
  }
}

class All_expiring_document extends StatefulWidget {
  const All_expiring_document({Key? key}) : super(key: key);

  @override
  State<All_expiring_document> createState() => _All_expiring_documentState();
}

class _All_expiring_documentState extends State<All_expiring_document> {
  /// List of Tab Bar Item
  List<String> items = [
    "All".tr(),
    "expiringdoc".tr(),
  ];
  //widget list

  List<Widget> widgetlist = [
    const All_area(),
    const Expiring_Doc(),
  ];

  /// List of body icon
  List<Widget> icons = [
    const Text("data"),
    const Text("data"),
  ];
  int current = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        // height: double.infinity,
        margin: const EdgeInsets.all(1),
        child: Column(
          children: [
            /// CUSTOM TABBAR
            const marquee(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              current = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(
                                top: 5, bottom: 5, right: 10, left: 10),
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: current == index
                                    ? const Color.fromARGB(179, 80, 231, 105)
                                    : const Color.fromARGB(255, 235, 235, 235),
                                borderRadius: current == index
                                    ? BorderRadius.circular(25)
                                    : BorderRadius.circular(25),
                                border: current == index
                                    ? null
                                    : Border.all(color: Colors.white)),
                            child: Center(
                              child: Text(
                                items[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: current == index
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              // margin: const EdgeInsets.only(top: 30),
              width: double.infinity,
              // height: 550,
              child: SingleChildScrollView(
                child: widgetlist[current],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class All_area extends StatefulWidget {
  const All_area({super.key});

  @override
  State<All_area> createState() => _All_areaState();
}

class _All_areaState extends State<All_area> {
  List<String> texts = [
    'text1',
    'text2',
    'text3',
    'text4',
    'text5',
    'text6',
    'text7'
  ];
  int targetValue = 78;

  void checkValues() {
    for (String text in texts) {
      if (text != targetValue) {
        
      }
    }
  }

  int number123 = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: document.length,
        itemBuilder: (context, index) {
          number123 = 0;

          if (document[index]["docList"][0]["insuranceDate"] == null) {
            number123 = number123 + 1;
          }

          if (document[index]["docList"][0]["fitnessDate"] == null) {
            number123 = number123 + 1;
          }

          if (document[index]["docList"][0]["gpsTrakerDate"] == null) {
            number123 = number123 + 1;
          }
          if (document[index]["docList"][0]["nationalPermitDate"] == null) {
            number123 = number123 + 1;
          }
          if (document[index]["docList"][0]["fiveYearsPermitDate"] == null) {
            number123 = number123 + 1;
          }
          if (document[index]["docList"][0]["pollutionDate"] == null) {
            number123 = number123 + 1;
          }
          if (document[index]["docList"][0]["tokenTaxDate"] == null) {
            number123 = number123 + 1;
          }

          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  
                  Details(
                    vehiclenum: document[index]["vehilceNo"],
                    vid: document[index]["vid"],
                  ).navigateTo(context);
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        offset: const Offset(-6.0, -6.0),
                        blurRadius: 5.0,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(6.0, 6.0),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 33, vertical: 13),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              document[index]["vehilceNo"],
                              style: const TextStyle(fontSize: 17),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              
                              number123 == 7
                                  ? "All 7 Missing":number123==0?"All Added"
                                  : "$number123 Missing",
                              // document[index]["docList"][index]["insuranceDate"]==null?"null":"not",
                              style:  TextStyle(color: number123==0?Colors.grey: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}

class Expiring_Doc extends StatelessWidget {
  const Expiring_Doc({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.006,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 5.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 33, vertical: 13),
                  child: Row(
                    children: const [
                      // Column(
                      //   children: [
                      //     const Text(
                      //       "Bhopal",
                      //       style: TextStyle(fontSize: 17),
                      //     ),
                      //     SizedBox(
                      //       height: MediaQuery.of(context).size.height * 0.01,
                      //     ),
                      //     const Text(
                      //       "5 missing | 2 expiring",
                      //       style: TextStyle(color: Colors.red),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 10,
              // ),
            ],
          );
        },
      ),
    );
  }
}
