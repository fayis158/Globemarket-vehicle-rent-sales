import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:gpsglobe/global/global.dart';
import 'Api_Truck_service/ApiT.dart';
// import 'package:testing/register.dart';
// import 'package:flutter_otp_verification_ui/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRent extends StatefulWidget {
  const LoginRent({Key? key}) : super(key: key);

  @override
  _LoginRentState createState() => _LoginRentState();
}

class _LoginRentState extends State<LoginRent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'rentimages/loginimage.jpeg',
                  width: 240,
                ),
                const SizedBox(
                  height: 18,
                ),
                const Text(
                  "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Never a better time than now to start.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 38,
                ),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Navigator.of(context).push(
                //       //   MaterialPageRoute(builder: (context) => Register()),
                //       // );
                //     },
                //     style: ButtonStyle(
                //       foregroundColor:
                //           MaterialStateProperty.all<Color>(Colors.white),
                //       backgroundColor:
                //           MaterialStateProperty.all<Color>(Colors.purple),
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(24.0),
                //         ),
                //       ),
                //     ),
                //     child: const Padding(
                //       padding: EdgeInsets.all(14.0),
                //       child: Text(
                //         'Create Account',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 22,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(Register());
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController namecontrolleer = TextEditingController();
  final ApiController anotherPageController = Get.put(ApiController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'rentimages/log.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add your phone number. we'll send you a verification code ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: namecontrolleer,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: "Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a 2-digit number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      TextFormField(
                        maxLength: 10,
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: numbercontroller,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                            hintText: "Mobile Number",
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            prefix: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '(+91)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            suffixIcon: numbercontroller.text.length == 10
                                ? const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 32,
                                  )
                                : const Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 47, 47, 47),
                                    size: 32,
                                  )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a 10-digit number';
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() == true) {
                              anotherPageController.callloginotp(
                                  numbercontroller.text, namecontrolleer.text);

                              Get.to(() => Otp(
                                    controllervalue: numbercontroller.text,
                                  ));
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.purple),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16),
                            ),
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
      ),
    );
  }
}

class Otp extends StatefulWidget {
  Otp({Key? key, required this.controllervalue}) : super(key: key);
  String controllervalue;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  // TextEditingController otpController = TextEditingController();
  List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final ApiT myController2 = Get.find();

  final ApiController anotherPageController = Get.put(ApiController());

  int _start = 20;
  Timer? _timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'rentimages/otp.png',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                            first: true,
                            last: false,
                            controller: otpControllers[0]),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: otpControllers[1]),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            controller: otpControllers[2]),
                        _textFieldOTP(
                            first: false,
                            last: true,
                            controller: otpControllers[3]),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // anotherPageController.otpverify();
                          startTimer();
                          String otpValue = otpControllers
                              .map((controller) => controller.text)
                              .join();
                          await anotherPageController.otpverify(
                              otpValue, widget.controllervalue);
                          await anotherPageController.mainpageapi();

                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setString(
                                'isLoggedInforrent', widget.controllervalue);
                          });

                          dynamic firstElement =
                              myController2.mainuserdata[0] ?? [{}];
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.setInt('rentuid', firstElement["uid"] ?? 0);
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          rentmobilenum =
                              (prefs.getString("isLoggedInforrent") ?? "");
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.purple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              _start == 0 ? const SizedBox() : Text("Resend Code in $_start"),
              const SizedBox(
                height: 6,
              ),
              _start != 0
                  ? const Text(
                      "Resend New Code",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                      textAlign: TextAlign.center,
                    )
                  : GestureDetector(
                      onTap: () async {
                        String otpValue = otpControllers
                            .map((controller) => controller.text)
                            .join();
                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setString(
                              'isLoggedInforrent', widget.controllervalue);
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        rentuid = prefs.getInt("rentuid")!;
                        rentmobilenum =
                            (prefs.getString("isLoggedInforrent") ?? "");
                        await anotherPageController.otpverify(
                            otpValue, widget.controllervalue);
                        await anotherPageController.mainpageapi();

                        dynamic firstElement =
                            myController2.mainuserdata[0] ?? [{}];

                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setInt('rentuid', firstElement["uid"] ?? 0);
                        });

                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setString(
                              'expiredate',
                              firstElement["expiryDate"] ??
                                  "14-Jul-2023 06:16:26 PM");
                        });

                        SharedPreferences.getInstance().then((prefs) {
                          prefs.setBool(
                              'typeofuser', firstElement["userVerify"]);
                        });
                      },
                      child: const Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first, last, required TextEditingController controller}) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width * 0.15,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: controller,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: Colors.purple),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
