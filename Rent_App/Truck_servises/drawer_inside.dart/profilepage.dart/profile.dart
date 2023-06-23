import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Api_Truck_service/controller.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Rent_Home_Page.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/Supply.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/drawer_inside.dart/subscription/subscription.dart';
import 'package:gpsglobe/global/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Api_Truck_service/ApiT.dart';
import '../../movablebutton.dart';

class ProfileController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);

  void setImage(File image) {
    selectedImage.value = image;
  }

  File? get image => selectedImage.value;
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileController profileController;
  final picker = ImagePicker();

  final ApiController anotherPageController = Get.put(ApiController());
  // final TermsAndConditionsController _controller =
  //     Get.put(TermsAndConditionsController());
  bool tandCaccornot = false;
  dynamic firstElement;
  String path = "";
  @override
  void initState() {
    super.initState();

    anotherPageController.mainpageapi();
    profileController = Get.put(ProfileController());
    firstElement = myController2.mainuserdata[0] ?? [{}];
    _namecontroller.text = firstElement["name"];
    _emailController.text = firstElement["emailId"];
    transportname.text = firstElement["companyName"];
    phonenum.text = "${firstElement["mobile"]}  (Not Editable)";
    whatsappnum.text = firstElement["whatsApp"];
    addresscontroller.text = firstElement["address"].toString();
    path = firstElement["path"];
    tandCaccornot = firstElement["termsCondition"];
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailController.dispose();
    transportname.dispose();
    phonenum.dispose();
    whatsappnum.dispose();
    addresscontroller.dispose();
  }

  File? image;
  String? imagePath;

  String base64imageaddress = '';

  // Future<void> getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       image = File(pickedFile.path);
  //       saveProfileImage(image!);
  //       profileController.setImage(image!);
  //     });
  //   }
  // }

  // Future<void> saveProfileImage(File image) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final fileName = path.basename(image.path);
  //   final savedImage = await image.copy('${directory.path}/$fileName');
  //   setState(() {
  //     imagePath = savedImage.path;
  //     saveImagePathToPreferences(imagePath!);
  //   });
  // }

  // Future<void> saveImagePathToPreferences(String imagePath) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('imagePath', imagePath);
  // }

  // Future<void> loadProfile() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedImagePath = prefs.getString('imagePath');

  //   if (savedImagePath != null && savedImagePath.isNotEmpty) {
  //     setState(() {
  //       imagePath = savedImagePath;
  //     });
  //   }
  // }

  // Future<String?> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   print(image);

  //   if (image != null) {
  //     final List<int> imageBytes = await image.readAsBytes();
  //     final String base64Image = base64Encode(imageBytes);
  //     return base64Image;
  //   }

  //   return null;
  // }

  String fileNameforprof = '';

  // Future<String?> pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     final List<int> imageBytes = await image.readAsBytes();
  //     final String base64Image = base64Encode(imageBytes);

  //     final String fileName = image.path.split('/').last;
  //     fileNameforprof = fileName;
  //     print('File Name: $fileName');
  //     return base64Image;
  //   }

  //   return null;
  // }

  String? base64Image;

  Future<String?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final List<int> imageBytes = await file.readAsBytes();
      base64Image = base64Encode(imageBytes);

      base64imageaddress = base64Image!;

      final String fileName = image.path.split('/').last;
      fileNameforprof = fileName;

      Uint8List hi = base64Decode(base64Image!);

      setState(() {});
      return base64Image;
    }
  }

  // String? base64Image;
  // ImageProvider? decodedImage;

  // Future pickImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     final List<int> imageBytes = await image.readAsBytes();
  //     // base64Image = base64Encode(imageBytes);
  //     String base64Image = "data:image/png;base64,${base64Encode(imageBytes)}";
  //     print("12122 $base64Image");
  //     // String hi = base64Decode(base64Image) as String;
  //     print(base64Decode(base64Image) as String);
  //     setState(() {});
  //   }
  // }

  final ApiT myController2 = Get.find();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController transportname = TextEditingController();
  TextEditingController phonenum = TextEditingController();
  TextEditingController whatsappnum = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final RxBool termsAgreed = false.obs;

  void toggleTermsAgreement() {
    termsAgreed.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_formKey.currentState!.validate()) {
          return Future.value(true);
        } else {
          navigator!.pop(context);
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 39, 38, 36),
          title: const Text('My Profile'),
          leading: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(() => Supply());
                }
              },
              icon: Icon(Icons.arrow_back)),
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Get.to(edit());
          //       },
          //       icon: const Icon(Icons.edit))
          // ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    // onTap: pickImage,
                    onTap: () async {
                      final String? base64Image = await pickImage();

                      if (base64Image != null) {
                        base64imageaddress = base64Image;
                        // String hi = base64Decode(base64Image) as String;

                      } else {
                        print('Image picking canceled or failed.');
                      }
                    },
                    child: CircleAvatar(
                      radius: 64,
                      backgroundImage: imagePath != null
                          ? FileImage(File(imagePath!))
                              as ImageProvider<Object>?
                          : NetworkImage(path),
                      child: const Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 16,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ),
                    ),

                    //  CircleAvatar(
                    //   radius: 64,
                    //   backgroundImage: imagePath != null
                    //       ? FileImage(File(imagePath!)) as ImageProvider<Object>?
                    //       : const AssetImage('rentimages/profile.png'),
                    //   child: const Align(
                    //     alignment: Alignment.bottomRight,
                    //     child: CircleAvatar(
                    //       backgroundColor: Colors.white,
                    //       radius: 16,
                    //       child: Icon(
                    //         Icons.edit,
                    //         color: Colors.black,
                    //         size: 16,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     final String? base64Image = await pickImage();
                  //     if (base64Image != null) {
                  //       // Handle the base64 image data
                  //       print(base64Image);
                  //     } else {
                  //       // Image picking was canceled or failed
                  //       print('Image picking canceled or failed.');
                  //     }
                  //   },
                  //   child: const Text('Pick Image'),
                  // ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 8),
                  Text(
                    _emailController.text,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: TextFormField(
                      controller: _namecontroller,
                      decoration: const InputDecoration(
                        hintText: "Name",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.business),
                    title: TextFormField(
                      controller: transportname,
                      decoration: const InputDecoration(
                        hintText: 'Transport Name or company Name (optional)',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: TextFormField(
                      enabled: false,
                      controller: phonenum,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.whatsapp),
                    title: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                      controller: whatsappnum,
                      decoration: const InputDecoration(
                        hintText: 'Whats App Number',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        } else if (value.length != 10) {
                          return 'Invalid Number';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: TextFormField(
                      maxLines: 3,
                      controller: addresscontroller,
                      decoration: const InputDecoration(
                        hintText: 'address',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null; // Return null if the input is valid
                      },
                    ),
                  ),
                  tandCaccornot == false
                      ? Obx(
                          () => CheckboxListTile(
                            title: Text.rich(
                              TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'I agree to the ',
                                  ),
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(Uri.parse(
                                            'https://www.globalgps.in/terms.aspx'));
                                      },
                                  ),
                                ],
                              ),
                            ),
                            value: termsAgreed.value,
                            onChanged: (value) {
                              toggleTermsAgreement();
                            },
                          ),
                        )
                      : CheckboxListTile(
                          title: Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(
                                  text: 'I agree to the ',
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    // Add any other text style properties you desire
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(Uri.parse(
                                          'https://www.globalgps.in/terms.aspx'));
                                    },
                                ),
                              ],
                            ),
                          ),
                          value: true,
                          onChanged: (value) {
                            // toggleTermsAgreement();
                          },
                        ),

                  // Obx(
                  //   () => CheckboxListTile(
                  //     title: const Text.rich(
                  //       TextSpan(
                  //         children: [
                  //           TextSpan(
                  //             text: 'I agree to the ',
                  //           ),
                  //           TextSpan(
                  //             text: 'Terms and Conditions',
                  //             style: TextStyle(
                  //               color: Colors.blue,
                  //               // Add any other text style properties you desire
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     value: termsAgreed.value,
                  //     onChanged: (value) {
                  //       toggleTermsAgreement();
                  //     },
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          if (termsAgreed.value == true ||
                              tandCaccornot == true) {
                            if (_formKey.currentState!.validate()) {
                              await anotherPageController.profilepost(
                                  rentuid,
                                  _namecontroller.text,
                                  transportname.text,
                                  _emailController.text,
                                  whatsappnum.text,
                                  addresscontroller.text,
                                  fileNameforprof,
                                  base64imageaddress,
                                  termsAgreed.value);

                              await anotherPageController.mainpageapi();
                              // setState(() {});

                              Get.snackbar(
                                "",
                                "",
                                titleText: const Text(
                                  "Profile Updated",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                messageText: const Text(
                                  "Successfully Updated Your profile",
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                              setState(() {});
                            }
                          } else {
                            Get.snackbar("Missing",
                                "Please Agree to Terms and condition ",
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            width: MediaQuery.of(context).size.width * 0.5,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.yellow,
                                    Colors.green,
                                  ]),
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text(""),
                                const Text(
                                  "Save Changes",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: const Icon(
                                      Icons.save,
                                      size: 25.0,
                                      color: Colors.green,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     if (_controller.termsAgreed.value) {
                      //       // Terms agreed, proceed with the action
                      //       // Add your logic here
                      //       Get.to(() => ProfilePage());
                      //     } else {
                      //       // Terms not agreed, show an error message
                      //       Get.dialog(
                      //         AlertDialog(
                      //           title: const Text('Error'),
                      //           content: const Text(
                      //               'Please agree to the terms and conditions.'),
                      //           actions: [
                      //             ElevatedButton(
                      //               child: const Text('OK'),
                      //               onPressed: () {
                      //                 Get.back();
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   child: const Text('Submit'),
                      // ),
                      // TextButton(
                      //     onPressed: () {
                      //       Get.to(() => MyImagePicker());
                      //     },
                      //     child: Text("testing"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//gst tall 7026623139
//others , 8296111444

//hlo

class MyImagePicker extends StatefulWidget {
  @override
  _MyImagePickerState createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  String? base64Image;

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final File file = File(image.path);
      final List<int> imageBytes = await file.readAsBytes();
      base64Image = base64Encode(imageBytes);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            base64Image != null
                ? Image.memory(
                    base64Decode(base64Image!),
                    height: 200,
                  )
                : const Text('No Image Selected'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: pickImage,
              child: const Text('Pick Image'),
            ),
          ],
        ),
      ),
    );
  }
}

// class TermsAndConditionsController extends GetxController {
//   RxBool termsAgreed = false.obs;

//   void toggleTermsAgreement(bool value) {
//     termsAgreed.value = value;
//   }
// }


//https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3  audio


// class AudioPlayerScreen extends StatelessWidget {
//   final String audioUrl = 'https://example.com/audio.mp3'; // Replace with the URL of the audio file
//   final AudioPlayer audioPlayer = AudioPlayer();
//   final AudioCache audioCache = AudioCache();

//   Future<void> playAudioFromUrl(String url) async {
//     int result =  audioPlayer.play(url);
//     if (result == 1) {
//       // success
//       print('Audio played successfully');
//     }
//   }

//   void pauseAudio() {
//     audioPlayer.pause();
//   }

//   void resumeAudio() {
//     audioPlayer.resume();
//   }

//   void stopAudio() {
//     audioPlayer.stop();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Audio Player'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             FlatButton(
//               onPressed: () {
//                 playAudioFromUrl(audioUrl);
//               },
//               child: Text('Play Audio'),
//             ),
//             FlatButton(
//               onPressed: pauseAudio,
//               child: Text('Pause Audio'),
//             ),
//             FlatButton(
//               onPressed: resumeAudio,
//               child: Text('Resume Audio'),
//             ),
//             FlatButton(
//               onPressed: stopAudio,
//               child: Text('Stop Audio'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }