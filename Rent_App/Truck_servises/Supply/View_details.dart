import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gpsglobe/Rent_App/Truck_servises/Supply/Supply.dart';
import 'package:gpsglobe/test.dart';

import '../../../Constant.dart';
import 'SelectTheCity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ViewAccptedUserDetails extends StatelessWidget {
//   const ViewAccptedUserDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: const Color.fromARGB(255, 39, 38, 36),
//         title: Text("Details of accepted User"),
//       ),
//       // body: Center(
//       //   child: Column(
//       //     children: [
//       //       GestureDetector(
//       //           onTap: () {
//       //             // Navigator.push(
//       //             //     context,
//       //             //     MaterialPageRoute(
//       //             //       builder: (context) => Select_City(title: "Search The city"),
//       //             //     ));
//       //           },
//       //           child: Text("HIIIIIIIIIIIII"))
//       //     ],
//       //   ),
//       // ),
//     );
//   }
// }

// Color white = Colors.black;
// Color yellow = Color.fromARGB(255, 228, 178, 14);


// class ViewAccptedUserDetails extends StatefulWidget {
//   @override
//   State<ViewAccptedUserDetails> createState() => _ViewAccptedUserDetailsState();
// }

// class _ViewAccptedUserDetailsState extends State<ViewAccptedUserDetails> {
//   // const ViewAccptedUserDetails({super.key});
//   bool accepted = false;

//   @override
//   Widget build(BuildContext context) {

    


//     return Scaffold(
//       // backgroundColor: const Color.fromARGB(255, 3, 58, 61),
//       // backgroundColor: const Color.fromARGB(255, 11, 36, 43),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 11, 36, 43),
//         title: const Text("Details of Truck"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Center(
//               //   child: SizedBox(
//               //       height: 150,
//               //       width: width(context) * 0.5,
//               //       child: Image.asset(
//               //         "images/gpslogo1.png",
//               //       )),
//               // ),
//               const Divider(),
//               Text(
//                 "From",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
//                 style: TextStyle(color: white),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "To",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
//                 style: TextStyle(color: white),
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Text(
//                 "Available Vehicle",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Truck (19 FT 6-9 Ton)",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: white),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Date:",
//                 style: TextStyle(color: yellow, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "22/02/2022",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: white),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Text(
//                 "Amount(Rs)",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: yellow),
//               ),
//               Text(
//                 "2500",
//                 style: TextStyle(color: white),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Text("Vehicle Owner/Driver Name",
//                   style: TextStyle(fontWeight: FontWeight.bold, color: yellow)),
//               Text(
//                 "sharuk khan",
//                 style: TextStyle(color: white),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),

//               MaterialButton(
//                 minWidth: width(context),
//                 height: 40,
//                 color: Colors.green,
//                 onPressed: () {
//                   accepted = true;
//                   setState(() {
                    
//                   });
//                 },
//                 child:  Text(
//                 accepted==false?  "Accept":"Accepted",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),

//               accepted == true
//                   ? MaterialButton(
//                       minWidth: width(context),
//                       height: 40,
//                       color: Colors.green,
//                       onPressed: () {},
//                       child: const Text(
//                         "Connect in WhatsApp",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   : SizedBox(),
//               accepted == true
//                   ? MaterialButton(
//                       minWidth: width(context),
//                       height: 40,
//                       color: Colors.green,
//                       onPressed: () {},
//                       child: const Text(
//                         "Call Customer",
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     )
//                   : SizedBox()
//               // MaterialButton(
//               //   minWidth: width(context),
//               //   height: 40,
//               //   color: Colors.red,
//               //   onPressed: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => Supply(),
//               //         ));
//               //   },
//               //   child: const Text(
//               //     "Cancel",
//               //     style: TextStyle(color: Colors.black),
//               //   ),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




// class AcceptedController extends GetxController {
//   RxBool accepted = false.obs;

//   void accept() {
//     accepted.value = true;
//   }
// }

// class ViewAccptedUserDetails extends StatelessWidget {
//   final AcceptedController _controller = Get.put(AcceptedController());

//   @override
//   Widget build(BuildContext context) {
//     bool accepted = _controller.accepted.value;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 11, 36, 43),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 11, 36, 43),
//         title: const Text("Details of Truck"),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: SizedBox(
//                   height: 150,
//                   width: MediaQuery.of(context).size.width * 0.5,
//                   child: Image.asset(
//                     "images/gpslogo1.png",
//                   ),
//                 ),
//               ),
//               const Divider(),
//               Text(
//                 "From",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
//                 style: TextStyle(color: Colors.black),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "To",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Globe GPS Technologies Pvt Ltd Ananda Complex 8th Mile, Site NO. 137/1.2nd floor Opp.Indian oil petrol Bunk, T Dasarahalli Bangalore :560057",
//                 style: TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 "Available Vehicle",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Truck (19 FT 6-9 Ton)",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Date:",
//                 style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 "22/02/2022",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 "Amount(Rs)",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
//               ),
//               Text(
//                 "2500",
//                 style: TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 "Vehicle Owner/Driver Name",
//                 style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
//               ),
//               Text(
//                 "sharuk khan",
//                 style: TextStyle(color: Colors.white),
//               ),
//               const SizedBox(height: 30),
//               MaterialButton(
//                 minWidth: MediaQuery.of(context).size.width,
//                 height: 40,
//                 color: Colors.green,
//                 onPressed: () {
//                   _controller.accept();
//                 },
//                 child: const Text(
//                   "Accept",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               Obx(() {
//                 return accepted
//                     ? MaterialButton(
//                         minWidth: MediaQuery.of(context).size.width,
//                         height: 40,
//                         color: Colors.green,
//                         onPressed: () {},
//                         child: const Text(
//                           "Connect in WhatsApp",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     : SizedBox();
//               }),
//               Obx(() {
//                 return accepted
//                     ? MaterialButton(
//                         minWidth: MediaQuery.of(context).size.width,
//                         height: 40,
//                         color: Colors.green,
//                         onPressed: () {},
//                         child: const Text(
//                           "Call Customer",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       )
//                     : SizedBox();
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

