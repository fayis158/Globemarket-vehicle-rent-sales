import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  Details({super.key, required this.vehiclenum, required this.vid});
  var vehiclenum;
  var vid;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Map? insurancedata;
  Map? fitness;
  Map? nationalpermitdata;
  Map? fiveYearsPermit;
  Map? pollution;
  Map? tokentax;
  Map? gpsdevice;

  bool isloading = false;

  //ui api call (not getting answer when i try to call in outside the ui)
  static Future getXorProvider(vid, type) async {
    Map uploadeddsate;
    final result = await http.get(Uri.parse(
        "http://globalgps.in:8089/api/v1/NewDevice/GetDocument/$vid/$type"));
    if (result.statusCode == 200) {
      // Map<String, dynamic> json = jsonDecode(jsonString);
      uploadeddsate = jsonDecode(result.body);
      return uploadeddsate;
    } else {
      return {};
    }
  }

  DateTime Datenow = DateTime.now();
  DateTime? selectedDate;
  Future<void> _selectDate(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  DateTime? selectedDate1;
  Future<void> _selectDate1(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate1) {
      setState(() {
        selectedDate1 = picked;
      });
    }
  }

  DateTime? selectedDate2;
  Future<void> _selectDate2(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate2) {
      setState(() {
        selectedDate2 = picked;
      });
    }
  }

  DateTime? selectedDate3;
  Future<void> _selectDate3(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate3) {
      setState(() {
        selectedDate3 = picked;
      });
    }
  }

  DateTime? selectedDate4;
  Future<void> _selectDate4(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate4) {
      setState(() {
        selectedDate4 = picked;
      });
    }
  }

  DateTime? selectedDate5;
  Future<void> _selectDate5(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate5) {
      setState(() {
        selectedDate5 = picked;
      });
    }
  }

  DateTime? selectedDate6;
  Future<void> _selectDate6(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate6) {
      setState(() {
        selectedDate6 = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    insur();
  }

  insur() async {
    insurancedata = await getXorProvider(widget.vid, "insurance");
    fitness = await getXorProvider(widget.vid, "Fitness");
    nationalpermitdata = await getXorProvider(widget.vid, "NationalPermit");
    fiveYearsPermit = await getXorProvider(widget.vid, "5YearsPermit");
    pollution = await getXorProvider(widget.vid, "Pollution");
    tokentax = await getXorProvider(widget.vid, "TokenTax");
    gpsdevice = await getXorProvider(widget.vid, "GPSTraker");
    setState(() {
      isloading = true;
    });
  }
  
 DateTime now = DateTime.now();
 
 
  compare(){
    String dateString = insurancedata!['result']['date'];
    DateTime date = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.vehiclenum),
          actions: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home))
          ],
        ),
        body: isloading == false && insurancedata == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "insurance".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate != null
                                    ? Text(selectedDate.toString())
                                    : insurancedata!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${insurancedata!['result']['date'].toString()}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _selectDate(context);
                                  Api.uploaddocuments(
                                      widget.vid, "Insurance", selectedDate);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "fitness".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate2 != null
                                    ? Text(selectedDate2.toString())
                                    : fitness!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${fitness!['result']['date'].toString().substring(0, 10)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate1(context);
                                  Api.uploaddocuments(
                                      widget.vid, "Fitness", selectedDate1);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "nationalpermit".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate3 != null
                                    ? Text(selectedDate3.toString())
                                    : nationalpermitdata!['result']['date'] !=
                                            null
                                        ? Text(
                                            "Expired On:${nationalpermitdata!['result']['date'].toString().substring(0,9)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate2(context);
                                  Api.uploaddocuments(widget.vid,
                                      "NationalPermit", selectedDate2);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "yearpermit".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate4 != null
                                    ? Text(selectedDate4.toString())
                                    : fiveYearsPermit!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${fiveYearsPermit!['result']['date'].toString().substring(0, 10)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate3(context);
                                  Api.uploaddocuments(widget.vid,
                                      "5YearsPermit", selectedDate3);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "pollution".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate5 != null
                                    ? Text(selectedDate5.toString())
                                    : pollution!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${pollution!['result']['date'].toString().substring(0, 10)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate4(context);
                                  Api.uploaddocuments(widget.vid,
                                      "5YearsPermit", selectedDate4);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "tokentax".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate6 != null
                                    ? Text(selectedDate6.toString())
                                    : tokentax!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${tokentax!['result']['date'].toString().substring(0, 10)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not Submitted")

                                // selectedDate5 == null
                                //     ? const Text("Not Submitted")
                                //     : Text(
                                //         selectedDate5.toString(),
                                //         style:
                                //             const TextStyle(color: Colors.red),
                                //       ),
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate5(context);
                                  Api.uploaddocuments(
                                      widget.vid, "TokenTax", selectedDate5);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 238, 238, 238),
                            offset: Offset(
                              5.0,
                              5.0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "gpsdevice".tr(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                selectedDate6 != null
                                    ? Text(selectedDate6.toString())
                                    : gpsdevice!['result']['date'] != null
                                        ? Text(
                                            "Expired On:${gpsdevice!['result']['date'].toString().substring(0, 10)}",
                                            style: const TextStyle(
                                                color: Colors.black))
                                        : const Text("       Not Submitted")
                              ],
                            ),
                            MaterialButton(
                              color: Colors.green,
                              child: const Text(
                                "SET",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectDate6(context);
                                  Api.uploaddocuments(
                                      widget.vid, "GPSTraker", selectedDate5);
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}

// class Element_container extends StatelessWidget {
//   const Element_container({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
