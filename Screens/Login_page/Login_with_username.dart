// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Api/api.dart';
import 'package:gpsglobe/Constant.dart';
import 'package:gpsglobe/Screens/Home_page/Home_page.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:gpsglobe/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Rent_App/Truck_servises/Rent_Home_Page.dart';
import '../../Rent_App/Truck_servises/login.dart';

List<dynamic> logindata = [];
bool obstext = false;

class Login_with_username extends StatefulWidget {
  const Login_with_username({Key? key}) : super(key: key);

  @override
  _Login_with_usernameState createState() => _Login_with_usernameState();
}

class _Login_with_usernameState extends State<Login_with_username> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  TextEditingController usernamec = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  homedatacoming() async {
    Homepagedatasmap = await Api.homepagedata();
    filteredData = await Api.homepagedata();

    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    homedatacoming();
  }

  @override
  void dispose() {
    super.dispose();
    usernamec.dispose();
    passwordcontroller.dispose();
  }

  void showAlertDialog(var title, var message) {
    Get.defaultDialog(
      title: title, // Title of the dialog
      middleText: message, // Message of the dialog
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Background color of the dialog
      radius: 10.0, // Radius of the dialog corners
      barrierDismissible:
          false, // Set to true if you want to dismiss the dialog by tapping outside
      // You can also customize other properties such as contentPadding, actions, confirm, cancel, etc.
      confirm: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () {
              launch("tel://7026623139");
              Get.back(); // Close the dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text('Call 1'),
          ),
          ElevatedButton(
            onPressed: () {
              launch("tel://8296111444");
              Get.back(); // Close the dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
            child: const Text('Call 2'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(255, 62, 128, 154)),
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
              content: Container(
            height: 115,
            child: Column(
              children: [
                const Text(
                    "Invalid Username or Password. please contact customer care if you face login issues: 984 4646 555"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok")),
                  ],
                )
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              // Container(height: 20,width: 20,color: Colors.red,),
              Container(
                // padding: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.38),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.1,
                          color: const Color.fromARGB(255, 62, 60, 60),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 101, 178, 242),
                                          Color.fromARGB(200, 80, 140, 200),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Vehicle",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                            ),
                                            Text(
                                              "Sales",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.to(const LoginRent());
                                },
                                child: Container(
                                  height: 130,
                                  width: 90,
                                  // decoration: const BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         begin: Alignment.topCenter,
                                  //         end: Alignment.bottomCenter,
                                  //         colors: [
                                  //           Colors.purple,
                                  //           Color.fromARGB(255, 44, 243, 33),

                                  //         ],
                                  //       ),
                                  //     ),
                                  color: const Color.fromARGB(255, 91, 178, 94),

                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                  )),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.1,
                          color: const Color.fromARGB(255, 62, 60, 60),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 101, 178, 242),
                                          Color.fromARGB(200, 80, 140, 200),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Vehicle",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                            Text(
                                              "Rent",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.to(const LoginRent());
                                },
                                child: Container(
                                  height: 130,
                                  width: 90,
                                  // decoration: const BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         begin: Alignment.topCenter,
                                  //         end: Alignment.bottomCenter,
                                  //         colors: [
                                  //           Colors.purple,
                                  //           Color.fromARGB(255, 44, 243, 33),

                                  //         ],
                                  //       ),
                                  //     ),
                                  color: const Color.fromARGB(255, 91, 178, 94),

                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  )),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.1,
                          color: const Color.fromARGB(255, 62, 60, 60),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 101, 178, 242),
                                          Color.fromARGB(200, 80, 140, 200),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Site",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                            Text(
                                              "Sales",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.to(const LoginRent());
                                },
                                child: Container(
                                  height: 130,
                                  width: 90,
                                  // decoration: const BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         begin: Alignment.topCenter,
                                  //         end: Alignment.bottomCenter,
                                  //         colors: [
                                  //           Colors.purple,
                                  //           Color.fromARGB(255, 44, 243, 33),

                                  //         ],
                                  //       ),
                                  //     ),
                                  color: const Color.fromARGB(255, 91, 178, 94),

                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  )),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.1,
                          color: const Color.fromARGB(255, 62, 60, 60),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 101, 178, 242),
                                          Color.fromARGB(200, 80, 140, 200),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Buy",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            ),
                                            Text(
                                              "GPS",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.04),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () {
                                  Get.to(const LoginRent());
                                },
                                child: Container(
                                  height: 130,
                                  width: 90,
                                  // decoration: const BoxDecoration(
                                  //       gradient: LinearGradient(
                                  //         begin: Alignment.topCenter,
                                  //         end: Alignment.bottomCenter,
                                  //         colors: [
                                  //           Colors.purple,
                                  //           Color.fromARGB(255, 44, 243, 33),

                                  //         ],
                                  //       ),
                                  //     ),
                                  color: const Color.fromARGB(255, 91, 178, 94),

                                  child: Center(
                                      child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                  )),
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 35, right: 35),
                      child: Form(
                        key: _formKey1,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: usernamec,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                  labelText: "For GPS Users",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Username",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: passwordcontroller,
                              style: const TextStyle(),
                              obscureText: obstext ? false : true,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obstext = !obstext;
                                        });
                                      },
                                      icon: obstext == true
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off)),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the field';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: () async {
                                    if (_formKey1.currentState!.validate()) {
                                      logindata = await Api.userLogin(
                                        usernamec.text,
                                        passwordcontroller.text,
                                      );

                                      if (logindata.isNotEmpty) {
                                        finalUid = logindata[0]["uid"];
                                        finalUserName =
                                            logindata[0]["firstName"];
                                        mobilenumber = logindata[0]["mobileNo"];
                                        owneraddress = logindata[0]["address"];

                                        //     strore uid
                                        SharedPreferences.getInstance()
                                            .then((prefs) {
                                          prefs.setInt('isLoggedIn', finalUid);
                                          prefs.setString(
                                              "isUserName", finalUserName);
                                          prefs.setString(
                                              "mobilenumber", mobilenumber);
                                          prefs.setString(
                                              "owneraddress", owneraddress);
                                          prefs.setString(
                                              "userid", usernamec.text);
                                        });

                                        userid = usernamec.text;
                                        homedatacoming();

                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  TabBarDemo()),
                                        );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        buildLanguageDialog(context);
                                      }
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            ),
                            SizedBox(
                              height: height(context) * 0.08,
                            ),
                            Table(
                              children: [
                                TableRow(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: GestureDetector(
                                        onTap: () => showAlertDialog(
                                            "Java Training",
                                            "To know more information Please Contact us"),
                                        child: Container(
                                          height: 100,
                                          color: const Color.fromARGB(
                                              255, 39, 57, 54),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Java",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Training",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: GestureDetector(
                                        onTap: () => showAlertDialog(
                                            "GST Tally Training ",
                                            "To know more information Please Contact us"),
                                        child: Container(
                                          height: 100,
                                          color: const Color.fromARGB(
                                              255, 95, 74, 202),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "GST",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Tally",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Training",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(
                                              "IOS And Android training",
                                              "To know more information Please Contact us");
                                        },
                                        child: Container(
                                          height: 100,
                                          color: const Color.fromARGB(
                                              255, 199, 171, 71),
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "IOS",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Android",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    Text(
                                                      "Training",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height(context) * 0.05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            'https://www.globalgps.in/'));
                                      },
                                      child: const CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.green,
                                        child: Text(
                                          "http://",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () => launchUrl(Uri.parse(
                                          'https://www.instagram.com/')),
                                      child: CircleAvatar(
                                        radius: 28,
                                        child: Image.asset(
                                          "images/instagram.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    logindata = await Api.userLogin(
                                      "test",
                                      "test",
                                    );
                                    if (logindata.isNotEmpty) {
                                      // print(
                                      //     "iPhone which is in Tumkuru , Banglore karnataka is now connecting 68% Completed");
                                      finalUid = logindata[0]["uid"];
                                      finalUserName = logindata[0]["firstName"];
                                      mobilenumber = logindata[0]["mobileNo"];
                                      owneraddress = logindata[0]["address"];
                                      //     strore uid
                                      SharedPreferences.getInstance()
                                          .then((prefs) {
                                        prefs.setInt('isLoggedIn', finalUid);
                                        prefs.setString(
                                            "isUserName", finalUserName);
                                        prefs.setString(
                                            "mobilenumber", mobilenumber);
                                        prefs.setString(
                                            "owneraddress", owneraddress);
                                        prefs.setString("userid", "test");
                                      });
                                      homedatacoming();
                                      // ignore: use_build_context_synchronously
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                TabBarDemo()),
                                      );
                                    } else {}
                                  },
                                  child: const CircleAvatar(
                                    radius: 25,
                                    child: Text("Demo"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => launchUrl(Uri.parse(
                                          ' https://m.facebook.com/profile.php?id=100071401291190&eav=AfbGb5oG_nqYxGXn7Z1Vkj4WIGsODbHhjNpcWH4YgBK_4ZpyXWseXbP50rd1Mfftzu0&paipv=0&_rdr,')),
                                      child: const CircleAvatar(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          radius: 22,
                                          child: Center(
                                              child: Icon(
                                            Icons.facebook,
                                            size: 44,
                                            color:
                                                Color.fromARGB(255, 5, 39, 66),
                                          ))),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () => launchUrl(Uri.parse(
                                          'https://youtube.com/@globegpstechnologies5655')),
                                      child: CircleAvatar(
                                        radius: 20,
                                        child: Image.asset(
                                          "images/yout.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
