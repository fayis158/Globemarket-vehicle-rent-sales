import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../Api/api.dart';

Map contactus = {};

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController typec = TextEditingController();

  late Future<List<String>> futureNumbersList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureNumbersList = NumberGenerator().slowNumbers();
  }

  @override
  void dispose() {
    super.dispose();
    typec.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeh = MediaQuery.of(context).size.height;
    var sizew = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.green, title: Text("contactus".tr())),
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                marquee(),
                SizedBox(
                  height: sizeh * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Image.asset(
                          "images/gpslogo1.png",
                        )),
                  ],
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Text(
                  "Globe Gps",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.7,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
                  child: Row(
                    children: [
                      Text(
                        "name".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        "${'companyname'.tr()}",
                        // "companyname".tr(),
                        style: TextStyle(fontSize: 15),
                      ),

                      // Text(
                      //   "     Globe GPS Technologies",
                      //   style: TextStyle(fontSize: 17),
                      // )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.6,
                  thickness: 1,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "address".tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(
                            height: sizeh * 0.07,
                          )
                        ],
                      ),
                      Container(
                        // height: sizeh * 0.1,
                        width: sizew * 0.6,
                        child: Text("companyaddres".tr()),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.7,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
                  child: Row(
                    children: [
                      Text(
                        "website".tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () =>
                            launchUrl(Uri.parse('https://www.globalgps.in/')),
                        child: const Text(
                          'www.globalgps.in',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.7,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
                  child: Row(
                    children: [
                      Text(
                        "support".tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "+91-9148998994",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.7,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizew * 0.06),
                  child: Row(
                    children: [
                      Text(
                        "email".tr(),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "support@globalgps.in",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                const Divider(
                  color: Color.fromARGB(255, 202, 201, 201),
                  height: 0.7,
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                Form(
                  // key: _formKeyusername,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizew * 0.065),
                    child: Container(
                      child: TextFormField(
                        maxLines: 6,
                        controller: typec,
                        decoration: InputDecoration(
                          labelText: 'Type Your Message here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter a Username';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizeh * 0.02,
                ),
                GestureDetector(




                  onTap: () async {
                    contactus =
                        await Api.ContactUs(finalUid.toString(), typec.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(contactus["messages"])),
                    );
                    typec.clear();
                  },



                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: sizew * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 10, 121, 6)),
                    child: const Center(
                        child: Text(
                      "Send Message",
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                SizedBox(
                  height: 12,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Floatingaction_button(),
    );
  }

  Future<void> _pullRefresh() async {
    List<String> freshNumbers = await NumberGenerator().slowNumbers();
    setState(() {
      futureNumbersList = Future.value(freshNumbers);
    });
  }
}

class NumberGenerator {
  Future<List<String>> slowNumbers() async {
    return Future.delayed(
      const Duration(milliseconds: 1000),
      () => numbers,
    );
  }

  List<String> get numbers => List.generate(5, (index) => number);

  String get number => Random().nextInt(99999).toString();
}
